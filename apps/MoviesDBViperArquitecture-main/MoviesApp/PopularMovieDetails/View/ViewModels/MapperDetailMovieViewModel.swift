//
//  MapperDetailMovieViewModel.swift
//  MoviesApp
//
//  Created by Cristian guillermo Romero garcia on 13/12/24.
//

import Foundation

struct MapperDetailMovieViewModel {
    func detailsMap(entity: PopularMovieDetailsEntity) -> PopularMoviesDetailsViewModel {
        PopularMoviesDetailsViewModel(
            title: entity.title,
            overview: entity.overview,
            imageURL: URL(string: "https://image.tmdb.org/t/p/w500" + entity.backdropPath),
            vote: entity.voteAverage,
            status: entity.status,
            date: entity.releaseDate,
            runtime: entity.runtime,
            tagline: entity.tagline,
            budget: entity.budget,
            revenue: entity.revenue)
    }
}
