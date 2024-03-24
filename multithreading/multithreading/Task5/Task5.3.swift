//
//  Task5.swift
//  multithreading
//
//  Created by Виталий Горбунов on 22.03.2024.
//

import UIKit

///Набрать пример руками заменить DispatchQueue.global().async на Task.detached, объяснить в чем разница. Далее поменять у Task.detached приоритет на priority: userInitiated.
class Task5_3: UIViewController {
    override func viewDidLoad() {
            super.viewDidLoad()
        
        print("Task 1 is finished")
       
        DispatchQueue.global().async{
            for i in 0..<50 {
                print(i)
            }
            print("Task 2 is finished")
            print(Thread.current)
        }
        
        print("Task 3 is finished")
    }
}

//DispatchQueue.global().async использует глобальную очередь и предназначен для выполнения асинхронных операций на отдельных потоках, в то время как Task.detached создает и запускает отсоединенную задачу, которая может выполняться на главном акторе или других акторах

// В данном случае если Task.detached поставить приоритет на priority: userInitiated. то ничего не изменится 
