//
//  endpoints.swift
//  AppModulo
//
//  Created by Yibriam on 09/01/26.
//

import Foundation

enum Endpoint {
    case users([URLQueryItem])
    case photos([URLQueryItem])
    
    var path: String {
        switch self {
        case .users: "/users"
        case .photos: "/photos"
            
        }
    }
    
    var queryItems: [URLQueryItem] {
        switch self {
        case .users(let array), .photos(let array): return array
        }
    }
}
