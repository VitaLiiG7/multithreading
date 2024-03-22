

import UIKit

/// Задача объяснить почему вывелся именно такое порядок в консоле. Теперь Dispatch@ueue.global().async изменить async на sync и объяснить почему консоль отображается именно так. Следующий шаг sync верните на async и с помощью инструмента Thread Sanitizer найдите проблему этого кода и решите ее с помощью private let lockQueue = DispatchQueue(label: "name.lock queue") Task2
class ViewControllerFive: UIViewController {
    // MARK: - Private Properties
    private var name = "Введите имя"
    private let lockQueue = DispatchQueue(label: "name.lock.queue")
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        updateName()
    }
    
    // MARK: - Private Methods
    private func updateName() {
        //  До моих правок, менял async на sync и разницы в консоле не увидел, но в состоянии async выскакивала ошибка фиолетовая, предпологаю что это происходит из-за того что два потока пытаются одновременно получить или изменить значение переменной. Такая ошибка называется состояние гонки
        DispatchQueue.global().async {
            self.lockQueue.async {
                self.name = "I love RM"
                print(Thread.current)
                print(self.name)
            }
        }
        
        lockQueue.sync {
            print(self.name) // Считываем имя из main
        }
    }
}
