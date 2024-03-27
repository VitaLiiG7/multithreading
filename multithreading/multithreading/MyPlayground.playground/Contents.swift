import UIKit
/*N°1 Какой принцип нарушает данный код? Исправьте код что б ничего не нарушал?

class NetworkManager {
    func fetchData(url: URL) {
        // Запрос к API
    }

    func updateUI() {
        // обновляет пользовательский интерфейс
    }
} */

/*
нарушает принцип единой ответственности, Класс NetworkManager имеет две
функции: fetchData для отправки запроса и updateUI для обновления
пользовательского интерфейса. Каждая функция должна быть ответственна только
за одну задачу. Для исправление ошибки мы должны разделить функции на два
класса, однин класс отвечает только за работу с сетью и получение данных, а
второй класс будет отвечать за обновление пользовательского интерфейса */

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

/*
Nº1 Какой принцип нарушает данный код? Если мы захотим добавить новое животное,
нам придется изменить метод makeSound . Исправьте код что б ничего не нарушал?
 
 class Animal {
     let name: String

     init(name: String) {
         self.name = name
     }

     func makeSound() {
         if name == "Dog" {
             print("Woof")
         } else if name == "Cat" {
             print("Meow")
         }
     }
 }
 
 Данный код нарушает принцип Open-Closed Principle если мы захотим добавить
 животное, то придется изменить метод makeSound
 Решение:
 Если захотим добавить новое животное, нам не нужно изменять существующий код
 класса Animal. Просто создаем новый подкласс Animal и переопределим его метод
 makeSound
 */

class Animal {
    let name: String

    init(name: String) {
        self.name = name
    }

    func makeSound() { }
}

class Dog: Animal {
    override func makeSound() {
        print("Woof")
    }
}

class Cat: Animal {
    override func makeSound() {
        print("Meow")
    }
}

/*Nº2 Какой принцип нарушает данный код? Исправьте код что б ничего не нарушал?
 
 struct Circle {
    let radius: CGFloat
 }

 struct Rectangle {
    let width: CGFloat
    let height: CGFloat
 }

 class SizePrinter {

 func printSize(of circle: Circle) {
      let diameter = circle.radius * 2
      print(CGSize(width: diameter, height: diameter)
 }

 func printSize(of rect: Rectangle) {
    print(CGSize(width: rect.width, height: rect.height)
  }
 }
 
 Данный код нарушает принцип Open-Closed Principle, если захотим добавить новую
 фигуру то придется изменять класс SizePrinter и добавлять новый метод
 Решение:
*/

protocol Shape {
    var size: CGSize { get }
}

struct Circle: Shape {
   let radius: CGFloat
   
   var size: CGSize {
       let diameter = radius * 2
       return CGSize(width: diameter, height: diameter)
   }
}

struct Rectangle: Shape {
   let width: CGFloat
   let height: CGFloat
    
    var size: CGSize {
        CGSize(width: width, height: height)
    }
}

class SizePrinter {
    func printSize(of shape: Shape) {
        print(shape.size)
    }
}

let circle = Circle(radius: 5)
let rect = Rectangle(width: 20, height: 20)
let size = SizePrinter()
size.printSize(of: rect)
size.printSize(of: circle)


/*
Какой принцип нарушает данный код? Penguin не может летать, в то время как
класс Bird предполагает, что все птицы могут летать. Исправьте код.
class Bird {
    func fly() {
        // Реализация полета
    }
}

class Penguin: Bird {
    override func fly() {
        fatalError("Penguins can't fly!")
    }
}

let myBird: Bird = Penguin()
myBird.fly()  // Приведет к ошибке во время выполнения
*/

protocol FlayingProtocol {
    func fly()
}

class Bird {
    func puttingEggs() {
        print("Я могу класть яица")
    }
}

class Swift: Bird, FlayingProtocol {
    func fly() {
        print("Я могу Летать")
    }
}

class Penguin: Bird {}

let myBird: Bird = Penguin()
myBird.puttingEggs()

/*
N°1 Какой принцип нарушает данный код? Классы не должны зависеть от методов,
 которые они не используют. Исправьте код.
 
protocol Worker {
    func work()
    func eat()
}

class Robot: Worker {
    func work() {
        // Робот работает
    }

    func eat() {
        fatalError("Робот не может кушать")
    }
}

Данный код нарушает принцип Interface Segregation Principle, проблема
называется пустая реализация. Возникает когда классу не нужны все
методы протокола */


protocol Worker {
    func work()
}

protocol WorkerEat {
    func eat()
}

class Robot: Worker {
    func work() {}
}

class Human: Worker, WorkerEat {
    func work() {}
    func eat() {}
}

/*
N°1 Какой принцип нарушает данный код? Классы верхнего уровня не должны зависеть от классов нижнего уровня. Написать какой класс тут верхнего уровня а какой нижнего. Исправьте код.

class LightBulb {
    func turnOn() {
        // включает свет
    lamp.on()
    }

    func turnOff() {
        // включает свет
    lamp.off()
    }
}

class Switch {
    let bulb: LightBulb

    init(bulb: LightBulb) {
        self.bulb = bulb
    }

    func toggle() {
        bulb.turnOn()
    }
}*/


class Light {
    func turnOn() {}
    func turnOff() {}
}

enum Lamp {
    case on
    case off
}

//низкий уровень
class LightBulb: Light {
    override func turnOn() {
//         включает свет
        Lamp.on
    }

    override func turnOff() {
        // включает свет
    Lamp.off
    }
}

//Верхний уровень
class Switch {
    let bulb: Light
    
    init(bulb: Light) {
        self.bulb = bulb
    }

    func toggle() {
        bulb.turnOn()
    }
}



