//: [Previous](@previous)

/*:
 - Important:
⚠️ **Do not** modify any other part of the code except where comments explicitly indicate changes. If you do, **your experiment will be cancelled and not reviewed.**
 
 * Experiment:
 Write a function called siftBeans(fromGroceryList:) that takes a grocery list (as an array of strings) and “sifts out” the beans from the other groceries. The function should take one argument that has a parameter name called list, and it should return a named tuple of the type (beans: [String], otherGroceries: [String]).
 \
 \
    **Hint:** You may need to use a function on the String type called hasSuffix(_:)
 */

import Foundation
import XCTest

/*

class Tests: XCTestCase {
    func test_exerciseTests() {
        let result = siftBeans(fromGroceryList: ["green beans", "milk", "black beans", "pinto beans", "apples"])
        
        XCTAssertEqual(result.beans, ["green beans", "black beans", "pinto beans"])
        XCTAssertEqual(result.otherGroceries, ["milk", "apples"])
    }
    
    // TODO: - Add your code here
    
}

*/

class Tests: XCTestCase {
    func test_exerciseTests() {
        let result = siftBeans(fromGroceryList: ["green beans", "milk", "black beans", "pinto beans", "apples"])
        
        XCTAssertEqual(result.beans, ["green beans", "black beans", "pinto beans"])
        XCTAssertEqual(result.otherGroceries, ["milk", "apples"])
    }
    
    // TODO: - Add your code here
    func siftBeans(fromGroceryList: [String]) -> (beans: [String], otherGroceries: [String]) {
        var beans: [String] = []
        var otherGroceries: [String] = []
        
        for item in fromGroceryList {
            if item.lowercased().contains("beans") {
                beans.append(item)
            } else {
                otherGroceries.append(item)
            }
        }
        return (beans, otherGroceries)
    }
    
}

Tests.defaultTestSuite.run()

//: [Next](@next)
