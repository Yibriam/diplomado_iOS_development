//: [Previous](@previous)

/*:
 - Important:
⚠️ **Do not** modify any other part of the code except where comments explicitly indicate changes. If you do, **your experiment will be cancelled and not reviewed.**
 
 * Experiment:
    1. How many increments of 15 are in the range zero **through** 285? Add them to the `throughCounter` variable. Also, print each increment.
    2. How many increments of 4 are in the range zero **to** 60? Add them to the `toCounter` variable. Also, print each increment.
 
    **Notes:**
    \
        - **Do not** use fixed arrays. That's cheating 😡
    \
        - **Hint:** Find the difference between this exercise's title and Jem's song.
 */

import Foundation
import XCTest

class Tests: XCTestCase {
    func test_firstExercise() {
        var sut = JustAStride()
        sut.firstExercise()
        XCTAssertEqual(19, sut.throughCounter)
    }
    
    func test_secondExercise() {
        var sut = JustAStride()
        sut.secondExercise()
        XCTAssertEqual(14, sut.toCounter)
    }
}

/*

struct JustAStride {
    var throughCounter: Int = 0
    var toCounter: Int = 0
    
    mutating func firstExercise() {
        // TODO: - Add your code here
    }
    
    mutating func secondExercise() {
        // TODO: - Add your code here
        
    }
}

*/

struct JustAStride {
    var throughCounter: Int = 0
    var toCounter: Int = 0
    
    mutating func firstExercise() {
        // TODO: - Add your code here
        for number in stride(from: 0, to: 285, by: 15){
            print(number)
            throughCounter += 1
        }
    }
    
    mutating func secondExercise() {
        // TODO: - Add your code here
        for number in stride(from: 0, to: 60, by: 4){
            print(number)
            toCounter += 1
        }
    }
}

Tests.defaultTestSuite.run()

//: [Next](@next)
