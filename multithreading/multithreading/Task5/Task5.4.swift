//
//  Task5.swift
//  multithreading
//
//  Created by Виталий Горбунов on 22.03.2024.
//

import UIKit

///По практикуйтесь, переведите данный код на async/await.
class Task5_4: UIViewController {
    override func viewDidLoad() {
            super.viewDidLoad()
        Task {
                let result = await randomD6()
                print(result)
        }
    }
    
    func randomD6() async -> Int {
        Int.random(in: 1...6)
    }
}
