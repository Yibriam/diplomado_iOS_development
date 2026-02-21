//
//  MoviesCatalogViewController.swift
//  MoviesApp
//
//  Created by Cristian guillermo Romero garcia on 09/12/24.
//

import UIKit

class MoviesCatalogViewController: UIViewController, MoviesCatalogviewProtocol {
    //MARK: Viper properties
    var presenter: (any MoviesCatalogPresenterProtocol)?
    
    //MARK: UI Properties
    @IBOutlet weak var moviesCatalogTableView: UITableView!{
        didSet{
            moviesCatalogTableView.register(UINib(nibName: "MoviesCatalogTableViewCell", bundle: nil), forCellReuseIdentifier: "MoviesCell")
        }
    }
    @IBOutlet weak var loader: UIActivityIndicatorView!
    private var viewModels: [MovieCellViewModel] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
        moviesCatalogTableView.dataSource = self
        moviesCatalogTableView.delegate = self
        self.title = "Catalogo de peliculas"
        loader.hidesWhenStopped = true
        loader.style = .large
        loader.color = .gray
    }
    
    func showMovies(viewModels: [MovieCellViewModel]) {
        self.viewModels = viewModels
        DispatchQueue.main.async {
            self.moviesCatalogTableView.reloadData()
        }
    }
    
    func showError(error: any Error) {
        DispatchQueue.main.async {
         // Mostrar alert con error
            let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            self.present(alert, animated: true)
        }
    }
    func showLoading() {
        DispatchQueue.main.async {
            self.loader.isHidden = false
            self.loader.startAnimating()
        }
    }
    
    func hideLoading() {
        DispatchQueue.main.async {
            self.loader.isHidden = true
            self.loader.stopAnimating()
        }
    }

}

extension MoviesCatalogViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MoviesCell", for: indexPath) as? MoviesCatalogTableViewCell else {
            return UITableViewCell()
        }
        let viewModel = viewModels[indexPath.row]
        cell.configure(with:viewModel)
        return cell
    }
}

extension MoviesCatalogViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter?.onTapCell(atIndex: indexPath.row)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        "Popular movies"
    }
}
