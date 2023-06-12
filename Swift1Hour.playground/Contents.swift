import SwiftUI

let teams = ["Tiffiny", "John", "Bob", "Jessica"]

let justT = teams.filter { name in
    return name.hasPrefix("T")
}

print(justT)


