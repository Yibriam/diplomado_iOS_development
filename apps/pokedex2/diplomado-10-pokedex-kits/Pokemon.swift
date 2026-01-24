//
//  Pokemon.swift
//  diplomado-10-pokedex-kits
//
//  Created by Alejandro Mendoza on 17/01/26.
//

import Foundation

struct Evolution: Codable {
    let name: String
    let num: String
}

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
    
    let weaknesses: [String]?
    let nextEvolution: [Evolution]?
    let prevEvolution: [Evolution]?
    
    private enum CodingKeys: String, CodingKey {
        case id
        case number = "num"
        case name
        case imageURL = "img"
        case type
        case location
        case weaknesses
        case nextEvolution = "next_evolution"
        case prevEvolution = "prev_evolution"
    }
}

