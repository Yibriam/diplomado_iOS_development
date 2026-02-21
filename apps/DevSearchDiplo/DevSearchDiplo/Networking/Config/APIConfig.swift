//
//  APIConfig.swift
//  DevSearchDiplo
//
//  Created by alumno on 20/02/26.
//

import Foundation

struct APIConfig: Sendable {
    static let host = "https://api.github.com"
    
    enum Users: String {
        case users = "/users"
    }
}
