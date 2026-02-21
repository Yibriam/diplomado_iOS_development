//
//  PopularMoviesDescriptionPresenter.swift
//  MoviesApp
//
//  Created by Cristian guillermo Romero garcia on 12/12/24.
//

import Foundation
import UIKit

class PopularMoviesDetailsPresenter: PopularMoviesDetailsPresenterProtocol,PopularMoviesDetailsInteractorOutoutProtocol{
    var view: (any PopularMoviesDetailsViewProtocol)?
    let movieID: Int
    var interactor: (any PopularMoviesDetailsInteractorInputProtocol)?
    var router: (any PopularMoviesDetailsRouterProtocol)?
    private let mapper = MapperDetailMovieViewModel()
    
    init(view: (any PopularMoviesDetailsViewProtocol)? = nil, movieID: Int, interactor: (any PopularMoviesDetailsInteractorInputProtocol)? = nil, router: (any PopularMoviesDetailsRouterProtocol)? = nil) {
        self.view = view
        self.movieID = movieID
        self.interactor = interactor
        self.router = router
    }
    
    func viewDidLoad(){
        view?.setUpUI()
        view?.animateLoader(isAnimating: true)
        fetchDetailMovies()
    }
    
    func fetchDetailMovies(){
        Task{
            let model = await interactor?.getPopularMoviesDetails(withMovieId: movieID)
            let viewModel = mapper.detailsMap(entity: model!)
            
            DispatchQueue.main.async {
                self.view?.animateLoader(isAnimating: false)
                self.view?.upDateUI(withViewModel: viewModel)
            }
        }
    }
    
}
