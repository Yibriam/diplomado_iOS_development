import UIKit

// MAP
// Filter
// Reduce


let myArray = [1, 2, 3, 4, 5, 6]

let transformedArray = myArray.map { "\($0)" }

//print(transformedArray)

let fileteredArray = myArray.filter { value in
    return value % 2 == 0
}

//print(fileteredArray)


// MARK: Protocols

// Radio Protocol
// - changeVolume
// - changeSong
// - connectPhone

//let data = [
//    ["Eva", "30", "6"],
//    ["Salem", "40", "18"],
//    ["Andres", "50", "20"]
//]

//let headers = [
//    "Emplyee name",
//    "Age",
//    "Years of experience"
//]

protocol TabularDataSource {
    var numberOfRow: Int { get }
    var numberOfColumns: Int { get }
    
    func label(forColumn column: Int) -> String
    func itemForRow(row: Int, column: Int) -> String
}

struct Person {
    let name: String
    let age: Int
    let yearsOfExperience: Int
}

struct Department: TabularDataSource {
    var numberOfRow: Int { people.count }
    
    var numberOfColumns: Int { 3 }
    
    func label(forColumn column: Int) -> String {
        let label: String
        
        switch column {
        case 0: label = "Employee name"
        case 1: label = "Age"
        case 2: label = "Years of experience"
        default: fatalError("A department should only have 3 columns")
        }
        
        return label
    }
    
    func itemForRow(row: Int, column: Int) -> String {
        let person = people[row]
        let item: String
        
        switch column {
        case 0: item = person.name
        case 1: item = "🙊\(person.age)"
        case 2: item = "\(person.yearsOfExperience)"
        default: fatalError("Invalid row: \(row), column: \(column) combination")
        }
        
        return item
    }
    
    let name: String
    var people: [Person] = []
    init(name: String) {
        self.name = name
    }
    
    mutating func add(_ person: Person) {
        people.append(person)
    }
}

var department = Department(name: "Engineering")
department.add(Person(name: "Eva", age: 30, yearsOfExperience: 6))
department.add(Person(name: "Salem", age: 40, yearsOfExperience: 8))
department.add(Person(name: "Andres", age: 50, yearsOfExperience: 10))

func printTable(_ dataSource: TabularDataSource) {
    var headerRow = "|"
    var columnWidths = [Int]()
    
    for columnIndex in 0..<dataSource.numberOfColumns {
        let columnLabel = dataSource.label(forColumn: columnIndex)
        let columnHeader = " \(columnLabel) |"
        headerRow += columnHeader
        
        columnWidths.append(columnHeader.count)
    }
    
    print(headerRow)
    
    for rowIndex in 0..<dataSource.numberOfRow {
        var output = "|"
        for rowColumnIndex in 0..<dataSource.numberOfColumns {
            let item = dataSource.itemForRow(row: rowIndex, column: rowColumnIndex)
            let paddingNeeded = columnWidths[rowColumnIndex] - item.count - 2
            let padding = repeatElement(" ", count: paddingNeeded).joined(separator: "")
            
            output += " \(item)\(padding)|"
        }
        print(output)
    }
}



printTable(department)


struct School: TabularDataSource {
    var numberOfRow: Int { 10 }
    
    var numberOfColumns: Int { 2 }
    
    func label(forColumn column: Int) -> String {
        if column < 1 {
            return "Column A"
        } else {
            return "Column B"
        }
    }
    
    func itemForRow(row: Int, column: Int) -> String {
        return "test"
    }
    
    
}

let school = School()
//
printTable(school)
let tabularDeparment = department as TabularDataSource
//let optionalDepartment = school is TabularDataSource
department as Department


// MARK: Extensions


let myValue: Double = 5

extension Double {
    var squared: Double { self * self }
}

print(myValue.squared)
// extender funcionalidad de un tipo de dato al que no tenemos acceso


struct Car {
    private let maker: String
    let model: String
    let year: Int
    var fuelLevel: Double {
        willSet {
            precondition(newValue <= 1.0 && newValue >= 0, "New value must be between 0 and 1")
        }
    }
}

// Protocol comformance
extension Car: CustomStringConvertible {
    var description: String {
        return "car: \(maker) - \(model)"
    }
}

// Add initializers
extension Car {
    init(maker: String, model: String, year: Int) {
            self.maker = maker
            self.model  = model
            self.year = year
            self.fuelLevel =   1
        }
}

// Nested Types
extension Car {
    enum Era {
        case vingage, modern
    }
}

// Methods
extension Car {
    mutating func emptyFuel(by amount: Double) {
        fuelLevel -= amount
    }
}


let firstCar = Car(maker: "Honda",
                   model: "Civic",
                   year: 2017)
                   //fuelLevel: 1.0)

print(firstCar)


// MARK: Generics
//
//

let something: [String] = []
let something2 = [String]()
let something3: Array<String> = []
let somthing4: Array<Int> = []

// Stack
// first in, last out

struct StackIterator<T>: IteratorProtocol {
    typealias Element = T
    
    var stack: Stack<T>
    
    mutating func next() -> T? {
        return stack.pop()
    }
}

struct Stack<Element> {
    var items = [Element]()
    
    mutating func push(_ newItem: Element) {
        items.append(newItem)
    }
    
    mutating func pop() -> Element? {
        guard !items.isEmpty else { return nil }
        return items.removeLast()
    }
    
    func map<U>(_ transformer: (Element) -> (U)) -> [U] {
        var result = [U]()
        
        for item in items {
            result.append(transformer(item))
        }
        
        return result
    }
}

extension Stack: Sequence {
    func makeIterator() -> StackIterator<Element> {
            return StackIterator(stack: self)
        }
}



var intStack = Stack<Int>()
intStack.push(1)
intStack.push(2)

var myStackIterator = StackIterator(stack: intStack)

//while let value = myStackIterator.next() {
//    print("got: \(value)")
//}

for value in intStack {
    print("\(value)")
}

//print(intStack.pop())
//print(intStack.pop())
//print(intStack.pop())

//var stringStack = Stack<String>()
var stringStack = Stack(items: ["test"])
//stringStack.push(1)
stringStack.push("test 2")

//print(stringStack.pop())
//print(stringStack.pop())
//print(stringStack.pop())


// Generic Methods and Functions
//// Map
//func myMap<T, U>(items: [T], _ transformer: (T) -> (U)) -> [U] {
//    var result = [U]()
//
//    for item in items {
//        result.append(transformer(item))
//    }
//
//    return result
//}
//
//let strings: [String] = ["one", "two", "three"]
//
//let stringsLengths = myMap(items: strings) { string in
//    return string.count
//    }
//
//print(stringsLengths)

//func checkIfEqual<T: CustomStringConvertible, U: CustomStringConvertible>(_ first: T, _ second: U) -> Bool {
//    return first.description == second.description
//}
//
//checkIfEqual(1, 2)
//checkIfEqual(Int(1), UInt(1))
//checkIfEqual(Float(1.0), Double(1.0))





// Protocols no tienen genéricos
// associatedType


//protocol IteratorProtocol {
//    associatedtype Element
//    mutating func next() -> Element?
//}

//protocol Sequence {
//    associatedtype Iterator: IteratorProtocol
//    associatedtype Element where Element == Iterator.Element
//    func makeIterator() -> Iterator
//}

// Tipos opacos









