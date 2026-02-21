//
//  Models.swift
//  clima
//
//  Created by Yibriam on 21/02/26.
//

import Foundation

// MARK: - Temperature unit helper
enum TemperatureUnit {
    case celsius, fahrenheit
}

// MARK: - Location model
struct Location: Identifiable, Codable {
    let id: Int
    let nombre: String
}

// MARK: - WeatherResponse
struct WeatherResponse: Codable {
    struct LocationData: Codable {
        let name: String
        let region: String
        let country: String
        let lat: Double
        let lon: Double
        let localtime: String
    }

    struct CurrentData: Codable {
        let temp_c: Double
        let temp_f: Double
        let is_day: Int
        let uv: Double
        let last_updated: String
        let condition: Condition
    }

    struct Condition: Codable {
        let text: String
        let icon: String
    }

    let location: LocationData
    let current: CurrentData
}

// MARK: - Temperature helpers on the model
extension WeatherResponse {
    
    func temperature(for unit: TemperatureUnit) -> Double {
        switch unit {
        case .celsius: return current.temp_c
        case .fahrenheit: return current.temp_f
        }
    }

    func temperatureString(for unit: TemperatureUnit) -> String {
        let value = temperature(for: unit)
        switch unit {
        case .celsius: return String(format: "%.1f ºC", value)
        case .fahrenheit: return String(format: "%.1f ºF", value)
        }
    }

    var localtimeDate: Date? {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm"
        return formatter.date(from: location.localtime)
    }

    var lastUpdatedDate: Date? {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm"
        return formatter.date(from: current.last_updated)
    }
}

// MARK: - Mock for previews
extension WeatherResponse {
    static var mock: WeatherResponse {
        WeatherResponse(
            location: .init(
                name: "London",
                region: "City of London, Greater London",
                country: "United Kingdom",
                lat: 51.5074,
                lon: -0.1278,
                localtime: "2026-02-21 11:24"
            ),
            current: .init(
                temp_c: 17.0,
                temp_f: 62.6,
                is_day: 1,
                uv: 1.0,
                last_updated: "2026-02-21 11:00",
                condition: .init(
                    text: "Partly cloudy",
                    icon: "//cdn.weatherapi.com/weather/64x64/day/116.png"
                )
            )
        )
    }
}
