//
//  Store.swift
//  donBigotes
//
//  Created by Yibriam on 23/01/26.
//

import Foundation

struct DonBigotesResponse: Codable {
    let store: Store
}

struct Store: Codable {
    let name: String
    let slogan: String
    let description: String
    let logoUrl: String
    let branches: [Branch]

    enum CodingKeys: String, CodingKey {
        case name, slogan, description, branches
        case logoUrl = "logo_url"
    }
}

struct Location: Codable {
    let latitude: Double
    let longitude: Double
}

