
import UIKit

/// Задача 1) Выставить правильные приоритеты, чтобы сначала печатали 1, потом 2. 2) Изменить приоритеты: 2 потом 1. 3) Поменять приоритет, чтобы печаталось вперемешку Task2
class ViewControllerFourth: UIViewController {
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // MARK: - Public Properties
        // Создаем и запускаем поток
        let thread1 = ThreadprintDemon()
        let thread2 = ThreadprintAngel()
        
        // Меняем приоритеты
        // Приоритеты, если хотим напечатать сначала все 1 а потом все 2
        // thread1.qualityOfService = .userInitiated
        // thread2.qualityOfService = .background
        
        // Приоритеты, если хотим напечатать сначала все 2 а потом все 1
        // thread1.qualityOfService = .background
        // thread2.qualityOfService = .userInitiated
        
        // Приоритеты, если хотим напечатать сначала все 2 а потом все 1
        thread1.qualityOfService = .utility
        thread2.qualityOfService = .userInteractive
        
        thread1.start()
        thread2.start()
        
    }
    /// Используется для создания, запуска потока и печатати сообщения в консоль
    class ThreadprintDemon: Thread{
        // MARK: - Life Cycle
        override func main() {
            for _ in (0..<100) {
                print("1")
            }
        }
    }
    
    /// Используется для создания, запуска потока и печатати сообщения в консоль
    class ThreadprintAngel: Thread {
        // MARK: - Life Cycle
        override func main() {
            for _ in (0..<100) {
                print("2")
            }
        }
    }
}
