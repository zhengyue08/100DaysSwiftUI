import SwiftUI


//Array
//Arrays are a great choice when items should be stored in the order you add them, or when you might have duplicate items in there, but very often accessing data by its position in the array can be annoying or even dangerous.
var countries = ["China","America","England","Canada","Japan"]

print(countries.sorted())
print(countries)
countries.append("Italia")
print(countries)
countries.remove(at: 3)
print(countries)

var music = Array<String>()
music.append("Lalaland")
print(music)

//Swift just remember I want to reverse it rather really doing that, when you need to print that or find something, it will let the iterator move in the reversed order
let countriesrev = countries.reversed()
print(countries.contains("Italia"))

      
//MARK: Dictionary
// when you access data inside a dictionary, it will tell us “you might get a value back, but you might get back nothing at all.”
// dictionaries don’t allow duplicate keys to exist.
let cities = ["China":"Beijing", "Japan": "Tokyo", "Britain": "London", "German": "Bolin"]
print(cities["Japan"])
// Optional Type
print(cities["China"]!)

var figure = [String:Int]()
figure["Teacher"] = 32
figure["Father"] = 50
figure["Mother"] = 40
figure["Brother"] = 22
print(figure)
figure.removeValue(forKey: "Mother")
print(figure["Mother"])


let results = [
    "english": 100,
    "french": 85,
    "geography": 75
]
//let historyResult = results["history", default: 0]
let historyResult = results["history"]
print(historyResult)

//MARK: Set
let people = Set(["Denzel Washington", "Tom Cruise", "Noicolas Cage"])

var name = Set<String>()
name.insert("Nicolas Cage")
name.insert("Tim Cook")

//It will be fast to check whether thic Set contains something even it consists of millions of elements
print(name.contains("Kobe Brian"))

//MARK: enum

enum Weekday:Int {
    case monday=0, tuesday, wednesday, thursday, friday
}

print(Weekday.friday,Weekday.friday.rawValue)

let color = ["white", "black", "orange", "blue", "orange"]
print(color.count)
let colors = Set(color)
print(colors.count)
