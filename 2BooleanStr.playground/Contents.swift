import SwiftUI

// Booleans


let filename = "paris.jpg"
print(filename.hasSuffix(".jpg"))
let hasSuffix = filename.hasSuffix(".jpg")
print(hasSuffix)

print(120.isMultiple(of: 3))
var mutiple = 120.isMultiple(of: 3)

print(mutiple)
print(!mutiple)

mutiple.toggle()
print(mutiple)


// Join strings together

let nameA = "Bob"
let nameB = "Aryn"
let ageA = 33
let ageB = 44

print("Hello "+nameA)
print("Hello \(nameB)")
print("What's your age, Bob")
print("\(nameA): I'm \(ageA)")
print(nameB+" "+"I'm "+String(ageB))
print("Oh, the sum of our age is \(ageA+ageB)")


// Checkpoint 1
//Shift+Option+8 -> °


let celsius = 20
let fahreheit = celsius*9/5+32
print("Temperature(°C) is \(celsius)°C\nTemperature(°F) is \(fahreheit)°F")
