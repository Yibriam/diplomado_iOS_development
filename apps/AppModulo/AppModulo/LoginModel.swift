//
//  LoginModel.swift
//  AppModulo
//
//  Created by Yibriam on 29/11/25.
//

import Foundation

struct LoginModel {
    
    private let repository: UserRepositoryProtocol
    
    init(repository: UserRepositoryProtocol) {
        self.repository = repository
    }
    
    func findUser(by email: String, handler: @escaping(Error?) -> Void) {
        do {
            guard let _ = try repository.getUsers(by: email)?.first else {
                handler(LoginModelError.userNotFound)
                return
            }
            handler(nil)
        } catch {
            handler(error)
            
        }
    }
    
    private enum LoginModelError: Error, LocalizedError {
        case userNotFound
        
        var errorDescription: String? {
            switch self {
            case .userNotFound: "User not found, check your email and password."
            }
        }
    }
}
