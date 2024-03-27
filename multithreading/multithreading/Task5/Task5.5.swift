//
//  Task5.swift
//  multithreading
//
//  Created by Виталий Горбунов on 22.03.2024.
//

import UIKit
///1)Появилась обычная боевая задача, у вас есть сетевой сервис который легаси его менять не нужно, но все что в ViewController должно работать на async/await. Измените метод fetchMessagesResult на func fetchMessages() async -> [Message] { и содержимое метода переведите на async с помощь withCheckedContinuation. P.S меняем только этот метод в пару строчек и вызов его в viewDidLoad тоже в пару строчек.
///2)А теперь этот же метод обработать через withChecked Throwing Continuation на случай если messages.isEmpty то continuation.resume(throwing: а если не пустой то resume(returning:.
class Task5_5: UIViewController {
    enum FetchError: Error {
        case noMessages
    }
    
    var networkService = NetworkService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 1 решение
        Task {
            let messager = await fetchMessagesResult()
            print(messager)
        }
        
        // 2 решение
        //        Task {
        //            do {
        //                let messager = try await fetchMessagesResult()
        //                print(messager)
        //            } catch {
        //                print("Failed to fetch messages: \(error)")
        //
        //            }
        //        }
    }
    
    // 1 решение
    func fetchMessagesResult() async -> [Message] {
        await withCheckedContinuation { continuation in
            networkService.fetchMessages { message in
                continuation.resume(returning: message)
            }
        }
    }
    
    // 2 решение
    //    func fetchMessagesResult() async throws -> [Message] {
    //        try await withCheckedThrowingContinuation { continuation in
    //            networkService.fetchMessages {  messages  in
    //                if messages.isEmpty {
    //                    continuation.resume(throwing: FetchError.noMessages)
    //                } else {
    //                    continuation.resume(returning: messages)
    //                }
    //            }
    //        }
    //    }
}

struct Message: Decodable, Identifiable {
    let id: Int
    let from: String
    let message: String
}

class NetworkService {
    func fetchMessages(completion: @escaping ([Message]) -> Void) {
        let url = URL(string: "https://hws.dev/user-messages.json")!
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data {
                if let messages = try? JSONDecoder().decode([Message].self, from: data) {
                    completion(messages)
                    return
                }
            }
            
            completion([])
        }
        .resume()
    }
}


