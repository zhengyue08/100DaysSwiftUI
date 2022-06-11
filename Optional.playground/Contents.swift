//checkpoint9

func rrandom (of numbers : [Int]?) -> Int {
    return numbers?.randomElement() ?? Int.random(in: 1...100)
}

var tArray: [Int]? = [10,1,23,4]
print(rrandom(of: tArray))
tArray?.removeAll()
print(rrandom(of: tArray))
tArray = nil
print(rrandom(of: tArray))





enum UserError: Error {
    case badID, networkFailed
}

func getUser(id: Int) throws -> String {
    throw UserError.networkFailed
}

if let user = try? getUser(id: 23) {
    print("User: \(user)")
}



let tvShows = ["Archer", "Babylon 5", "Ted Lasso"]
let favorite = tvShows.randomElement() ?? "None"

print(favorite)



var number: Int?




func guard_printSquare(of number: Int?){
    guard let number = number else{
        print("Missing Input")
        return
    }
    print("\(number) * \(number) = \(number*number)")
}

func if_printSquare(of number: Int?){
    if let number = number {
        print("\(number) * \(number) = \(number*number)")
    }else{
        print("Missing Input")
    }
}

guard_printSquare(of: number)
if_printSquare(of: number)

number = 10
guard_printSquare(of: number)
if_printSquare(of: number)
