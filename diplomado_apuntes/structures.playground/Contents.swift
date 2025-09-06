import UIKit

struct WorkoutA {
    let dateAndTime: Date
    
    func summary() -> String {
        return ""
    }
}

let firstWorkout = WorkoutA(dateAndTime: .now)

struct WorkoutB {
    let date: Date = Date()
}

let workoutB = WorkoutB()


struct WorkoutC {
    let dateAndTime: Date
    
    init(date: Date = Date()) {
        self.dateAndTime = date
    }
}

let workoutC = WorkoutC(date: .now)
let workoutC2 = WorkoutC()

struct WorkoutD {
    let date: Date
}

extension WorkoutD {
    init() {
        self.date = .now
    }
    
    init(anotherDate: Date = Date()) {
        date = anotherDate
    }
}

let workoutD = WorkoutD(date: .now)
let workoutD2 = WorkoutD()


struct Workout {
    let name: String
    var dateAndTime: Date
    var duration: Int = 30 {
        didSet {
            print("Duration changed from \(oldValue) to \(duration)")
        }
        willSet {
            print("Duration will change from \(duration) to \(newValue)")
        }
    }
    var caloriesBurned: Int = 1 {
        willSet(new) {
            print("Calories burned will change from \(caloriesBurned) to \(new)")
        }
        didSet(old) {
            print("Calories burned has changed from \(old) to \(caloriesBurned)")
        }
    }
    
    var intensity: Double {
        guard duration > 0 else { return 0 }
        let caloriesPerMinute = Double(caloriesBurned) / Double(duration)
        return caloriesPerMinute / 15 * 100
    }
    
    func summary() -> String {
        return "Workout: \(name)\nDuration:\(duration) minutes\nCalories: \(caloriesBurned) kcal"
    }
    
    mutating func extend(by extraMinutes: Int, andCalories extraCalories: Int) {
        duration += extraMinutes
        caloriesBurned += extraCalories
    }
}

let morningWorkout = Workout(name: "morning run", dateAndTime: .now)
morningWorkout.dateAndTime
//morningWorkout.dateAndTime = Date().addingTimeInterval(3600) // error
//morningWorkout.extend(by: 10, andCalories: 1)

var morningWorkout2 = Workout(name: "morning run", dateAndTime: .now)
morningWorkout2.dateAndTime = Date().addingTimeInterval(3600)
morningWorkout2.dateAndTime
morningWorkout2.extend(by: 10, andCalories: 1)

var morningWorkoutCopy = morningWorkout2

morningWorkout2.dateAndTime = Date().addingTimeInterval(7200)
morningWorkout2.dateAndTime

morningWorkoutCopy.dateAndTime = Date().addingTimeInterval(3600)
morningWorkoutCopy.dateAndTime

morningWorkoutCopy.intensity
morningWorkoutCopy.extend(by: 30, andCalories: 1200)
morningWorkoutCopy.intensity
//morningWorkout.name = "new name"
