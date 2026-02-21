//
//  MoviesCatalogPresenter.swift
//  MoviesApp
//
//  Created by Cristian guillermo Romero garcia on 09/12/24.
//

import Foundation

class MoviesCatalogPresenter: MoviesCatalogPresenterProtocol,MoviesCatalogInteractorOutputProtocol{
    
    //MARK: VIPER properties
    var view: (any MoviesCatalogviewProtocol)?
    var interactor: (any MoviesCatalogInteractorInputProtocol)?
    var router: (any MoviesCatalogRouterProtocol)?
    
    //MARK: Presenter properties
    var viewModels: [MovieCellViewModel] = []
    private let mapper = Mapper()
    private var models: [MovieEntity] = []
    
    func viewDidLoad(){
        fetchMovies()
    }
    
    private func fetchMovies(){
        view?.showLoading()
        Task{
            do{
                let movies = try await interactor?.getPopularMoviesInfo()
                if let movies = movies {
                    didFetchMovies(movies: movies)
                }
            }catch{
                didFailFetchMovies(error: error)
            }
        }
    }
    func didFetchMovies(movies: MovieResponseEntity) {
        models = movies.results
        viewModels = movies.results.map(mapper.map(entity:))
        view?.hideLoading()
        view?.showMovies(viewModels: viewModels)
    }
    
    func didFailFetchMovies(error: any Error) {
        view?.hideLoading()
        view?.showError(error: error)
    }
    
    func onTapCell(atIndex: Int) {
        let movieID = models[atIndex].id
        router?.showDetailMovie(withMovieID: movieID)
    }
    
}
