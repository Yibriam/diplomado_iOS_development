//: [Previous](@previous)

/*:
 - Important:
⚠️ **Do not** modify any other part of the code except where comments explicitly indicate changes. If you do, **your experiment will be cancelled and not reviewed.**
 
 * Experiment:
 Using the `time` variable, assign `true` or `false` to `shouldWearSunscreen` based on the following conditions:
    - From 7 to 18 -> `true`
    - From 19 to 6 -> `false`
    - Any other value: **do not assign anything** to the variable
 \
 \
    **Note:** Use a 24-hour clock and only consider whole numbers (no fractions).
*/

import Foundation
import XCTest

class Tests: XCTestCase {
    func test_shouldApplySunscreenVariableShouldHaveTheExpectedValue() {
        let sunscrenArray = [7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18]
        let noSunscreenArray = [0, 1, 2, 3, 4, 5, 6, 19, 20, 21, 22, 23]
        for element in sunscrenArray {
            XCTAssert(SunscreenNotifier(time: element).shouldApplySunscreen!)
        }
        for element in noSunscreenArray {
            XCTAssertFalse(SunscreenNotifier(time: element).shouldApplySunscreen!)
        }
        XCTAssertNil(SunscreenNotifier(time: 24).shouldApplySunscreen)
    }
}

/*

struct SunscreenNotifier {
    var shouldApplySunscreen: Bool? = nil
    
    init(time: Int) {
        // TODO: - Add your code here
    }
}

*/

struct SunscreenNotifier {
    var shouldApplySunscreen: Bool? = nil
    
    init(time: Int) {
        // TODO: - Add your code here
        switch time {
        case 7...18:
            shouldApplySunscreen = true
        case 0...6, 19..<24:
            shouldApplySunscreen = false
        default:
            break
        }
    }
}

Tests.defaultTestSuite.run()

//: [Next](@next)
