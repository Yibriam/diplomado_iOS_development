//
//  Models.swift
//  countryInformation
//
//  Created by Yibriam on 05/12/25.
//

import Foundation

struct Country: Codable, Hashable {
    let id: Int
    let nombre: String
}

struct CountryDetail: Codable {
    let nombre: String
    let capital: String
    let idioma: String
}

struct CountryCurrency: Codable {
    let nombre: String
    let moneda: String
}

// Capitals.json: array with one big object mapping country -> [ { estado } ]
struct CountryStatesRoot: Codable {
    let value: [String: [StateEntry]]

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let dict = try container.decode([String: [StateEntry]].self)
        self.value = dict
    }
}

struct StateEntry: Codable, Hashable {
    let estado: String
}

// PointsOfInterest.json: nested object: { "Paises": [ { "CountryName": [ { "estado": "...", "lugares": ["..."] } ] } ] }
struct PointsOfInterestRoot: Codable {
    let Paises: [POICountryWrapper]
}

struct POICountryWrapper: Codable {
    let map: [String: [POIState]]

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let dict = try container.decode([String: [POIState]].self)
        self.map = dict
    }
}

struct POIState: Codable {
    let estado: String
    let lugares: [String]
}

// Flags.json: simple [String: String]
typealias FlagsMap = [String: String]

// CurrencyConversion.json: array of maps, each base -> [target: rate]
struct CurrencyRatesRoot: Codable {
    let items: [CurrencyRateItem]
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let arr = try container.decode([CurrencyRateItem].self)
        self.items = arr
    }
}
struct CurrencyRateItem: Codable {
    let map: [String: [String: Double]]
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let dict = try container.decode([String: [String: Double]].self)
        self.map = dict
    }
}
