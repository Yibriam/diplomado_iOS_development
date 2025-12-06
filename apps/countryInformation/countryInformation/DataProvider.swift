//
//  DataProvider.swift
//  countryInformation
//
//  Created by Yibriam on 05/12/25.
//

import Foundation

final class DataProvider {
    static let shared = DataProvider()

    private(set) var countries: [Country] = []
    private(set) var detailsByCountry: [String: CountryDetail] = [:]
    private(set) var currencyByCountry: [String: CountryCurrency] = [:]
    private(set) var flags: [String: String] = [:]
    private(set) var statesByCountry: [String: [String]] = [:]
    private(set) var poiByCountryState: [String: [String: [String]]] = [:] // country -> state -> lugares
    private(set) var rates: [String: [String: Double]] = [:] // base -> [target: rate]

    private init() {
        loadAll()
    }

    private func loadAll() {
        countries = load([Country].self, fileName: "Countrys") ?? []
        let details = load([CountryDetail].self, fileName: "CountriesDetails") ?? []
        details.forEach { detailsByCountry[$0.nombre] = $0 }
        let currencies = load([CountryCurrency].self, fileName: "Currency") ?? []
        currencies.forEach { currencyByCountry[$0.nombre] = $0 }
        flags = load(FlagsMap.self, fileName: "Flags") ?? [:]

        // Capitals -> states
        if let capRoot = load([CountryStatesRoot].self, fileName: "Capitals")?.first {
            capRoot.value.forEach { country, entries in
                statesByCountry[country] = entries.map { $0.estado }
            }
        }

        // Points of interest
        if let poiRoot = load(PointsOfInterestRoot.self, fileName: "PointsOfInterest") {
            var map: [String: [String: [String]]] = [:]
            for wrapper in poiRoot.Paises {
                for (country, states) in wrapper.map {
                    var stateMap: [String: [String]] = [:]
                    for s in states {
                        stateMap[s.estado] = s.lugares
                    }
                    map[country] = stateMap
                }
            }
            poiByCountryState = map
        }

        // Currency rates
        if let rateItems = load(CurrencyRatesRoot.self, fileName: "CurrencyConversion")?.items {
            var all: [String: [String: Double]] = [:]
            for item in rateItems {
                for (base, targets) in item.map {
                    all[base] = targets
                }
            }
            rates = all
        }
    }

    private func load<T: Decodable>(_ type: T.Type, fileName: String) -> T? {
        guard let url = Bundle.main.url(forResource: fileName, withExtension: "json") else { return nil }
        do {
            let data = try Data(contentsOf: url)
            let decoder = JSONDecoder()
            return try decoder.decode(T.self, from: data)
        } catch {
            print("Failed to load \(fileName): \(error)")
            return nil
        }
    }
}
