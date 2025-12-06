//
//  UserLocalRepository.swift
//  AppModulo
//
//  Created by Yibriam on 29/11/25.
//

import Foundation

protocol UserRepositoryProtocol {
    func getUsers(by email: String) throws -> [UserDTO]?
}

struct UserLocalRepository: UserRepositoryProtocol {
    func getUsers(by email: String) throws -> [UserDTO]? {
        guard let url = Bundle.main.url(forResource: "Users", withExtension: ".json") else { return nil }
        let data = try Data(contentsOf: url)
        return try JSONDecoder().decode([UserDTO].self, from: data)
    }

}
