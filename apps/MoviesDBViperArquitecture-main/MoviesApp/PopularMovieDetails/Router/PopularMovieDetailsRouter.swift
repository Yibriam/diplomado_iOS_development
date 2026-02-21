//
//  PopularMovieDetailsRouter.swift
//  MoviesApp
//
//  Created by Cristian guillermo Romero garcia on 12/12/24.
//

import Foundation
import UIKit

class PopularMovieDetailsRouter: PopularMoviesDetailsRouterProtocol {
    func showDetail(fromViewController: UIViewController, withMovieId movieId: Int) {
        let view = PopularMoviesDetailsViewController()
        let presenter = PopularMoviesDetailsPresenter(movieID: movieId)
        let interactor = PopularMoviesDetailsInteractor()
        let router = PopularMovieDetailsRouter()
        
        ///conecting
        view.presenter = presenter
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        interactor.presenter = presenter
        
        fromViewController.navigationController?.pushViewController(view, animated: true)
    }
    
    
}
