import SwiftUI

//deinitialize: we don't use it directly, the system will call it.
class User {
    let id: Int

    init(id: Int) {
        self.id = id
        print("User \(id): I'm alive!")
    }

    deinit {
        print("User \(id): I'm dead!")
    }
}


for i in 1...3 {
    let user = User(id: i)
    print("User \(user.id): I'm in control!")
}

//when you show data from some object on the screen, or when you pass data between your layouts, you’ll usually be using classes.
class Employee {
    var hours: Int {
        didSet {
            print("Work for \(hours) hours")
        }
    }
    init (hours: Int) {
        self.hours = hours
    }
    
    func printSummary() {
        print("Hour: \(hours)")
    }
    
}

class Manager: Employee {
    var level: String
    func work(){
        print("I'm going to meeting for \(hours) hours")
    }
    
    init(hours: Int, level: String){
        self.level = level
        super.init(hours: hours)
    }
}

class Developer: Employee {
    
    func work(){
        print("I'm going to code for \(hours) hours")
    }
    
    override func printSummary() {
        print("This was a exhausted work which pushed me to work for \(hours) hours a day")
    }
}

let Dawei = Developer(hours: 12)
//Dawei.printSummary()

let Li = Manager(hours: 8, level: "High")

Li.printSummary()

//Deep learning

class Car {
    var ID = 35787
    
    func copy()->Car{
        let car = Car();
        car.ID = ID
        return car
    }
}

var tokyo = Car()
print(tokyo.ID)
var tokyo2 = tokyo.copy()
tokyo2.ID += 10
print(tokyo.ID)
print(tokyo2.ID)

//Variables: works different from structure, whether we can change a property totally depends on how we define the property
