//
//  PopularMovieDescriptionInteractor.swift
//  MoviesApp
//
//  Created by Cristian guillermo Romero garcia on 12/12/24.
//

import Foundation

class PopularMoviesDetailsInteractor: PopularMoviesDetailsInteractorInputProtocol{
    var presenter: (any PopularMoviesDetailsInteractorOutoutProtocol)?
    
    func getPopularMoviesDetails(withMovieId movieId: Int) async -> PopularMovieDetailsEntity {
        let endpoint = "/movie/\(movieId)"
        let url = APIConstants.createURL(for: endpoint)
        let (data, _) = try! await URLSession.shared.data(from: url!)
        let jsonDecoder = JSONDecoder()
        jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
        return try! jsonDecoder.decode(PopularMovieDetailsEntity.self, from: data)
    }
}
