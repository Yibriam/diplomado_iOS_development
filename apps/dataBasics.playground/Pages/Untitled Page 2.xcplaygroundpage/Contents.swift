import UIKit

let queue = DispatchQueue(label: "serial.queue")

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
