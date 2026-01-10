//
//  urlRequestHelper.swift
//  AppModulo
//
//  Created by Yibriam on 09/01/26.
//

import Foundation

struct URLRequestHelper {
    
    private static func createURLRequest(for endpoint: Endpoint) throws -> URLRequest {
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "jsonplacceholder.typicode.com"
        urlComponents.path = endpoint.path
        urlComponents.queryItems = endpoint.queryItems
        guard let url = urlComponents.url else { throw
            NetworkError.urlGeneration(endpoint.path) }
        return URLRequest(url: url)
    }
    
    static func basicNetworkCall<T: Decodable>(endpoint: Endpoint, handler: @escaping (Result<T?, Error>) -> Void) {
        do {
            let request = try createURLRequest(for: endpoint)
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                guard error == nil else {
                    handler(.failure(error!))
                    return
                }
                guard let httpResponse = response as? HTTPURLResponse else {
                    handler(.failure(NetworkError.unexpectedResponse))
                    return
                }
                guard httpResponse.statusCode == 200 else {
                    handler(.failure(NetworkError.badResponse(httpResponse.statusCode)))
                    return
                }
                do {
                    if let data {
                        let dto = try T(data: data)
                        handler(.success(dto))
                    } else {
                        handler(.success(nil))
                    }
                } catch {
                    handler(.failure(error))
                }
            }
            task.resume()
        } catch {
            handler(.failure(error))
        }
    }
    
    static func basicNetworkCall<T: Decodable>(endpoint: Endpoint) async throws -> T? {
        let request = try createURLRequest(for: endpoint)
        let (data, response) = try await URLSession.shared.data(for: request)
        guard let httpResponse = response as? HTTPURLResponse else {
            throw NetworkError.unexpectedResponse
        }
        guard httpResponse.statusCode == 200 else {
            throw NetworkError.badResponse(httpResponse.statusCode)
        }
        return try T(data: data)
    }
}

extension Decodable {
    init(data: Data) throws {
        self = try JSONDecoder().decode(Self.self, from: data)
    }
}

enum NetworkError: Error, LocalizedError {
    case urlGeneration(String)
    case unexpectedResponse
    case badResponse(Int)
    
    var errorDescription: String? {
        switch self {
        case .urlGeneration(let string): "Error generating URL for endpoint \(string)"
        case .unexpectedResponse: "Not an http response"
        case .badResponse(let int): "HTTP status code \(int)"
        }
    }
}
