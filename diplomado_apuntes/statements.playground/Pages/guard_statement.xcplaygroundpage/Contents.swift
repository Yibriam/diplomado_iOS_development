//: [Previous](@previous)

import Foundation

// We're on a roadtrip

var moneyAvailable: Float = 600
let bridgeToll: Float = 60
let tunnelToll: Float = 50
let gasPrice: Float = 525.40

// fill gas tank
guard moneyAvailable >= gasPrice  else {
    fatalError("You cannot move anymore, you're stranded.")
}

moneyAvailable -= gasPrice

// bridge 🌉
guard moneyAvailable >= bridgeToll else {
    fatalError("You don't have enough money to pass through the bridge")
}

moneyAvailable -= bridgeToll

// tunnel 🕳️
guard moneyAvailable >= tunnelToll else {
    fatalError("You don't have enough money to pass through the tunnel")
}

moneyAvailable -= tunnelToll

print("Arrived to your destination! Enjoy 🌊. Money left to spend \(moneyAvailable)")

// matching patterns

let point = (-50, 0)

guard case let (x, 0) = point, x < 0 else {
    fatalError("Only X values allowed")
}

//: [Next](@next)
