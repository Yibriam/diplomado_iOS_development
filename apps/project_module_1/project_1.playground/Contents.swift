import UIKit

/* MARK: First Module Exercises

First challenge
 Create a function that receives an enumerator as a parameter with the following options: .addition, .subtraction, .multiplication, .division and an array of numbers. Return the result after applying the selected operation to all numbers. Handle division by zero with Result or throws.

 Example:
 operation(.addition, numbers: [1,2,3,4]) // 10
 operation(.division, numbers: [20, 5, 0]) // error: division by zero
*/

enum Options {
    case addition
    case subtraction
    case multiplication
    case division
}

enum OperationError: Error {
    case divisionByZero
    case emptyArray
}

func operations(operation: Options, _ nums: [Int]) -> Result<Int, OperationError> {
    guard !nums.isEmpty else {
        return .failure(.emptyArray)
    }

    switch operation {
    case .addition:
        var result: Int = 0
        for i in nums {
            result += i
        }
        return .success(result)

    case .subtraction:
        var result: Int = nums[0]
        for i in nums.dropFirst() {
            result -= i
        }
        return .success(result)

    case .multiplication:
        var result: Int = 1
        for i in nums {
            result *= i
        }
        return .success(result)

    case .division:
        var result: Int = nums[0]
        for i in nums.dropFirst() {
            if i == 0 {
                return .failure(.divisionByZero)
            }
            result /= i
        }
        return .success(result)
    }
}


let result = operations(operation: .addition, [1, 2, 3, 4])
let result2 = operations(operation: .division, [20, 5, 0])

print(result)
print(result2)

/*
 
MARK: Second challenge
 
Create a function that receives an array of integers and returns a dictionary with the
count of positive, negative and zero values.
Example:
checkNumbers([-3, 0, 2, 5, -1]) // ["positives": 2, "negatives": 2, “zeros":1]
 
*/

func createDictionary(_ intArray: [Int]) -> [String: Int] {
    var myDictionary: [String: Int] = [
        "positives": 0,
        "negatives": 0,
        "zeros": 0
    ]

    for number in intArray {
        if number > 0 {
            myDictionary["positives", default: 0] += 1
        } else if number < 0 {
            myDictionary["negatives", default: 0] += 1
        } else {
            myDictionary["zeros", default: 0] += 1
        }
    }

    return myDictionary
}


let myArray: [Int] = [-3, 0, 2, 5, -1]
let dictionary = createDictionary(myArray)
print(dictionary)



/* MARK: Third challenge
Create a function that receives an integer and a limit number. Return an array of Strings with the multiplication table of the given number up to the limit. Example: multiply(number: 7, limit: 12) // ["7x1=7", “7x2=14", …, “7x12=84”]

*/

func multiply(_ number: Int, _ limit: Int) -> [String] {
    var array: [String] = []
    for i in 1...limit {
        var result = 0
        result = number * i
        array.append("\(number)x\(i)=\(result)")
    }
    return array
}

let myMultiply = multiply(7, 12)
print(myMultiply)

/* MARK: Fourth challenge

 Make a function that receives a string that simulates a password and returns an enum PasswordStrength: .weak, .medium, .strong depending on rules: - Minimum 6 characters - Contains a capital letter - Contains a number - Contains a point - Bonus: contains a special symbol (!, @, #, etc.). Example: checkPassword("Pass123.") // .medium checkPassword("Strong#Pass1.") // .strong

*/

enum PasswordStrength {
    case weak(length: Int)
    case medium(length: Int, capital: Character)
    case strong(length: Int, capital: Character, number: Int, point: Character)
    case superStrong(length: Int, capital: Character, number: Int, point: Character, symbol: Character)
}

func checkPassword(_ myString: String) -> PasswordStrength {
    let length = myString.count
    var capital: Character?
    var number: Int?
    var point: Character?
    var symbol: Character?

    for char in myString {
        if capital == nil && char.isUppercase {
            capital = char
        } else if number == nil && char.isNumber {
            number = Int(String(char))
        } else if point == nil && char == "." {
            point = char
        } else if symbol == nil && "!@#$%^&*()_+-=[]{}|;:',<>?/".contains(char) {
            symbol = char
        }
    }

    if length < 6 {
        return .weak(length: length)
    }

    if let cap = capital, number == nil || point == nil {
        return .medium(length: length, capital: cap)
    }

    if let cap = capital, let num = number, let pt = point, symbol == nil {
        return .strong(length: length, capital: cap, number: num, point: pt)
    }

    if let cap = capital, let num = number, let pt = point, let sym = symbol {
        return .superStrong(length: length, capital: cap, number: num, point: pt, symbol: sym)
    }

    return .weak(length: length)
}

let password = checkPassword("Pass123.")
let password2 = checkPassword("Strong#Pass1.")

print(password)
print(password2)

/* MARK: Fifth challenge
Make a function that receives an array of optional strings and returns all the non-nil
values in a new array. If all values are nil, return a message: "All values are empty”.
Example:
let texts: [String?] = ["Hello", nil, "World"]
filterOptionals(texts) // ["Hello", “World"]
 
 
*/

func filterOptionals(_ array: [String?]) -> [String] {
    var words: [String] = []

    for word in array {
        if let unwrapped = word {
            words.append(unwrapped)
        }
    }

    if words.isEmpty {
        print("All values are empty")
    }

    return words
}

let texts: [String?] = ["Hello", nil, "World"]
let result3 = filterOptionals(texts)
print(result3)

/* MARK: Sixth challenge

 Given an optional string, print "It's empty! You ripped me off!" when it's nil, "Thanks for my cat Schrödinger!" if input is "😺 " and "This ain't a cat!" when none of the others Example:
 receiveBox(with: “😺 ") // "Thanks for my cat Schrödinger!"
 receiveBox(with: nil) // "It's empty! You ripped me off!"
 receiveBox(with: “lol") // "This ain't a cat!”
 
*/

func receiveBox(with: String?) -> String {
    switch with {
    case "😺":
        return "Thanks for my cat Schrödinger!"
    case nil:
        return "It's empty! You ripped me off!"
    case "lol":
        return "This ain't a cat!"
    default:
        return "Unexpected item in the box."
    }
}

print(receiveBox(with: "😺"))
print(receiveBox(with: nil))
print(receiveBox(with: "lol"))


/* MARK: Seventh challenge
 
 Create a function that simulates a simple bank account system. Requirements: Define a struct BankAccount with:
 • owner: String
 • balance: Double
 
 Add methods:
 • deposit(amount: Double) → increases the balance.
 • withdraw(amount: Double) → decreases the balance, but only if there are sufficient funds. Otherwise, print "Insufficient funds”.
 • transfer(amount: Double, to otherAccount: inout BankAccount) → transfers money to another account if balance is enough.
 Example:
 var account1 = BankAccount(owner: "Alice", balance: 1000)
 var account2 = BankAccount(owner: "Bob", balance: 500)
 account1.withdraw(amount: 200) // balance = 800
 account1.transfer(amount: 300, to: &account2)
// account1.balance = 500
// account2.balance = 800

 */

struct BankAccount {
    var owner: String
    var balance: Double

    mutating func deposit(amount: Double) -> Double {
        balance += amount
        return balance
    }

    mutating func withdraw(amount: Double) -> Double {
        if balance >= amount {
            balance -= amount
        }
        return balance
    }

    mutating func transfer(amount: Double, to: inout BankAccount) {
        if balance >= amount {
            balance -= amount
            to.balance += amount
        }
    }
}


var account1 = BankAccount(owner: "Alice", balance: 1000)
var account2 = BankAccount(owner: "Bob", balance: 500)

account1.withdraw(amount: 200)
account1.transfer(amount: 300, to: &account2)

print(account1)
print(account2)

/* MARK: Eight challenge
 
Implement the Sieve of Eratosthenes algorithm in Swift from the provided unit tests.
Return and print the resulting array containing only the prime numbers within the range.
• The only parameter is the max number.
• 0 and 1 are not prime numbers.
• The next available number is marked as prime but the next multiples up to the max number are not.
• Find the next prime number and repeat the previous step until reaching max number.
Example:
PrimeCalculator.calculate(upTo: 10) // [2,3,5,7]
PrimeCalculator.calculate(upTo: 50) // [2,3,5,7,11,13,17,19,23,29,31,37,41,43,47]
PrimeCalculator.calculate(upTo: 85)
// [2,3,5,7,11,13,17,19,23,29,31,37,41,43,47,53,59,61,67,71,73,79,83]
 
*/

struct PrimeCalculator {
    static func calculate(upTo max: Int) -> [Int] {
        guard max >= 2 else { return [] }

        var isPrime = [Bool](repeating: true, count: max + 1)
        isPrime[0] = false
        isPrime[1] = false

        for number in 2...Int(Double(max).squareRoot()) {
            if isPrime[number] {
                for multiple in stride(from: number * number, through: max, by: number) {
                    isPrime[multiple] = false
                }
            }
        }
        
        let primes = isPrime.enumerated()
            .filter { $0.element }
            .map { $0.offset }

        print(primes)
        return primes
    }
}

PrimeCalculator.calculate(upTo: 10)
PrimeCalculator.calculate(upTo: 50)
PrimeCalculator.calculate(upTo: 85)

/* MARK: Ninth challenge
 Given an array of people, find the youngest, the oldest and the difference in age between them, and return their respective ages and the age difference. struct Person {
 let name: String
 let age: Int
 }
 let son = Person(name: "Juan", age: 19)
 let daughter = Person(name: "Maria", age: 12)
 let mother = Person(name: "Benita", age: 60)
 let father = Person(name: "Camilo", age: 58)
 let family = [daughter, son, mother, daughter]

 Example:
 findAgeDifference(for: family) // (oldest: 60, youngest: 12, ageDifference: 48)
 
*/

struct Person {
    let name: String
    let age: Int
}

func findAgeDifference(for people: [Person]) -> (oldest: Int, youngest: Int, ageDifference: Int)? {
    guard !people.isEmpty else { return nil }

    let ages = people.map { $0.age }
    if let minAge = ages.min(), let maxAge = ages.max() {
        return (oldest: maxAge, youngest: minAge, ageDifference: maxAge - minAge)
    }

    return nil
}



let son = Person(name: "Juan", age: 19)
let daughter = Person(name: "Maria", age: 12)
let mother = Person(name: "Benita", age: 60)
let father = Person(name: "Camilo", age: 58)
let family = [daughter, son, mother, daughter]

findAgeDifference(for: family)

if let result = findAgeDifference(for: family) {
    print("Oldest: \(result.oldest), Youngest: \(result.youngest), Age Difference: \(result.ageDifference)")
} else {
    print("No people in the array.")
}

/*
Tenth challenge
 Write a closure that takes an array of optional strings and returns a new string that is the concatenation of all the strings in the array. Remember to use the methods map, filter and reduce to find the solution.
 Example:
 let someStrings: [String?] = ["This", "is", nil, "not", nil, "a", "drill", nil, “!"]

 // This is not a drill!
*/


let concatenateStrings: ([String?]) -> String = { optionalStrings in
    optionalStrings
        .map { $0 ?? "" }
        .filter { !$0.isEmpty }
        .reduce("") { $0 + " " + $1 }
        .trimmingCharacters(in: .whitespaces)
}

let someStrings: [String?] = ["This", "is", nil, "not", nil, "a", "drill", nil, "!"]
let result5 = concatenateStrings(someStrings)
print(result5)


