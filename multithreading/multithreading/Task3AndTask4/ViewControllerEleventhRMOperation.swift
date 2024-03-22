//
//  ViewControllerEleventh.swift
//  multithreading
//
//  Created by Виталий Горбунов on 21.03.2024.
//

import UIKit

protocol RMOperationProtocol {
    // Приоритеты
    var priority: DispatchQoS.QoSClass { get }
    // Выполняемый блок
    var completionBlock: (() -> Void)? { get }
    // Завершена ли операция
    var isFinished: Bool { get }
    // Метод для запуска операции
    func start()
}
///N°2 Давайте напишем свой аналог Operation что бы лучше понять его. Реализуйте операцию по протоколу RMOperationProtocol. Реализуйте так что код viewDidLoad работал как положено. Как закончите для сравнения замените RMOperation на Operation из Swift.
class ViewControllerEleventhRMOperation: UIViewController, RMOperationProtocol {
    var priority: DispatchQoS.QoSClass = .unspecified
    var completionBlock: (() -> Void)?
    var isFinished: Bool = false
    
    func start() {
        DispatchQueue.global(qos: priority).async {
            self.isFinished = true
            self.completionBlock?()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let operationFirst = ViewControllerEleventhRMOperation()
        let operationSecond = ViewControllerEleventhRMOperation()
        
        
        operationFirst.priority = .userInitiated
        operationFirst.completionBlock = {
            
            for _ in 0..<50 {
                print(2)
            }
            print(Thread.current)
            print("Операция полностью завершена!")
        }
        
        operationFirst.start()
        operationSecond.priority = .background
        operationSecond.completionBlock = {
            
            for _ in 0..<50 {
                print(1)
            }
            print(Thread.current)
            print("Операция полностью завершена!")
        }
        operationSecond.start()
    }
}
