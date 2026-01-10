import UIKit

let queue = DispatchQueue(label: "serial.queue")

print("Starting...")

queue.sync {
    print("Starting first task on queue")
    for i in 0...2 {
        sleep(2)
    }
    print("Finished task 1 on queue")
}


print("halfway through")

queue.sync {
    print("Starting task 2 on queue")
    for i in 0...2 {
        sleep(2)
    }
    print("Finished task 2 on queue")
}

print("Finished")
