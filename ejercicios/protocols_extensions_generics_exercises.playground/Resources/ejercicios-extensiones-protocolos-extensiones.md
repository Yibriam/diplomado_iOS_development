# Protocol, Extension and Generics Exercises

## Protocol Challenges

### First Challenge
The `printTable(_:)` function has a bug: It crashes if any of the data items are longer than the label of their column. 
Try changing the age of a person to _1,000_ to see this happen. Fix the bug. 

> [!NOTE]  
> Your solution will likely result in incorrect table formatting; that is fine for now. You will fix the formatting in the third challenge, below.


### Second Challenge
Create a new type, `BookCollection`, that conforms to `TabularDataSource`. 
Calling printTable(_:) on a book collection should show a table of books with columns for _titles_, _authors_, and _average reviews_.
 
> [!Note]
> Unless all the books you use have very short titles and author names, you will need to have completed the previous challenge!


### Third Challenge (optional)
After you fixed the crashing bug in the first challenge, the table rows and columns were likely misaligned. 
Fix your solution to correctly align the table rows and columns. Verify that your solution does not crash with values longer than their column labels.

---

## Extension Challenges

### First Challenge
You made the `Department` type conform to the `CustomStringConvertible` protocol. Refactor your playground from that chapter to move `CustomStringConvertible` conformance into an extension.


### Second Challenge
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

### Third Challenge
Give the `Int` type a nested `enum` with cases **even** and **odd**.
Also give `Int` a property of that type to correctly report whether an integer is even or odd.

```swift
let myInt = 2
print(myInt.evenOrOdd) // even
print(7.evenOrOdd) // odd
```

### Fourth Challenge (optional)
Update the `Int` a nested `enum` with cases **even** and **odd** to conform to `CustomStringConvertible` so it has a custom print description.
Make the protocol conformance of the enum in an extension

```swift
let myInt = 2
print(myInt.evenOrOdd) // Hey, I'm an even number
print(7.evenOrOdd) // Oh no, I'm an odd number
```
---

## Generic Challenges

### First Challenge
Create a generic `Pair` structure that holds two elements of any type (they can be different types). Implement a method to swap the two elements.

```swift
// usage example
var myPair = Pair("Hello", 1)

print(myPair) // Pair: Hello, 1
myPair.swap()
print(myPair) // Pair: 1, Hello
```

### Second Challenge
Add a `filter(_:)` method to your `Stack` structure. It should take a single argument, a closure that takes an `Element` and returns a `Bool`, and return a new `Stack<Element>` that contains any elements for which the closure returns true.
                                                                                                                                                                                             
### Third Challenge
Write a generic function called `findAll(_:_:)` that takes an array of any type `T` that conforms to the `Equatable` protocol and a single element (also of type `T`). 
`findAll(_:_:)` should return an array of integers corresponding to every location where the element was found in the array. For example, `findAll([5,3,7,3,9], 3)` should return `[1,3]` because the item 3 exists at indices 1 and 3 in the array. Try your function with both integers and strings.


### Fourth Challenge
Write an extension for the `Dictionary` type that adds a method `mapValuesToArray(_:)`. This method should take a closure that transforms the values of the dictionary and return an array of the transformed values.
```swift
// usage example
let dictionary = ["one": 1, "two": 2, "three": 3]
let stringValues = dictionary.mapValuesToArray { "\($0)" }
print(stringValues) // ["1", "2", "3"]
```

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

### Sixth Challenge (optional)
Modify the `findAll(_:_:)` function you wrote for the third challenge to accept a generic `Collection` instead of an array. 
> [!NOTE]
> You will need to change the return type from [Int] to an array of an associated type of the Collection protocol.



