import SwiftUI

enum error: Error{
    case noRoot
}

//checkpoint 4
func findRoot(_ number:Int) throws -> Int {
    
    for i in 1...100{
        
        if i*i==number{
            return i
        }
    }
    throw error.noRoot
}

for i in 1...10000{
    do{
        let root = try findRoot(i)
        print("\(root) is the root of \(i)")
    } catch error.noRoot{
        print("\(i) doesn't have a integer square root")
    }
}







func returnValue (for value: Int) -> Int{
    return value*6
}

let ret: (Int)->Int = returnValue
let user = ret(12)




// checkpoint 5
let luckyNumbers = [7, 4, 38, 21, 16, 15, 12, 33, 31, 49]

var luckyNumber = luckyNumbers.filter{!$0.isMultiple(of: 2)}
luckyNumber = luckyNumber.sorted()

for i in luckyNumber{
    print("\(i) is a lucky number")
}

let numbers = luckyNumbers
    .filter { n in
        !n.isMultiple(of: 2)
    }
    .sorted()
    .map { n in
        print("\(n) is a lucky number")
    }

