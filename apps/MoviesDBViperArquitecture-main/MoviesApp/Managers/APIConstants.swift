//
//  Constants.swift
//  MoviesApp
//
//  Created by Cristian guillermo Romero garcia on 10/12/24.
//

import Foundation

struct APIConstants{
    static let baseURL = "https://api.themoviedb.org/3"
    static let apiKey = "95013b7fc5a50ab2202eda61b68aca7a"
    
    static func createURL(for endpoint: String) -> URL?{
        return URL(string: "\(baseURL)\(endpoint)?api_key=\(apiKey)")
    }
}

