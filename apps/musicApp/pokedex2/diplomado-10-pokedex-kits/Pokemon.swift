//
//  Pokemon.swift
//  diplomado-10-pokedex-kits
//
//  Created by Alejandro Mendoza on 17/01/26.
//

import Foundation

struct Pokemon: Codable {
    struct Location: Codable {
        let latitude: Double
        let longitude: Double
    }
    let id: Int
    let number: String
    let name: String
    let imageURL: String
    let type: [String]
    let location: Location?
    
    private enum CodingKeys: String, CodingKey {
        case id
        case number = "num"
        case name
        case imageURL = "img"
        case type
        case location
    }
}
