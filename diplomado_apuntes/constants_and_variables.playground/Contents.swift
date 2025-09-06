import UIKit


// Variable

var greeting = "Hello, playground"
greeting = "Adiós"
var miVariableUno = "Mi variable"

// Constantes

let miConstanteUno = "Mi constante"
// miConstanteUno = "Adiós" // Error


// Declarar múltiples variables en una sola linea - Lista

var numeroUno = 3, numeroDos = 2, numeroTres = 4

// MARK: Tipos de datos
    // Inferencia y no inferencia de tipo.

var texto: String = "Hola"
var entero: Int = 10
var doble: Double = 10.5
var flotante: Float = 10.5
var booleano: Bool = true

// Números

let maxValueInt = Int.max
let minValueInt = Int.min

let maxValueUInt = UInt.max
let minValueUInt = UInt.min


var n1 = 0.1
var n2 = 0.2
var n3: Double = 3.0 // Esto es redundante mejor colocar 3

let suma = n1 + n2
print(suma)

var myVariable = 0.2 // ¿Es Float o Double?

// Si la variable es entera y sumar con un decimal no se pued, salvo que realices un casting

n1 + n3

// MARK: Operadores de comparación


n1 > n2 // Mayor que
n1 < n2 // Menor que
n1 >= n2 // Mayor o igual que
n1 <= n2 // Menor o igual que
n1 == n2 // Igual que
n1 != n2 // Diferente que
// n1 === n2 // Igual que a profundo nivel


// MARK: Colecciones

// MARK: Strings

let cadena1 = "Buenos "
let cadena2: String = "Días"  // Sin las comillas no se puede

let nombre = "Manuel"

cadena1 + cadena2

// Caracter de escape

let mensaje = "Buenos días \(nombre)"
let mensaje2 = "\(cadena1) \(cadena2) \(nombre)"

print(mensaje)

mensaje.isEmpty

"".isEmpty // Solo en playgrounds

// ESTO NOOOO!!!

mensaje.count == 0

var 😳 = 0
var 😎 = 3
😳 + 😎

// MARK: Array: ORDENADOS - Se pueden repetir

var miArreglo = [1,2,3,4]
var miArreglo2: [Int] = [1,2,3,4] // Otra manera de escribirlo
var miArreglo3: [Int] = [] // No sabe que hay dentro - Es necesario declarar de que tipo es

var anotherThreeDoubles = Array(repeating: 2.5, count: 3)
miArreglo[1]

var miArreglo4: [String] = ["hola", "adios"]

// Agregar

miArreglo4.append("adios")
miArreglo4 += ["adios","Holi","Bye"]

// Modificar

miArreglo4[0] = "iOS"
miArreglo4

// Insertar

miArreglo4.insert("Swift", at: 1)
miArreglo4

// Remover

miArreglo4.remove(at: 1)
miArreglo4.removeLast()
miArreglo4

miArreglo4.count
miArreglo4.isEmpty

// MARK: Sets - Un conjunto de datos que no se pueden repetir - tipo Hashable

var miSet = Set<Int>()
var miSet2 = Set([1,2,3,4])
// var miSet2 = Set([1,1,2,3,4]) No inserta otro numero 1 y cambia el orden
var miSet3: Set<String> = ["Rock", "Classical", "Hip Hop"]

miSet3.insert("Jazz")
miSet3.insert("Jazz") // No se puede y marca inserted = false

miSet3.contains("Jazz")

miSet3.remove("Rock")
miSet3

// MARK: Diccionarios - LLave/Valor


var miDiccionario: [String: Int] = ["apple": 2, "banana": 5, "orange": 4]

var airports: [String: String] = [
    "AICM": "Benito Juarez",
    "AIFA": "Dublin"
]

var miDiccionario2: [String:String] = [:]

// Obtener un valor

airports["AICM"]

// Modificar un valor

airports["AIFA"] = "EdoMex"

//Remover

airports["AIFA"] = nil
airports.removeValue(forKey: "AIFA")

// MARK: Tuplas - Un elemento puede tener varios valores

var color = ("#ff0000", "Rojo")

var tupla: (String, Int) = ("Dante Sanchez", 8)
var tupla2 = (nombre: "Dante Sanchez",edad: 8)

tupla.0
tupla2.nombre

// MARK: Operadores lógicos

// &&
// OR ||
// NOT !

/* En swift, el operador % (remainder / residuo) no funciona exactamente igual que en otros lenguajes como C; Java o Python; porque Swift difrencia entre "módulo" y "residuo" */



// Ejercicio 1

var nombre1 = "Yibriam"
let entero2: Int = 19

// Ejercicio 2

var nombre2: String = "Yibiris"
var entero3: Int = 20
var doble2: Double = 30.3
var booleano2: Bool = true

// Ejercicio 3

var doble3 =  4.5
var doble4 =  5.6

let division = doble3/doble4
print(division)

doble3 > doble4

// Ejercicio 4

var entero4 = 6
var entero5 = 7
let suma2 = entero4 + entero5
print(suma)

// Ejercicio 5

let nombre3 = "YIBRIAM"
let apellido = "GALVAN"

print("Hola \(nombre3) \(apellido), ¿cómo estás?")

// Ejercicio 6

var persona: (String, Int, Bool) = (nombre:"Yibriam", edad:28, registrado:true)
print(persona)

// Ejercicio 7

var miSet4 = Set([1,2,3,4,4,2])
var miSet5: Set<Int> = [1, 2, 3, 4, 4, 2]

miSet4.insert(5)
miSet4.insert(1)
miSet4

// Ejercicio 8

var miArreglo5 = ["Platano","Sandia","Melón","Naranja","Mandarina"]
miArreglo5.append("Limón")
miArreglo5[0]
miArreglo5[5]
print(miArreglo5[0])
print(miArreglo5[5])

// Ejercicio 9

var edades: [String: Int] = ["Alejandra": 25, "Sofia": 34, "Jose": 47]

// Ejercicio 10

// Set - Un conjunto de datos que no se pueden repetir
// Array - Un conjunto de datos ordenados y se pueden repetir
// Diccionario - Un conjunto de datos que tiene una llave y un valor







