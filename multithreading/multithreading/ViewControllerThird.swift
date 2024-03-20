
import UIKit
///Задача  отменяем задачу, когда цикл while досчитает до 5. Расставить флаги из пункта выше в viewDidLoad, например, print (infinity Thread.isExecuting, потом, например, infinity Thread.isFinished) Task2
class ViewControllerThird: UIViewController {
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Создаем и запускаем поток
        let infinityThread = InfinityLoop()
        infinityThread.start()
        print(infinityThread.isExecuting, infinityThread.isCancelled, infinityThread.isFinished)
        // Подождем некоторое время, а затем отменяем выполнение потока
        sleep(5)
        // Отменяем тут
        print(infinityThread.isExecuting, infinityThread.isCancelled, infinityThread.isFinished)
        infinityThread.cancel()
        sleep(1)
        print(infinityThread.isExecuting, infinityThread.isCancelled, infinityThread.isFinished)
    }
    
    /// Используется для создания потока, который будет выполняться в бесконечном цикле, пока счетчик не достигнет значения 30 или пока поток не будет отменен с помощью метода cancel
    class InfinityLoop: Thread {
        // MARK: - Private Properties
        private var counter = 0
        
        // MARK: - Life Cycle
        override func main() {
            while counter < 30 && !isCancelled {
                counter += 1
                print(counter)
                InfinityLoop.sleep(forTimeInterval: 1)
            }
        }
    }
}

