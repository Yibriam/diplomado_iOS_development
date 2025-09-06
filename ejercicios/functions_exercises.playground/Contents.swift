import UIKit

// MARK: Exercise 1

func factorial(_ n: Int) -> Int {
    if n == 0 {
        return 1
    } else {
        return n * factorial(n - 1)
    }
}

print(factorial(5))


// MARK: Exercise 2

func isPrimeNumber(_ n: Int) -> Bool {
    return n > 1 && !(2..<n).contains { n % $0 == 0 }
}

print(isPrimeNumber(17))

// MARK: Exercise 3

func isPalindrome(_ text: String) -> Bool {
    if text.lowercased().reversed() == text.lowercased() {
        return true
    } else {
        return false
    }
}

print(isPalindrome("ANA"))
