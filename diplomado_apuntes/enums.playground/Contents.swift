import UIKit

enum TrafficLight {
    case red
    case yellow
    case green
}

let currentLight = TrafficLight.yellow
let anotherLight: TrafficLight = .red

switch currentLight {
case .green: print("green")
case .red: print("red")
case .yellow: print("yellow")
}


enum AnimalType: String {
//    case mammal, bird, reptile // sin expecificar
    case mammal = "mamifero"
    case bird = "ave"
    case reptile = "reptil"
    
    init?(string: String) {
        self.init(rawValue: string.lowercased())
    }
    
    init(_ string: String) {
        if let value = Self.init(string: string) {
            self = value
        } else {
            self = .reptile
        }
    }
}

let animal = AnimalType.bird.rawValue
let usersAnimalNil = AnimalType(rawValue: "Ave")
let usersAnimal = AnimalType(rawValue: "ave")


enum ContactMethod {
    case email(String)
    case phone(countryCode: Int, number: String)
    case postal(street: String, zip: String)
    
    func description() -> String {
        return switch self {
        case let .email(address): address
        case let .phone(countryCode, number): "+\(countryCode) \(number)"
        case let .postal(street, zip): "st \(street), \(zip)"
        }
    }
}


let contact = ContactMethod.email("lol@gmail.com")
let youtContact = ContactMethod.email("another@g.com")


contact.description()

enum Pet {
    case dog, cat, parrot, turtle
    
    
    var animalType: AnimalType {
        switch self {
        case .cat, .dog: .mammal
        case .parrot: .bird
        case .turtle: .reptile
        }
    }
}


enum Metrics {
    static let maxTries = 3
    
    static func convert(fh: Double) {
        
    }
}

struct Strcutre {
    static let maxTries = 4
}

class AClass {
    static func convert(fh: Double) {
        
    }
    
    class func convert(celsius: Double) {
        
    }
}


Metrics.maxTries
Strcutre.maxTries
