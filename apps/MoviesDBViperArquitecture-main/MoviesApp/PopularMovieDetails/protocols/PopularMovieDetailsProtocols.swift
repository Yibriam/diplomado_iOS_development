//
//  MovieDetailsProtocols.swift
//  MoviesApp
//
//  Created by Cristian guillermo Romero garcia on 12/12/24.
//

import Foundation
import UIKit

protocol PopularMoviesDetailsViewProtocol: AnyObject {
    //MARK: VIPER Properties
    var presenter: PopularMoviesDetailsPresenterProtocol? { get set}
    
    //MARK: presenter -> view
    func setUpUI()
    func animateLoader(isAnimating: Bool)
    func upDateUI(withViewModel viewModel: PopularMoviesDetailsViewModel)
    
}

protocol PopularMoviesDetailsPresenterProtocol: AnyObject{
    //MARK: VIPER Properties
    var view: PopularMoviesDetailsViewProtocol? { get set}
    var interactor: PopularMoviesDetailsInteractorInputProtocol? { get set}
    var router: PopularMoviesDetailsRouterProtocol? {get set}
    //MARK: view -> presenter
    func viewDidLoad()
}

protocol PopularMoviesDetailsInteractorInputProtocol: AnyObject{
    //MARK: VIPER properties
    var presenter: PopularMoviesDetailsInteractorOutoutProtocol? { get set}
    //MARK: presenter -> interactor
    func getPopularMoviesDetails(withMovieId movieId: Int) async -> PopularMovieDetailsEntity
}

protocol PopularMoviesDetailsRouterProtocol: AnyObject{
    //MARK: static properties
    //MARK: presenter -> wireFrame
    func showDetail(fromViewController: UIViewController, withMovieId movieId: Int)
}

protocol PopularMoviesDetailsInteractorOutoutProtocol: AnyObject{
    //MARK: interactor -> presenter
}
