import UIKit

// MARK: Exercise 1

struct Rectangle {
    let width: Double
    let height: Double

    func area() {
        let totalArea = width * height
        print("Area: \(totalArea)")
    }

    func perimeter() {
        let totalPerimeter = 2 * (width + height)
        print("Perimeter: \(totalPerimeter)")
    }
}

let rectangle1 = Rectangle(width: 5, height: 2)
rectangle1.area()
rectangle1.perimeter()

// MARK: Ejercicio 2

struct Student {
    let name: String
    let grades: [Int]
    
    func averageGrade() {
        var total = 0
        for point in grades {
            total += point
        }
        let grade = total/grades.count
        print("Grade: \(grade)")
    }
}

let alumno1 = Student(name: "Jose", grades: [6,7,8,7,9,10,8])
alumno1.averageGrade()

/*

// MARK: Ejercicio 3
Crea una estructura Inventario que tenga un diccionario de productos ([String: Int]).
Agrega una función que devuelva el producto con mayor stock.
⸻
*/

struct Inventory {
    var products: [String: Int]
    
    func maxAmount() {
        guard let maxValue = products.values.max() else {
            print("Inventory is empty.")
            return
        }
        
        for (key, value) in products {
            if value == maxValue {
                print("Product with max amount: \(key) - \(value)")
            }
        }
    }
}

let myProducts = Inventory(products: ["Oranges": 3, "Bananas": 6, "Grapes": 5])
myProducts.maxAmount()

/*
// MARK: Ejercicio 4
Crea una estructura Club con propiedad miembros: Set<String>.
Agrega funciones para:
1. Añadir un miembro.
2. Eliminar un miembro.
3. Verificar si alguien pertenece al club.
⸻
*/

struct Club {
    var members: Set<String> = ["Mario","Luigi","Peach","Daisy","Bowser","Toad"]
    
    mutating func addMember(newMember: String) {
        members.insert(newMember)
        print(members)
    }
    
    mutating func deleteMember(member: String) {
        members.remove(member)
        print(members)
    }
    
    func existingMember(name: String) {
        print(members.contains(name))
    }
}

var club1 = Club()

club1.addMember(newMember: "Waluigi")
club1.deleteMember(member: "Toad")
club1.existingMember(name: "Mario")

/*
// MARK: Ejercicio 5
Crea una estructura Persona con propiedades nombre (String) y edad (Int).
Agrega una función que reciba otra persona y devuelva la persona mayor.
⸻
 
*/

struct Person {
    let name: String
    let age: Int
    
    func oldestPerson() {
        
    }
    
}

/*
// MARK: Ejercicio 6
Crea una estructura Producto con nombre (String) y precio (Double).
Crea un array con cinco productos y una función que devuelva el producto más caro.
⸻
*/

struct Product1 {
    var productName: String
    var price: Double
    
    var array1 = ["iPhone", "AirPods"]
}

/*
 // MARK: Ejercicio 7
Crea una estructura Curso con nombre (String) y alumnos ([String]).
Crea un diccionario [String: Curso] y escribe una función que devuelva el curso con más alumnos.
⸻
*/

struct Course {
    var courseName: String
    var students: [String]
    
    var myDictionary: [String:String] = [:]
    
    func course() {
        
    }
}

/*
// MARK: Ejercicio 8
Crea una estructura Punto con x y y (Double).
Agrega funciones para calcular:
1. Distancia a otro punto.
2. Cuadrante en que se encuentra el punto.
⸻
*/

struct Point {
    var x: Double
    var y: Double
    
    func distanceBetween() {
        
    }
    
    func quadrant() {
        
    }
}

/*
// MARK: Ejercicio 9
Crea una estructura Materia con nombre (String) y calificaciones ([Int]).
Agrega una función que devuelva una tupla (nombre: String, promedio: Double) indicando la materia y su promedio.
⸻
*/

struct Subject {
    var name: String
    var grades: [Int]
    
    func gradesSubject() -> (String, Double) {
        return ("Apple", 23)
    }
}

/*
// MARK: Ejercicio 10
Crea una estructura Tienda con un array de productos ([Producto]).
Agrega funciones para:
1. Agregar un producto.
2. Eliminar un producto por nombre.
3. Devolver el precio total de todos los productos.

*/

struct Product {
    var name: String
    var price: Double
}

struct Store {
    var products: [Product]
    
    mutating func addProduct(_ product: Product) {
        products.append(product)
    }
    
    mutating func removeProduct(_ name: String) {
        products.removeAll { $0.name == name }
    }
    
    func totalPrice() -> Double {
        return products.reduce(0) { $0 + $1.price }
    }
}

var store = Store(products: [])
store.addProduct(Product(name: "iPhone", price: 25000))
store.removeProduct("iPhone")
store.totalPrice()

// map, reduce and filter
