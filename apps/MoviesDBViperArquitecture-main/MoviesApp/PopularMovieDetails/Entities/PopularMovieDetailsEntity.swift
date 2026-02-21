//
//  PopularMovieDetailsEnities.swift
//  MoviesApp
//
//  Created by Cristian guillermo Romero garcia on 12/12/24.
//

import Foundation

struct PopularMovieDetailsEntity: Codable {
    let title: String
    let overview: String
    let backdropPath: String
    let status: String
    let releaseDate: String
    let voteAverage: Double
    let voteCount: Int
    let runtime: Int
    let tagline: String
    let budget: Int
    let revenue: Int
}

