
import UIKit

/// Написать как называется проблема №3 которая в коде и решить ее
//была проблема Livelock (Активная блокировка)
class ViewControllerNinth: UIViewController {
    private let queue = DispatchQueue(label: "очередь 2", attributes: .concurrent)
    let semafor = DispatchSemaphore(value: 1)
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let people1 = People1()
        let people2 = People2()
        
        people1.walkPast(with: people2)
        people2.walkPast(with: people1)
    }
}

class People1 {
    var isDifferentDirections = false;
    private let semafore = DispatchSemaphore(value: 1)
    func walkPast(with people: People2) {
        
        DispatchQueue.global(qos: .background).async {
            DispatchQueue.main.async {
                while (!people.isDifferentDirections) {
                    print("People1 не может обойти People2")
                    sleep(1)
                }
            }
        }
        
        DispatchQueue.global(qos: .background).async {
            print("People1 смог пройти прямо")
            self.isDifferentDirections = true
        }
    }
}

class People2 {
    var isDifferentDirections = false;
    private let semafore = DispatchSemaphore(value: 1)
    func walkPast(with people: People1) {
        DispatchQueue.global(qos: .background).async {
            DispatchQueue.main.async {
                while (!people.isDifferentDirections) {
                    print("People2 не может обойти People1")
                    sleep(1)
                }
            }
        }
        
        DispatchQueue.global(qos: .background).async {
            print("People2 смог пройти прямо")
            self.isDifferentDirections = true
        }
    }
}

