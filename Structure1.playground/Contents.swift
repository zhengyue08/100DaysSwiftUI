import SwiftUI

struct App {
    var contacts = [String](){
        willSet {
            print("Current value is: \(contacts)")
            print("New value will be: \(newValue)")
    
        }
        didSet {
            print("There are now \(contacts.count) contacts")
            print("Old value was: \(oldValue)")
        }
    }
    init(contacts:[String]){
        self.contacts = contacts
    }
}

var app = App(contacts: ["Halin,A"])
app.contacts.append("Adrian E")
app.contacts.append("Allen W")
app.contacts.append("Ish S")

// willSet and didSet are more likely used on those variable directly set

struct Employee {
    let name: String
    var vacationAllocated:Int = 14
    var vacationTaken: Int = 0
    
    var vacationRemained: Int{
         get{
            vacationAllocated-vacationTaken
        }
        set{
            
            vacationAllocated = vacationTaken + newValue
            
        }

    }
    func printInfo(){
        print(name,vacationAllocated,vacationTaken,vacationRemained)
    }
    mutating func addVacation(for days: Int){
        vacationAllocated += days
    }
}

var becky = Employee(name: "Becky")
becky.vacationAllocated = 18
becky.vacationTaken = 4
print(becky.vacationRemained)
becky.vacationTaken = 5
print(becky.vacationRemained)
becky.vacationRemained = 10
print(becky.vacationAllocated)
becky.printInfo()
becky.addVacation(for: 5)
becky.printInfo()
