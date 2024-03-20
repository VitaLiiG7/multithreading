
import UIKit

/// Задача Написать какая тут проблема. Набрать пример руками. С помощью Thread Sanitizer найти проблему и описать ее. Поле решить проблему с помощью var lock = NSLock(). Task2 Ответ - Проблема была в том что два потока обращаются одновременно к одной переменной
class ViewControllerSix: UIViewController {
    // MARK: - Private Properties
    private lazy var name = "I love RM"
    private var lock = NSLock()
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        updateName()
    }
    
    // MARK: - Private Methods
    private func updateName() {
        DispatchQueue.global().async {
            self.lock.lock()
            print(self.name) // Считываем имя из global
            self.lock.unlock()
        }
        
        lock.lock()
        print(self.name) // Считываем имя из main
        lock.unlock()
    }
}


