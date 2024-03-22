//
//  ViewControllerTwelfth.swift
//  multithreading
//
//  Created by Виталий Горбунов on 22.03.2024.
//

import UIKit

class ViewControllerTwelfth: UIViewController {

        override func viewDidLoad() {
            super.viewDidLoad()
           
            
            let rmOperationQueue = RMOperationQueue()
            
            let rmOperation1 = ViewControllerEleventhRMOperation()
            rmOperation1.priority = .background
            
            rmOperation1.completionBlock = {
                print(1)
            }
            
            let rmOperation2 = ViewControllerEleventhRMOperation()
            rmOperation2.priority = .userInteractive
            
            rmOperation2.completionBlock = {
                print(2)
            }
            
        
            rmOperationQueue.addOperation(rmOperation1)
            rmOperationQueue.addOperation(rmOperation2)
          
        }
    }

    protocol RMOperationQueueProtocol {
        /// Тут храним пул наших операций
        var operations: [ViewControllerEleventhRMOperation] { get }
        /// Добавляем наши кастомные операции в пул operations
        func addOperation(_ operation: ViewControllerEleventhRMOperation)
        /// Запускаем следующую
        func executeNextOperation()
    }

    // Класс, управляющий очередью операций
final class RMOperationQueue: RMOperationQueueProtocol {
    
        var operations: [ViewControllerEleventhRMOperation] = []

        func addOperation(_ operation: ViewControllerEleventhRMOperation) {
            operations.append(operation)
            executeNextOperation()
        }

        func executeNextOperation() {
            if let nextOperation = operations.first(where: { !$0.isFirstResponder && !$0.isFinished }) {
                /// Тут делаем старт операции
                
                /// Тут рекурсивно запускаем следующую операцию (что такое рекурсия?)
            }
        }
    }
