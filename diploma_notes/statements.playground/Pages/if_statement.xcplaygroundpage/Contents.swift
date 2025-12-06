import UIKit

//let characters = ["Sam", "Dean", "Jack", "Jody", "Bobby", "Castiel", "Garth"]



var pet: String = "dog"

if pet == "dog" {
    print("🐶")
}

if pet == "dog" && pet == "cat" {
    print("Alone in the world was a little catdog 🎵")
}

pet = "rat"
if pet == "dog" || pet == "cat" {
    print("A common pet")
}

if pet == "dog" {
    print("🐶")
} else {
    print("some random animal")
}

if pet == "dog" {
    
} else if pet == "cat" {
    
} else {
    
}

let age: Int = 18
pet = "cat"

if age >= 18 && (pet == "dog" || pet == "cat") {
    print("adopted")
}


let petType = if pet == "dog" {
    "canine"
} else if pet == "cat" {
    "feline"
} else {
    "other"
}

if #available(iOS 26, *) {
    // Some cool liquid glass thing
} else {
    // Fallback for older OS versions
}

if #unavailable(iOS 26) {
    // Support to previous OS versions
}

// pattern matching
let point = (-50, 0)

if case let (x, 0) = point, x < 0 {
    print("X axis, negative")
} 
