//
//  MoviesCatalogInteractor.swift
//  MoviesApp
//
//  Created by Cristian guillermo Romero garcia on 09/12/24.
//

import Foundation
import UIKit

class MoviesCatalogInteractor: MoviesCatalogInteractorInputProtocol {
    //MARK: VIPER properties
    var presenter: (any MoviesCatalogInteractorOutputProtocol)?
    
    func getPopularMoviesInfo() async throws -> MovieResponseEntity  {
        let endpoint = "/movie/popular"
        guard let url = APIConstants.createURL(for: endpoint) else {
            throw URLError(.badURL)
        }
        
        let(data,_) = try await URLSession.shared.data(from: url)
        return try JSONDecoder().decode(MovieResponseEntity.self, from: data)
    }
}
