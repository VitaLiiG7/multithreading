//
//  Task5.swift
//  multithreading
//
//  Created by Виталий Горбунов on 22.03.2024.
//

import UIKit
///Наберите задачу. Разберитесь как taskGroup. Добавить в метод printMessage в group 5 строк "Hello", "My", "Road", "Мар", "Group"
class Task5_7: UIViewController {
      override func viewDidLoad() {
              super.viewDidLoad()
          
          Task {
              await printMessage()
          }
      }
    
      func printMessage() async {
          let string = await withTaskGroup(of: String.self) { group -> String in
              // тут добавляем строки в группу
              for item in ["Hello", "My", "Road", "Мар", "Group"] {
                  group.addTask {
                      item
                  }
              }
              
              var collected = [String]()
            
              for await value in group {
                  collected.append(value)
              }
              
              return collected.joined(separator: " ")
          }
          print(string)
      }
}
