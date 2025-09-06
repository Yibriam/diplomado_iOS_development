//: [Previous](@previous)

import UIKit

func greetEveryone() {
    print("Hello there!")
}

greetEveryone()


func introduceSomeone(name: String, age: Int) {
    if age < 18 {
        print("Yougnster", name)
    } else {
        print("This is", name)
    }
}

introduceSomeone(name: "Helena", age: 13)
//introduceSomeone(name: "Manuel", age: 32.4) // unexpected data type

func add(_ rhs: Int, plus lhs: Int) {
    rhs + lhs
}

//add(rhs: 2, lhs: 3)
add(2, plus: 3)

//class TableView: UITableViewController {
//    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
//}

func printWelcomeMessage(for name: String, attending course: String = "Diplomado de Aplicaciones Móviles iOS") {
    print("Hello, \(name)! Welcome to the `\(course)`")
}
printWelcomeMessage(for: "Manuel")
printWelcomeMessage(for: "Grecia", attending: "Diplomado de Bases de Datos")


func addSomeNumbers() -> Int {
    /*return*/ 2+2
}

let sum = addSomeNumbers()

func sortEvenNumbers(_ numbers: [Int]) -> (evens: [Int], odds: [Int]) {
    var evens = [Int]()
    var odds = [Int]()
    
    for number in numbers {
        if number % 2 == 0 {
            evens.append(number)
        } else {
            odds.append(number)
        }
    }
    
    return (evens, odds)
}

let aBunchOfNumbers = [10, 1, 4, 3, 57, 43, 27, 84, 156, 111]
let sortedBunchOfNumbers = sortEvenNumbers(aBunchOfNumbers)
print("The even numbers: \(sortedBunchOfNumbers.evens); the odd numbers: \(sortedBunchOfNumbers.odds)")


func grabMiddleName(fromFullName name: (String, String?, String)) -> String? {
    return name.1
}

let middleName = grabMiddleName(fromFullName: ("Grecia", "nombre", "Escárcega"))

if let middleName = middleName {
    print(middleName)
}


func greetByMiddleName(fromFullName name: (first: String, middle: String?, last: String)) {
    
    guard let middleName = name.middle else {
        return
    }
    
    print("Hey, \(middleName)")
}

greetByMiddleName(fromFullName: (first: "Grecia", middle: nil, last: "Escárcega"))



func applySunscreen(at time: Int) throws -> Bool {
    switch time {
    case 8...17: return true
    case 0...7, 17...23: return false
    default: throw NSError(domain: "", code: -100)
    }
}

let time = -5

do {
    let shouldApplySunscreen = try applySunscreen(at: time)
    if shouldApplySunscreen {
        print("If you go out at \(time) you should apply sunscreen")
    }
} catch {
    print(error.localizedDescription)
}
//catch MyError.someCase { //TIL! Custom error type
//    //    print(error.localizedDescription)
//}

let optionalTry = try? applySunscreen(at: 84)


//let value = try! applySunscreen(at: 84)

print(addSomeNumbers())


func areaOfTriangleWith(base: Double, height: Double) -> Double {
    let rectangle = base * height
    
    func divide() -> Double {
        return rectangle / 2
    }
    
    return divide()
}

print(areaOfTriangleWith(base: 3.0, height: 5.0))


//: [Next](@next)
