//
//  UserLocalRepository.swift
//  AppModulo
//
//  Created by Yibriam on 29/11/25.
//

import Foundation

protocol UserRepositoryProtocol {
    func getUsers(by email: String) async throws -> [UserDTO]?
    
    func getUsers(by email: String, handler: @escaping (Result<[UserDTO]?, Error>) -> Void)
}

struct UserLocalRepository: UserRepositoryProtocol {
    
    func getUsers(by email: String, handler: @escaping (Result<[UserDTO]?, any Error>) -> Void) {
        let url = Bundle.main.url(forResource: "Users", withExtension: ".json")!
        do {
            let data = try Data(contentsOf: url)
            let users = try JSONDecoder().decode([UserDTO].self, from: data)
            handler(.success(users))
        } catch {
            handler(.failure(error))
        }
    }
    
    func getUsers(by email: String) async throws -> [UserDTO]? {
        guard let url = Bundle.main.url(forResource: "Users", withExtension: ".json") else { return nil }
        let data = try Data(contentsOf: url)
        return try JSONDecoder().decode([UserDTO].self, from: data)
    }

}

struct RemoteLogInRepository: UserRepositoryProtocol {
    func getUsers(by email: String) async throws -> [UserDTO]? {
        let endpoint = Endpoint.users([.init(name: "email", value: email)])
        return try await URLRequestHelper.basicNetworkCall(endpoint: endpoint)
    }
    
    func getUsers(by email: String, handler: @escaping (Result<[UserDTO]?, any Error>) -> Void) {
        let endpoint = Endpoint.users([.init(name: "email", value: email)])
        URLRequestHelper.basicNetworkCall(endpoint: endpoint, handler: handler)
    }
}
