//
//  DataLayer.swift
//  clima
//
//  Created by Yibriam on 21/02/26.
//

import Foundation

// MARK: - WeatherService with safe API key lookup and URL encoding
enum WeatherServiceError: Error, LocalizedError {
    case missingApiKey
    case invalidUrl
    case network(Error)
    case decoding(Error)

    var errorDescription: String? {
        switch self {
        case .missingApiKey: return "API key not found in Info.plist."
        case .invalidUrl: return "Failed to build request URL."
        case .network(let err): return "Network error: \(err.localizedDescription)"
        case .decoding(let err): return "Decoding error: \(err.localizedDescription)"
        }
    }
}

class WeatherService {
    static let shared = WeatherService()
    private init() {}

    private var apiKey: String? {
        Bundle.main.object(forInfoDictionaryKey: "WeatherAPIKey") as? String
        ?? Bundle.main.object(forInfoDictionaryKey: "My_API_Key") as? String
    }

    func fetchWeather(for location: String) async throws -> WeatherResponse {
        guard let key = apiKey, !key.isEmpty else {
            throw WeatherServiceError.missingApiKey
        }

        guard let encoded = location.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {
            throw WeatherServiceError.invalidUrl
        }

        let urlString = "https://api.weatherapi.com/v1/current.json?key=\(key)&q=\(encoded)&aqi=no"
        guard let url = URL(string: urlString) else {
            throw WeatherServiceError.invalidUrl
        }

        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            do {
                return try JSONDecoder().decode(WeatherResponse.self, from: data)
            } catch {
                throw WeatherServiceError.decoding(error)
            }
        } catch {
            throw WeatherServiceError.network(error)
        }
    }
}
