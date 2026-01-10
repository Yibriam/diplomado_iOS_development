//: [Previous](@previous)

import Foundation

var greeting = "Hello, playground"

let queue = DispatchQueue(label: "Parallel.queue", attributes: .concurrent)

print("Starting...")

queue.async {
    print("Starting first task on queue")
    for i in 0...2 {
        sleep(2)
    }
    print("Finished task 1 on queue")
}


print("halfway through")

queue.async {
    print("Starting task 2 on queue")
    for i in 0...2 {
        sleep(2)
    }
    print("Finished task 2 on queue")
}

print("Finished")
