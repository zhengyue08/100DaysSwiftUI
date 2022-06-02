import SwiftUI

func countryNames()->[String:String]{
    return ["Britain": "London",
            "USA": "Washington"]
}

func songNames()->[String: (album:String, year:Int)]{
    var collections = ["Taylor": ("White",2001)]
    collections["John"] = ("Black",2000)
    return collections
}

enum passError: Error{
    case short, simple
}

func checkPasswords(_ passwords: String = "000000") throws -> String {
    if passwords.count<6 {
        throw passError.short
    }
    if passwords == "111111"{
        throw passError.simple
    }
    
    if passwords.contains("@"){
        return "Excellent"
    } else if passwords.contains("_"){
        return "Good"
    } else {
       return "Acceptable"
    }
}

func greet(_ someone:String){
    print("Hello, \(someone)")
}

do{
    let result = try checkPasswords("135@zywh")
    print(result)
}catch passError.short{
    print("The passwords need to be longer")
}catch passError.simple{
    print("You should set a more complex password")
}



//greet("Boys")
//
//let names = countryNames()
//print(names["Britain"])
//
//let song = songNames()
//let (album, year) = song["John"] ?? ("OK",1999)
//print(song["Taylor"])

