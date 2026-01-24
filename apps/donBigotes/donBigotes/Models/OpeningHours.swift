//
//  OpeningHours.swift
//  donBigotes
//
//  Created by Yibriam on 23/01/26.
//

import Foundation

struct OpeningHours: Codable {
    let weekdays: TimeRange?
    let saturday: TimeRange?
    let sunday: TimeRange?
}

struct TimeRange: Codable {
    let open: String
    let close: String
    
    var formatted: String {
        return "\(open) - \(close)"
    }
}
