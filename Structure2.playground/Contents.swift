import SwiftUI

//checkpoint 6
struct Car {
    let model: String
    let numberOfSeats: Int
    private var currentGear: Int
    
    mutating func switchGearsUp(for number: Int){
        currentGear += number
    }
    mutating func switchGearsDown(for number: Int){
        currentGear -= number
    }
    
    func printGear(){
        print(currentGear)
    }
    
    init(model: String, numberOfSeats: Int, currentGear: Int){
        self.model = model
        self.numberOfSeats = numberOfSeats
        self.currentGear = currentGear
    }
}

var myCar = Car(model: "Truck", numberOfSeats: 2, currentGear: 6)
myCar.printGear()
myCar.switchGearsUp(for: 2)
myCar.printGear()



struct AppData {
    static var version = "1.1.0"
    var last_version = "1.0.0"
}

print(AppData.version)




struct BankAccount {
    var name: String
    private var funds = 0
    
    mutating func deposit (_ money: Int){
        funds += money
    }
    
    mutating func withdraw (_ money: Int) -> Bool{
        if self.funds>money {
            funds -= money
            return true
        }
        else {
            return false
        }
    }
    
    func printInfo(){
        print("\(name) has \(funds) in total")
    }
    
    init(name: String, funds: Int){
        self.name = name
        self.funds = funds
    }
}

var Aryn = BankAccount(name:"Aryn",funds: 2000)

Aryn.deposit(1000)
Aryn.withdraw(500)
Aryn.printInfo()

