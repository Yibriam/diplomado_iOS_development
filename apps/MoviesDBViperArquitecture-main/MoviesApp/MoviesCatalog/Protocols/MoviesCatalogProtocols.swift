//
//  MoviesCatalogProtocols.swift
//  MoviesApp
//
//  Created by Cristian guillermo Romero garcia on 09/12/24.
//

import Foundation
import UIKit

protocol MoviesCatalogviewProtocol: AnyObject {
    //MARK: Viper properties
    var presenter: MoviesCatalogPresenterProtocol? { get set}
    
    //MARK: presenter -> view
    func showMovies(viewModels: [MovieCellViewModel])
    func showError(error: Error)
    func showLoading()
    func hideLoading()
}

protocol MoviesCatalogPresenterProtocol: AnyObject {
    //MARK: Viper properties
    var view: MoviesCatalogviewProtocol? { get set }
    var interactor: MoviesCatalogInteractorInputProtocol? { get set }
    var router : MoviesCatalogRouterProtocol? {get set}
    
    //MARK: view -> presenter
    func viewDidLoad()
    func onTapCell(atIndex: Int)
    
}

protocol MoviesCatalogInteractorInputProtocol: AnyObject {
    //MARK: Viper properties
    var presenter: MoviesCatalogInteractorOutputProtocol? { get set }
    
    //MARK: presenter -> interactor
    func getPopularMoviesInfo() async throws-> MovieResponseEntity
}

protocol MoviesCatalogRouterProtocol: AnyObject {
    //MARK: static properties
    static func getMovieCatalogModule() -> UIViewController
    
    //MARK: presenter -> wireFrame
    func showDetailMovie(withMovieID movieID: Int)
}

protocol MoviesCatalogInteractorOutputProtocol: AnyObject{
    //MARK: interactor -> presenter
    func didFetchMovies(movies: MovieResponseEntity)
    func didFailFetchMovies(error: Error)
}

