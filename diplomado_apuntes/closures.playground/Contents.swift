import UIKit

func isAscending(_ i: Int, _ j: Int) -> Bool {
    return i < j
}
//(Int, Int) -> Bool

func foo() {
    
}
//() -> Void

let isAscendingFuntion = isAscending

var volunteerCount = [1, 3, 40, 32, 2, 53, 77, 13]
//volunteerCount.sort()
volunteerCount.sort(by: isAscending)

volunteerCount.sort { (i: Int, j: Int) -> Bool in
    return i < j
}

volunteerCount.sort { i, j in
    return i < j
}

volunteerCount.sort(by: { $0 < $1 })

volunteerCount.sort { $0 > $1 }


func format(numbers: [Double], using formatter: (Double) -> String /*= {"\($0)"}*/ ) -> [String] {
    var result = [String]()
    
    for number in numbers {
        let transformed = formatter(number)
        result.append(transformed)
    }
    
    return result
}

let rounder: (Double) -> String = { (number: Double) -> String in
    let roundedNumber = number.rounded()
    let intRounded = Int(roundedNumber)
    return "\(intRounded)"
}

let prices = [5.4892, 44.567, 46.082, 58.68, 6.96441, 0.3]
format(numbers: prices, using: rounder)
//print(format(numbers: prices))


func experimentWithScopes() {
    
    var numberOfTransformations = 0
    
    
    let rounder: (Double) -> String = {
        numberOfTransformations += 1
        return String(format: "$%0.2f", $0)
    }
    
    let otherPrices = [5.4892, 44.567, 46.082, 58.68, 6.96441, 0.3]
    let moneyFormatted = format(numbers: otherPrices, using: rounder)
    print(moneyFormatted)
    print(numberOfTransformations)
}

experimentWithScopes()


let volunteerAverages = [10, 4.2, 1.5, 12.2, 16.815]
volunteerAverages.reduce(0.0) { partialResult, average in
    partialResult + average
}

var partialResult = 0.0
for average in volunteerAverages {
    partialResult += average
}
partialResult
// () -> Void

// ([Double], (Double) -> String) -> [String]
