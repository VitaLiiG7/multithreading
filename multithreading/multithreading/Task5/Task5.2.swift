//
//  Task5.swift
//  multithreading
//
//  Created by Виталий Горбунов on 22.03.2024.
//

import UIKit

///Чем этот вариант отличается от обычного Task {}?
class Task5_2: UIViewController {
    override func viewDidLoad() {
            super.viewDidLoad()
        print(1)
        Task { @MainActor  in
            print(2)
        }
        print(3)
    }
}

//Task может выполняться на любом акторе, в то время как Task { @MainActor } будет выполняться
//только на главном акторе
