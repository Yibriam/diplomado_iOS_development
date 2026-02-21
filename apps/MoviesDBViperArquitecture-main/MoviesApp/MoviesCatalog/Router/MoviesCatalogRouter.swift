//
//  MoviesCatalogRouter.swift
//  MoviesApp
//
//  Created by Cristian guillermo Romero garcia on 09/12/24.
//

import Foundation
import UIKit

class MoviesCatalogRouter: MoviesCatalogRouterProtocol{
    weak var moviesCatalogView: MoviesCatalogViewController?
    //MARK: VIPER Methods
    static func getMovieCatalogModule() -> UIViewController {
        let movieCatalogStoryboard = UIStoryboard(name: "MoviesCatalogStoryboard", bundle: .main)
        let view = movieCatalogStoryboard.instantiateViewController(withIdentifier: "MoviesCatalogVC") as! MoviesCatalogViewController
        let presenter = MoviesCatalogPresenter()
        let interactor = MoviesCatalogInteractor()
        let router = MoviesCatalogRouter()
        
        /// connecting
        view.presenter = presenter
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        router.moviesCatalogView = view
        interactor.presenter = presenter
        return view
    }
    
    func showDetailMovie(withMovieID movieID: Int) {
        guard let fromViewController = moviesCatalogView else { return }
        let detailRouter = PopularMovieDetailsRouter()
        detailRouter.showDetail(fromViewController: fromViewController, withMovieId: movieID)
    }
    
}
