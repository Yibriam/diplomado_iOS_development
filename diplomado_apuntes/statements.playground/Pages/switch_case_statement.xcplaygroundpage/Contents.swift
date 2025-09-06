//: [Previous](@previous)

import Foundation

var animal = "dog"

let emoji = switch animal {
case "dog": "🐶"
case "cat": "🐱"
case "mouse": "🐹"
case "bird": "🦅"
default: "🤔"
}

print(emoji)

switch animal {
case "dog", "cat", "bird", "mouse" : print("common pet")
default: print("🤔")
}

let grade = 5
switch grade {
case ...5: print("Failed")
case 5..<9: print("Passed")
case 10...: print("Genius")
case 9: print("9 is great")
default: print("Amazing!")
}

// tuples and wildcards
var color = (255, 255, 255)

switch color {
case (_, _, 255): print("max blue")
case (_, 255, _): print("max green")
case (255, _, _): print("max red")
case (255, 255, 255): print("white")
default: break
}

// value binding and where clause
color = (255, 166, 35)
switch color {
case let (255, g, b) where g < 255 && b < 255: print("max red with green \(g) and blue \(b)")
case (let r, let g, 255) where g < 255 && r < 255: print("Max blue with red:\(r) and green:\(g)")
case let (255, g, b) where g < 255 && b < 255: print("Max blue with blue:\(b) and green:\(g)")
case (255, 255, 255): print("white")
default: print("random color")
}


//: [Next](@next)
