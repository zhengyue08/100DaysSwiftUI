import SwiftUI

var countries  = ["China","America","Canada","Britain"]

if countries.count>3{
    print(countries.count)
}else if countries.count==0 {
    print("Zero")
}

enum weekday {
    case Monday, Tuesday, Wednesday, Thursday, Friday, Saturday, Sunday
}

let today = weekday.Sunday
print(today)

//default is needed (error: switch is exhaustive)
switch today{
case .Friday: print(5)
case .Sunday: print("relax")
default :print("other")
}

let age = 23
let period = age>18 ? "Adult" : "Teenager"
print(period)
