//
//  ColoursLocalRepository.swift
//  AppModulo
//
//  Created by Yibriam on 29/11/25.
//

import Foundation

protocol ColoursRepositoryProtocol {
    func getColoursList(for user: String) async throws -> [ColourDTO]?
    func getColoursList(for user: String, handler: @escaping (Result<[ColourDTO]?, Error>) -> Void)
}


struct ColoursLocalRepository: ColoursRepositoryProtocol {
    func getColoursList(for user: String) async throws -> [ColourDTO]? {
        let endpoint = Endpoint.photos([.init(name: "email", value: "Shanna@melissa.tv"),
                                        .init(name: "_limit", value: "10"),
                                        .init(name: "_start", value: "0"),
                                        ])
        return try await URLRequestHelper.basicNetworkCall(endpoint: endpoint)
    }
    
    
    func getColoursList(for email: String, handler: @escaping (Result<[ColourDTO]?, any Error>) -> Void) {
        guard let url = Bundle.main.url(forResource: "Colours", withExtension: ".json") else { // Changed ".json" to "json"
            handler(.failure(NSError(domain: "LocalRepository", code: 404, userInfo: [NSLocalizedDescriptionKey: "Colours.json not found."])))
            return
        }
        
        do {
            let data = try Data(contentsOf: url)
            let colours = try JSONDecoder().decode([ColourDTO].self, from: data)
            handler(.success(colours))
        } catch {
            handler(.failure(error))
        }
    }
    
}

struct ColoursRemoteRepository: ColoursRepositoryProtocol {
    
    func getColoursList(for user: String) async throws -> [ColourDTO]? {
        let endpoint = Endpoint.photos([.init(name: "email", value: "Shanna@melissa.tv"),
                                        .init(name: "_limit", value: "10"),
                                        .init(name: "_start", value: "0"),
        ])
        return try await URLRequestHelper.basicNetworkCall(endpoint: endpoint)
    }
    
    
    func getColoursList(for user: String, handler: @escaping (Result<[ColourDTO]?, any Error>) -> Void) {
        let endpoint = Endpoint.photos([.init(name: "email", value: "Shanna@melissa.tv"),
                                        .init(name: "_limit", value: "10"),
                                        .init(name: "_start", value: "0"),
        ])
        URLRequestHelper.basicNetworkCall(endpoint: endpoint, handler: handler)
    }
    
}
