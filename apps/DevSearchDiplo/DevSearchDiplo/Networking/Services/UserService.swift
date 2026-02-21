//
//  UserService.swift
//  DevSearchDiplo
//
//  Created by alumno on 20/02/26.
//

import Foundation

public final class UserService: Sendable {
    public init() {}
    
    public func getUser(user: String) async throws -> GetUserResponse? {
        return try await NetworkClient.shared.makeRequest(endpoint: "\(APIConfig.Users.users.rawValue)/\(user)", method: .get)
    }
}
