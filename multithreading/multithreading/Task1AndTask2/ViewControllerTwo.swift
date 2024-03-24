//
//  VieViewControllerTwo.swift
//  multithreading
//
//  Created by Виталий Горбунов on 18.03.2024.
//

import UIKit

/// Задача cоздать второй поток на базе Thread, создать таймер так, чтобы он заработал Task1
class ViewControllerTwo: UIViewController {
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Создаем и запускаем поток с таймером
        let timer = TimerThread(duration: 10)
        timer.start()
    }
    
    /// Используется для создания и управления потоком выполнения, который запускает таймер и выполняет код каждую секунду
    class TimerThread: Thread {
        // MARK: - Private Properties
        private var timerDuration: Int
        private var timer: Timer!
        
        // MARK: - Initializers
        init(duration: Int) {
            self.timerDuration = duration
        }
        
        // MARK: - Life Cycle
        override func main() {
            // Создаем таймер, который будет выполняться каждую секунду
            timer = Timer(timeInterval: 1.0, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
            print(Thread.current)
            // Добавляем таймер в текущий run loop ниже
            RunLoop.main.add(timer, forMode: .default)
            // Запускаем текущий run loop ниже
            RunLoop.current.run()
        }
        
        // MARK: - Private Methods
        @objc private func updateTimer() {
            // Ваш код здесь будет выполняться каждую секунду
            if timerDuration > 0 {
                print("Осталось \(timerDuration) секунд...")
                timerDuration -= 1
            } else {
                print("Время истекло!")
                timer.invalidate()
                // Остановка текущего run loop после завершения таймера
                CFRunLoopStop(CFRunLoopGetCurrent())
            }
        }
    }
}
