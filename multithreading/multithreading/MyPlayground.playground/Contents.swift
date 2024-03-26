import UIKit

protocol StorageProtocol {
    func save()
    func load()
}

class CoreDataManager: StorageProtocol {
    func load() {}
    func save() {}
}

class NetworkManager {
    func fetchData(url: URL) {}
}

class StorageManager {
    var storage: StorageProtocol?
    
    init(storage: StorageProtocol) {
        self.storage = storage
    }
    
    func save() {
        storage?.save()
    }
    
    func load() {
        storage?.load()
    }
}

class Presenter {
    var networkManager: NetworkManager?
    var storage: StorageManager?
    
    
    func updateUI() {}
    
    func returnData() {
        networkManager?.fetchData(url: URL.applicationDirectory)
    }
}

