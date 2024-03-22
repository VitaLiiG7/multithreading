//
//  ViewControllerSeven.swift
//  multithreading
//
//  Created by Виталий Горбунов on 20.03.2024.
//

import UIKit

/// Задача дан сервис, через который записываем фразы в массив используя цикл. 1) Используя DispatchQueue.global() записывайте фразы через цикл, а не через main thread. 2) Решить проблему потокобезопасности phrases через семафор. 3) Решить проблему, используя actor вместо класса. Task3

// Использовал семафор
class ViewControllerSeven: UIViewController {
    private let semaphore = DispatchSemaphore(value: 1)
    private var phrasesService = PhrasesService()
    override func viewDidLoad() {
        super.viewDidLoad()
 
            for i in 0..<10 {
//                self.semaphore.wait()
                DispatchQueue.global().async {
                self.phrasesService.addPhrase("Phrase \(i)")
//                    self.semaphore.signal()
            }

                self.semaphore.wait()
            Thread.sleep(forTimeInterval: 1)
            print(self.phrasesService.phrases)
                self.semaphore.signal()
        }
    }
}

class PhrasesService {
    var phrases: [String] = []
    
    func addPhrase(_ phrase: String) {
        print(Thread.current)
        phrases.append(phrase)
    }
}


// Использовал Actor
class ViewControllerSevenActor: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        let phrasesService = PhrasesServiceActor()
        for i in 0..<10 {
            Task {
                await phrasesService.addPhrase("Phrase \(i)")
            }
        }

        Thread.sleep(forTimeInterval: 1)
        Task {
            await print(phrasesService.phrases)
        }
    }
}
actor PhrasesServiceActor {
    var phrases: [String] = []

    func addPhrase(_ phrase: String) {
        print(Thread.current)
        phrases.append(phrase)
    }
}

//// Использовал Actor
//class ViewControllerSevenActor2: UIViewController {
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        let phrasesService = PhrasesServiceActor2()
//
//            for i in 0..<10 {
//                DispatchQueue.global().async {
//                phrasesService.addPhrase("Phrase \(i)")
//                    print(Thread.current)
//            }
//        }
//        
//        Thread.sleep(forTimeInterval: 1)
////        print(phrasesService.phrases)
//    }
//}
//actor PhrasesServiceActor2 {
//    var phrases: [String] = []
//    
//    func addPhrase(_ phrase: String) {
//        print(Thread.current)
//        phrases.append(phrase)
//    }
//}
