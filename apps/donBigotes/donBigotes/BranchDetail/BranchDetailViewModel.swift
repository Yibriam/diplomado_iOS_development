//
//  BranchDetailViewModel.swift
//  donBigotes
//
//  Created by Yibriam on 23/01/26.
//

import Foundation

class BranchDetailViewModel {
    
    private let branch: Branch
    
    var name: String { branch.name }
    var fullAddress: String { branch.address }
    var phone: String { branch.phone }
    
    var mondayFridayHours: String {
        formatTimeRange(branch.openingHours.weekdays)
    }
    
    var saturdayHours: String {
        formatTimeRange(branch.openingHours.saturday)
    }
    
    var sundayHours: String {
        formatTimeRange(branch.openingHours.sunday)
    }
    
    var servicesList: String {
        branch.services.joined(separator: " • ")
    }
    
    var coordinate: (latitude: Double, longitude: Double) {
        (branch.location.latitude, branch.location.longitude)
    }
    
    init(branch: Branch) {
        self.branch = branch
    }
    
    private func formatTimeRange(_ range: TimeRange?) -> String {
        guard let range = range else {
            return "Cerrado"
        }
        return "\(range.open) - \(range.close)"
    }
}
