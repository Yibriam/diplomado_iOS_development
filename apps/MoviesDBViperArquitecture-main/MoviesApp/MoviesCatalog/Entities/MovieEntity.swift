//
//  PopularMovieEnity.swift
//  MoviesApp
//
//  Created by Cristian guillermo Romero garcia on 10/12/24.
//

import Foundation

struct MovieEntity: Codable{
    let id: Int
    let title: String
    let overview: String
    let vote: Double
    let imageURL: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case overview
        case vote = "vote_average"
        case imageURL = "poster_path"
    }
}


