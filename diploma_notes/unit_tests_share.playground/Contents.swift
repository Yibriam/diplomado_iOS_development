import UIKit
import XCTest

class ArithmeticExpressionTests: XCTestCase {
    
    
    func test_ShouldAddTwoNumbers() {
        //given
        let expression = ArithmeticExpression.add(.digit(2), .digit(3))
        
        //when
        let result = try! ArithmeticExpression.evaluate(expression)
        
        // then
        XCTAssertEqual(result, 5)
    }
    
    func test_ShouldThrowErrorWhenDividingByZero() {
        let expression = ArithmeticExpression.divide(.digit(8), .digit(0))
        let expression2 = ArithmeticExpression.divide(.digit(8), .add(.digit(-2), .digit(2)))
        
        XCTAssertThrowsError(try ArithmeticExpression.evaluate(expression))
        XCTAssertThrowsError(try ArithmeticExpression.evaluate(expression2))
    }
    
    
}

indirect enum ArithmeticExpression {
    case digit(Double)
    case add(_ lhs: ArithmeticExpression, _ rhs: ArithmeticExpression)
    case divide(_ lhs: ArithmeticExpression, _ rhs: ArithmeticExpression)
    
    static func evaluate(_ expression: ArithmeticExpression) throws -> Double {
        switch expression {
        case let .digit(value): return value
        case let .add(left, rigth): return try evaluate(left) + evaluate(rigth)
        case let .divide(left, right):
            guard let right = try? evaluate(right), right != 0.0 else {
                throw NSError()
            }
            return try evaluate(left) / right
        }
    }
}

ArithmeticExpressionTests.defaultTestSuite.run()
