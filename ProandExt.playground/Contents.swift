//checkpoint8

protocol Architecture {
    var numberOfRooms: Int{ get }
    var cost: Int { get }
    var agent: String { get set }
    func summary()
}

struct House: Architecture {
    let numberOfRooms: Int
    let cost: Int
    var agent: String
    func summary() {
        print("This house has \(numberOfRooms) rooms, costing \(cost) billions to build.\n\(agent) is responsible for its sale now.")
    }
}

struct Office: Architecture {
    let numberOfRooms: Int
    let cost: Int
    var agent: String
    func summary() {
        print("This Office has \(numberOfRooms) rooms, costing \(cost) billions to build.\n\(agent) is responsible for its sale now.")
    }
}

let Linden = House(numberOfRooms: 10, cost: 3, agent: "Linked House")
Linden.summary()

//Extentions

extension String {
    func removedAllSpace () -> String{
        let string = self.filter { alpha in
            if alpha == " "{
                return false
            }else{
                return true
            }
        }
        return string
    }
    
    mutating func removeAllSpace() {
        self = self.removedAllSpace()
    }
}


var ss = "  I know it is unlikely to work,  but just give a try   "
let ssn = ss.removedAllSpace()
print(ssn)
ss.removeAllSpace()
print(ss)

//protocol
protocol Vehicle {
    var name: String { get }
    var maxPassenger: Int { get }
    var currentPassenger: Int { get set }
    var speed: Int { get }

    var available: Int { get }
    func printInfo()

}

func estimateTime(distance dis: Double, by vehicle: Vehicle) -> Double {
    return (dis / Double(vehicle.speed))
}

struct Car: Vehicle{
    let name: String
    let maxPassenger: Int
    var currentPassenger: Int
    let speed: Int
    
    var available: Int {
        get{
            maxPassenger-currentPassenger
        }
    }
    
    func printInfo() {
        print("Name is \(name)")
    }
}

var Ferd = Car(name: "Ferd", maxPassenger: 5, currentPassenger: 3, speed: 60)

let eTime = estimateTime(distance: 50, by: Ferd)

print(eTime)
