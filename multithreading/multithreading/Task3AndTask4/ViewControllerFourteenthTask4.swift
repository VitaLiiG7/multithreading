//
//  ViewControllerFourteenthTask4.swift
//  multithreading
//
//  Created by Виталий Горбунов on 22.03.2024.
//

import UIKit
/// Проблема  access race  когда две операции хотят выполниться одновременно
//Решение 1 с помощью семафора
//Решение 2 с помощью зависимостей, пока первая не выполнится вторая не начнется 
class ViewControllerFourteenthTask4: UIViewController {

    override func viewDidLoad() {
           super.viewDidLoad()
          
           // Использование
           let threadSafeArray = ThreadSafeArray()
           let operationQueue = OperationQueue()

           let firstOperation = FirstOperation(threadSafeArray: threadSafeArray)
           let secondOperation = SecondOperation(threadSafeArray: threadSafeArray)
            
           secondOperation.addDependency(firstOperation)
           operationQueue.addOperation(firstOperation)
           operationQueue.addOperation(secondOperation)
        
           // Дождитесь завершения операций перед выводом содержимого массива
           operationQueue.waitUntilAllOperationsAreFinished()

           print(threadSafeArray.getAll())
       }
   }

   // Объявляем класс для для синхронизации потоков
   class ThreadSafeArray {
       private var array: [String] = []
       let semafore = DispatchSemaphore(value: 1)
       func append(_ item: String) {
           semafore.wait()
           array.append(item)
           semafore.signal()
       }

       func getAll() -> [String] {
           return array
       }
   }

   // Определяем первую операцию для добавления строки в массив
   class FirstOperation: Operation {
       let threadSafeArray: ThreadSafeArray

       init(threadSafeArray: ThreadSafeArray) {
           self.threadSafeArray = threadSafeArray
       }

       override func main() {
           if isCancelled { return }
           
           threadSafeArray.append("Первая операция")
         
       }
   }

   // Определяем вторую операцию для добавления строки в массив
   class SecondOperation: Operation {
       let threadSafeArray: ThreadSafeArray
       let semafore = DispatchSemaphore(value: 1)

       init(threadSafeArray: ThreadSafeArray) {
           self.threadSafeArray = threadSafeArray
       }

       override func main() {
          
           if isCancelled { return }
           threadSafeArray.append("Вторая операция")
       }
   }
   
