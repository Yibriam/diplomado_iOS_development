//
//  Branch.swift
//  donBigotes
//
//  Created by Yibriam on 23/01/26.
//

import Foundation

struct Branch: Codable {
    let id: Int
    let name: String
    let address: String
    let phone: String
    let openingHours: OpeningHours
    let location: Location
    let services: [String]

    enum CodingKeys: String, CodingKey {
        case id, name, address, phone, location, services
        case openingHours = "opening_hours"
    }
}
