//: [Previous](@previous)

/*:
  - Important:
 ⚠️  **Do not** modify any other part of the code except where comments explicitly indicate changes. If you do, **your experiment will be cancelled and not reviewed.**
 
 * Experiment:
 Part 1. Given a die roll, program a Snakes and Ladders game using the image below.  With each roll, assign the square in which the player lands (after going up the ladder or down the snake) to `currentSquare`
    - The first square should start at 0.
 
    Part 2. Modify your code to play without any input. Print the position in  which the player lands after each roll
    \
        - You may use `currentSquare` as an aux variable and reuse part 1 if you desire
        \
        - It does not matter if the final die roll causes the player to exceed the last square.
        \
        - Hint: use a random  die
 */

//: ![Imagine a game of Snakes and Ladders >:v](board.png)

import Foundation
import XCTest

class Tests: XCTestCase {
    func test_shouldApplySunscreenVariableShouldHaveTheExpectedValue() {
        var game = SnakesAndLadders()
        game.play(dieRolls: 5)
        XCTAssertEqual(game.currentSquare, 16)
        game.play(dieRolls: 2)
        XCTAssertEqual(game.currentSquare, 7)
        game.play(dieRolls: 4)
        XCTAssertEqual(game.currentSquare, 3)
        game.play(dieRolls: 5)
        XCTAssertEqual(game.currentSquare, 17)
        game.play(dieRolls: 5)
        XCTAssertEqual(game.currentSquare, 22)
        game.play(dieRolls: 2)
        XCTAssertEqual(game.currentSquare, 24)
    }
}

/*

struct SnakesAndLadders {
    var currentSquare: Int = 0
    
    func play(dieRolls: Int) {
        // TODO: - Add first part here
    }
    
    func play() {
        // TODO: - Add second part here
    }
}

*/

struct SnakesAndLadders {
    var currentSquare: Int = 0
    
    mutating func play(dieRolls: Int) {
        // TODO: - Add first part here
        currentSquare += dieRolls
        switch currentSquare {
        case 2: currentSquare = 7
        case 5: currentSquare = 16
        case 8: currentSquare = 17
        case 11: currentSquare = 3
        case 13: currentSquare = 3
        case 15: currentSquare = 23
        case 17: currentSquare = 16
        case 18: currentSquare = 7
        case 23: currentSquare = 15
        case 24: currentSquare = 24
            break
        default:
            break
        }
        
        print("Current square: \(currentSquare)")
        
    }
    
    mutating func play() {
        // TODO: - Add second part here
        let die = Int.random(in: 1...6)
        play(dieRolls: die)
        
    }
}

Tests.defaultTestSuite.run()


//: [Next](@next)
