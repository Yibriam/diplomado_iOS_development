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
    if String(text.lowercased().reversed()) == text.lowercased() {
        return true
    } else {
        return false
    }
}

print(isPalindrome("ANA"))

// MARK: Exercise 4

func countVocals(_ text: String) -> [Character: Int] {
    var vocalsCounted: [Character: Int] = [:]
    let vocals: Set<Character> = ["a", "e", "i", "o", "u", "A", "E", "I", "O", "U"]
    

    for letter in text {
        if vocals.contains(letter) {
            vocalsCounted[letter, default: 0] += 1
        }
    }

    return vocalsCounted
}

print(countVocals("Hola"))


// MARK: Exercise 5

func sortNumbers(_ numbers: [Int]) -> [Int] {
    var sortedNumbers = numbers
    let n = sortedNumbers.count
    for i in 0..<n {
        for j in 0..<n - i - 1 {
            if sortedNumbers[j] > sortedNumbers[j + 1] {
                sortedNumbers.swapAt(j, j + 1)
            }
        }
    }
    return sortedNumbers
}

print(sortNumbers([20,55,47,34,82,9,23,45]))


// MARK: Exercise 6

func fibonacci(_ number: Int) -> Int {
    if (number <= 1) {
        return number;
    }
    // Recursive case
    return fibonacci(number - 1) + fibonacci(number - 2);
}

print(fibonacci(12))

// MARK: Exercise 7

func sumDigits(_ number: Int) -> Int {
    let intToString = String(abs(number))
    var sum = 0
    for digit in intToString {
        if let digitInt = Int(String(digit)) {
            sum += digitInt
        }
    }
    return sum
}

print(sumDigits(348))

// MARK: Exercise 8

func mcd(_ number1: Int, _ number2: Int) -> Int {
    var numA = number1
    var numB = number2
    while numB != 0 {
        let temp = numB
        numB = numA % numB
        numA = temp
    }
    return numA
}

print(mcd(48, 18))

// MARK: Exercise 9

func isPerfect(_ number: Int) -> Bool {
    if number <= 0 {
        return false
    }
    
    var sumDivisors = 0
    for i in 1...Int(sqrt(Double(number))) {
        if number % i == 0 {
            sumDivisors += i
            if i * i != number && i != 1 {
                sumDivisors += number / i
            }
        }
    }
    return sumDivisors == number
}

print(isPerfect(28))

// MARK: Exercise 10 – Conversor de bases
/*Crea una función convertirABase(_ numero: Int, base: Int) que convierta un número decimal a
otra base (2 = binario, 8 = octal, 16 = hexadecimal).
Ejemplo: convertirABase(10, base: 2) → "1010".
*/

func convertToBase(_ number: Int, base: Int) {
    let binaryString = String(number, radix: 2)
    let octalString = String(number, radix: 8)
    let hexalString = String(number, radix: 16, uppercase: true)
    
    switch base {
    case 2:
        print(binaryString)
    case 8:
        print(octalString)
    case 16:
        print(hexalString)
    default:
        break
    }
}

convertToBase(345, base: 2)
