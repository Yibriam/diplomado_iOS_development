//
//  Mapper.swift
//  MoviesApp
//
//  Created by Cristian guillermo Romero garcia on 11/12/24.
//

import Foundation

struct Mapper {
    func map(entity: MovieEntity) -> MovieCellViewModel {
        MovieCellViewModel(
            title: entity.title,
            overview: entity.overview,
            imageURL: URL(string: "https://image.tmdb.org/t/p/w500" + entity.imageURL),
            vote: entity.vote)
    }
}
