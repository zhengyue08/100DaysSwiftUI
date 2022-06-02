import SwiftUI

var countries = ["China", "USA", "Britain", "Canada"]

for country in countries{
        print("This is \(country)")
}

//// know how many times you want the code to be repeated
//for i in 1...9{
//    for j in 1...9{
//        if j<=i{
//            print("\(i)*\(j)=\(i*j)",terminator: " ")
//        }
//    }
//    print("\n")
//}
//Don't know how many times ...

while countries.count < 10 {
    countries.append(String(Int.random(in: 1...20)))
}

print(countries)
