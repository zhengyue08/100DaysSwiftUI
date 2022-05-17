//Create variables

var greeting = "Hello, variables"
print(greeting)

var v1:String
v1 = "Hey man"
print(v1)

var v2:Int = 10
print(v2)

//Create constants

let c1 = "Hello, constants"
print(c1.uppercased())

let c2:String
c2 = "Assign values after declaration"
print(c2)

let c3:Int = 30
print(c3)

// Create strings

let ss = """
We can store multiple lines work
in a string constant
"""
print(ss+"\n",String(ss.count)+"\n",ss.hasPrefix("We"),ss.hasSuffix("ant"))

//How to store whole decimal numbers

let longNumber = 1_100_100
print(longNumber)

let n1:Int = 3;
print(n1)

let n2:Double = 3
print(n2)
