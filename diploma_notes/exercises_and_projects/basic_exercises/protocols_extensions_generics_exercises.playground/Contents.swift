import UIKit

/* MARK: Protocol Challenges

MARK: First Challenge
The `printTable(_:)` function has a bug: It crashes if any of the data items are longer than the label of their column.
Try changing the age of a person to _1,000_ to see this happen. Fix the bug.

> [!NOTE]
> Your solution will likely result in incorrect table formatting; that is fine for now. You will fix the formatting in the third challenge, below.

*/


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
department.add(Person(name: "Salem", age: 1000, yearsOfExperience: 8))
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
            // let paddingNeeded = columnWidths[rowColumnIndex] - item.count - 2
            let paddingNeeded = item.count
            let padding = repeatElement(" ", count: paddingNeeded).joined(separator: "")
            
            output += " \(item)\(padding)|"
        }
        print(output)
    }
}

printTable(department)


/* MARK: Second Challenge

### Second Challenge
Create a new type, `BookCollection`, that conforms to `TabularDataSource`.
Calling printTable(_:) on a book collection should show a table of books with columns for _titles_, _authors_, and _average reviews_.
 
> [!Note]
> Unless all the books you use have very short titles and author names, you will need to have completed the previous challenge!

*/

struct Book {
    let title: String
    let authors: String
    let averageReviews: Double
}

struct BookCollection: TabularDataSource {
    var numberOfRow: Int { books.count }
    var numberOfColumns: Int { 3 }
    
    func label(forColumn column: Int) -> String {
        let label: String
        
        switch column {
        case 0: label = "Title"
        case 1: label = "Authors"
        case 2: label = "Average reviews"
        default: fatalError("A bookcollection should only have 3 columns")
        }
        
        return label
    }
    
    func itemForRow(row: Int, column: Int) -> String {
        let book = books[row]
        let item: String
        
        switch column {
        case 0: item = book.title
        case 1: item = "\(book.authors)"
        case 2: item = "\(book.averageReviews)"
        default: fatalError("Invalid row: \(row), column: \(column) combination")
        }
        
        return item
    }
    
    let name: String
    var books: [Book] = []
    init(name: String) {
        self.name = name
    }
    
    mutating func add(_ book: Book) {
        books.append(book)
    }
}

var bookCollection1 = BookCollection(name: "Encyclopedia")
bookCollection1.add(Book(title: "The War of the Worlds", authors: "H. G. Wells", averageReviews: 6.5))
bookCollection1.add(Book(title: "Journey to the Center of the Earth", authors: "Jules Verne", averageReviews: 8.4))
bookCollection1.add(Book(title: "The Book of Noah", authors: "Nicholas Sparks", averageReviews: 10.7))


printTable(bookCollection1)


/* MARK: Extension Challenges
 
MARK: First Challenge
You made the `Department` type conform to the `CustomStringConvertible` protocol. Refactor your playground from that chapter to move `CustomStringConvertible` conformance into an extension.
 
*/

// Protocol comformance
extension Department: CustomStringConvertible {
    var description: String {
        return "Department: \(name)"
    }
}


let department1 = Department(name: "Medicine")
print(department1)

/* MARK: Second Challenge

Extend the `Array` type to add a method `secondElement()` that returns the second element of the array if it exists, or `nil` if the array has fewer than two elements. Additionally, add a computed property `isNotEmpty` that returns `true` if the array is not empty, and `false` otherwise.

```swift
// usage example
let numbers = [1, 2, 3, 4]
if let second = numbers.secondElement() {
    print("The second element is \(second)")
} else {
    print("The array does not have a second element")
}
// The second element is 2

let emptyArray: [Int] = []
print("Is the array not empty? \(emptyArray.isNotEmpty)")
// Is the array not empty? false
```
*/

extension Array {

    func secondElement() -> Element? {
        return count > 1 ? self[1] : nil
    }

    var isNotEmpty: Bool {
        return !isEmpty
    }
}

let numbers = [1, 2, 3, 4]
if let second = numbers.secondElement() {
    print("The second element is \(second)")
} else {
    print("The array does not have a second element")
}

/* MARK: Third Challenge
Give the `Int` type a nested `enum` with cases **even** and **odd**.
Also give `Int` a property of that type to correctly report whether an integer is even or odd.
 
swift
let myInt = 2
print(myInt.evenOrOdd) // even
print(7.evenOrOdd) // odd

*/

// Nested Types

extension Int {
    enum EvenOrOdd: CustomStringConvertible {
        case even, odd

        var description: String {
            switch self {
            case .even: return "even"
            case .odd: return "odd"
            }
        }
    }

    var evenOrOdd: EvenOrOdd {
        return self % 2 == 0 ? .even : .odd
    }
}

let myInt = 2
print(myInt.evenOrOdd) // even
print(7.evenOrOdd) // odd


/* MARK: Generic Challenges

MARK: First Challenge
Create a generic `Pair` structure that holds two elements of any type (they can be different types). Implement a method to swap the two elements.

```swift
// usage example
var myPair = Pair("Hello", 1)

print(myPair) // Pair: Hello, 1
myPair.swap()
print(myPair) // Pair: 1, Hello
```
*/

struct Pair<T, U> {
    var first: T
    var second: U
    
    func swap() -> Pair<U, T> {
        return Pair<U, T>(first: second, second: first)
    }
}
    
extension Pair: CustomStringConvertible {
    var description: String {
        return "Pair: \(first), \(second)"
    }
}

var myPair = Pair(first: "Hello", second: 1)
print(myPair) // Pair: Hello, 1
let swapped = myPair.swap()
print(swapped) // Pair: 1, Hello
    
    
/* MARK: Second Challenge
Add a `filter(_:)` method to your `Stack` structure. It should take a single argument, a closure that takes an`Element` and returns a `Bool`, and return a new `Stack<Element>` that contains any elements for which the closure returns true.
*/

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
    
    func filter(_ predicate: (Element) -> Bool) -> Stack<Element> {
        var filteredStack = Stack<Element>()
        for item in items {
            if predicate(item) {
                filteredStack.push(item)
            }
        }
        return filteredStack
    }
}

extension Stack: Sequence {
    func makeIterator() -> StackIterator<Element> {
        return StackIterator(stack: self)
    }
}

var stack = Stack<Int>()
stack.push(1)
stack.push(2)
stack.push(3)
stack.push(4)

let evenStack = stack.filter { $0 % 2 == 0 }

for item in evenStack {
    print(item)
}

/* MARK: Third Challenge

 Write a generic function called `findAll(_:_:)` that takes an array of any type `T` that conforms to the `Equatable` protocol and a single element (also of type `T`).
`findAll(_:_:)` should return an array of integers corresponding to every location where the element was found in the array. For example, `findAll([5,3,7,3,9], 3)` should return `[1,3]` because the item 3 exists at indices 1 and 3 in the array. Try your function with both integers and strings.

*/

func findAll<T: Equatable>(_ array: [T], _ element: T) -> [Int] {
    var indices: [Int] = []
    for (index, item) in array.enumerated() {
        if item == element {
            indices.append(index)
        }
    }
    return indices
}

var find = findAll([5,3,7,3,9], 3)
print(find)
var find2 = findAll(["5","3","7","3","9"], "3")
print(find2)

/*
### Fourth Challenge
Write an extension for the `Dictionary` type that adds a method `mapValuesToArray(_:)`. This method should take a closure that transforms the values of the dictionary and return an array of the transformed values.
```swift
// usage example
let dictionary = ["one": 1, "two": 2, "three": 3]
let stringValues = dictionary.mapValuesToArray { "\($0)" }
print(stringValues) // ["1", "2", "3"]
```
*/

extension Dictionary {
    func mapValuesToArray<U>(_ transform: (Value) -> U) -> [U] {
        var result: [U] = []
        for value in self.values {
            result.append(transform(value))
        }
        return result
    }
}


let dictionary = ["one": 1, "two": 2, "three": 3]
let stringValues = dictionary.mapValuesToArray { "\($0)" }
print(stringValues) // ["1", "2", "3"]

/*

### Fifth Challenge
Create a protocol `ComparableItem` that requires conforming types to implement a method `isSmallerThan(_ other: Self) -> Bool`. Then, create a generic function `sortedItems<T: ComparableItem>(_: [T]) -> [T]` that sorts an array of `ComparableItem` items using the `isSmallerThan` method.
```swift
// usage example
let people = [
    Person(name: "Alice", age: 30),
    Person(name: "Bob", age: 25),
    Person(name: "Charlie", age: 35)
]

let sortedPeople = sortItems(people)
for person in sortedPeople {
    print("\(person.name): \(person.age)")
}
// Output:
// Bob: 25
// Alice: 30
// Charlie: 35

let products = [
    Product(name: "Laptop", price: 999.99),
    Product(name: "Smartphone", price: 699.99),
    Product(name: "Tablet", price: 499.99)
]

let sortedProducts = sortItems(products)
for product in sortedProducts {
    print("\(product.name): \(product.price)")
}
// Output:
// Tablet: 499.99
// Smartphone: 699.99
// Laptop: 999.99
```
*/

protocol ComparableItem {
    func isSmallerThan(_ other: Self) -> Bool
}

func sortedItems<T: ComparableItem>(_ items: [T]) -> [T] {
    var sorted = items
    for i in 0..<sorted.count {
        for j in i+1..<sorted.count {
            if sorted[j].isSmallerThan(sorted[i]) {
                sorted.swapAt(i, j)
            }
        }
    }
    return sorted
}

struct Person2: ComparableItem {
    let name: String
    let age: Int

    func isSmallerThan(_ other: Person2) -> Bool {
        return self.age < other.age
    }
}

let people = [
    Person2(name: "Alice", age: 30),
    Person2(name: "Bob", age: 25),
    Person2(name: "Charlie", age: 35)
]

let sortedPeople = sortedItems(people)
for person in sortedPeople {
    print("\(person.name): \(person.age) years old")
}

struct Product: ComparableItem {
    let name: String
    let price: Double

    func isSmallerThan(_ other: Product) -> Bool {
        return self.price < other.price
    }
}

let products = [
    Product(name: "Laptop", price: 999.99),
    Product(name: "Smartphone", price: 699.99),
    Product(name: "Tablet", price: 499.99)
]

let sortedProducts = sortedItems(products)
for product in sortedProducts {
    print("\(product.name): \(product.price)")
}
