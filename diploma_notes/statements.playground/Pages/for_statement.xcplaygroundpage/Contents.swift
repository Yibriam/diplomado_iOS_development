//: [Previous](@previous)

import Foundation

let characters = ["Sam", "Dean", "Jack", "Jody", "Bobby", "Castiel", "Garth"]

for character in characters {
//    print(character + " is a character from a series called Supernatural")
}

let pokemonList = ["Fire": "Charmander", "Water": "Mudkip", "Grass": "Turtwig", "Electric": "Pikachu"]

for pokemon in pokemonList {
//    print(pokemon.key + " is of type " + pokemon.value)
}

for (type, name) in pokemonList {
//    print(name + " is of type " + type)
}

let numbers = 1...10

for number in numbers where number % 2 == 0 {
//    print(number)
}

for number in numbers {
    if number % 2 == 0 {
//        print(number)
    }
}

for _ in numbers {
//    print("hello!")
}

// check for only even numbers
let evenNumbers = stride(from: 0, through: 10, by: 2)
let mixedNumbers = [2,4,5,6,7]
for number in evenNumbers {
    if number % 2 == 0 {
//        print(number)
        continue // this will stop here and force the next cycle
    }
    print("odd numbers are not allowed")
    break // this will end the cycles altogether
}


let coordinate = [(0,-5), (4, 3), (0,9)]

for case let (0, y) in coordinate {
    print("\(y) is on the x axis")
}
//: [Next](@next)
