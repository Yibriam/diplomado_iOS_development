//
//  APIClient.swift
//  DevSearchDiplo
//
//  Created by alumno on 20/02/26.
//

import Foundation

final class NetworkClient: Sendable {
    
    static let shared = NetworkClient()
    
    private let jsonDecoder: JSONDecoder
    private let jsonEncoder: JSONEncoder
    
    public typealias Header = (value: String, HTTPHeaderField: String)
    
    private init() {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .useDefaultKeys
        let encoder = JSONEncoder()
        encoder.keyEncodingStrategy = .useDefaultKeys
        self.jsonDecoder = decoder
        self.jsonEncoder = encoder
    }
    
    func makeRequest<T: Decodable>(
        endpoint: String,
        method: RequestMethod,
        body: Encodable? = nil,
        additionalHeaders: [Header]? = nil
    ) async throws -> T {
        guard let url = URL(string: APIConfig.host + endpoint) else {
            throw APIError.invalidURL
        }
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        additionalHeaders?.forEach { (value: String, HTTPHeaderField: String) in
            request.setValue(value, forHTTPHeaderField: HTTPHeaderField)
        }

        if method == .post, let body = body {
            request.httpBody = try jsonEncoder.encode(body)
            print(request.httpBody ?? "")
        }
        return try await sendRequest(request: request)
    }
    
    func sendRequest<T: Decodable>(
        request: URLRequest
    ) async throws -> T {
        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            printLog(request, dataResponse: data)

            guard let http = response as? HTTPURLResponse else {
                throw APIError.noData
            }

            switch http.statusCode {
            case 200...299:
                guard !data.isEmpty else { throw APIError.noData }
                do {
                    return try jsonDecoder.decode(T.self, from: data)
                } catch {
                    throw APIError.decodingError(error)
                }
            case 400...499:
                throw APIError.serverError(statusCode: http.statusCode, data: data)
            case 500...599:
                throw APIError.serverError(statusCode: http.statusCode, data: data)
            default:
                throw APIError.serverError(statusCode: http.statusCode, data: data)
            }
        } catch let apiError as APIError {
            throw apiError
        } catch {
            throw APIError.unknow(error)
        }
    }
    
    func printLog(_ request: URLRequest, dataResponse: Data) {
        print("\n--- REQUEST ---")
        if let urlstr = request.url {
            print("URL: \(urlstr)")
            print("Method: \(request.httpMethod ?? "")")
        }
        if let headers = request.allHTTPHeaderFields {
            print("HEADERS")
            headers.forEach { (key: String, value: String) in
                print("--  \(key) : \(value)")
            }
        }
        if let httpBody = request.httpBody,
           let bodyString = String(data: httpBody, encoding: .utf8) {
            print("BODY: \n\(bodyString)")
        }
        if let responseStr = String(data: dataResponse, encoding: .utf8) {
            print("\n--- RESPONSE ---")
            print(responseStr)
        }
    }
}
