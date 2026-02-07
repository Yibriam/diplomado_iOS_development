//
//  FavoritePokemonTableViewController.swift
//  diplomado-10-pokedex-kits
//
//  Created by Alejandro Mendoza on 24/01/26.
//

import UIKit

class FavoritePokemonTableViewController: UITableViewController {
    
    let viewModel = FavoritePokemonTableViewModel()
    
    private var isAuthenticated = false

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UITableViewCell.self,
                           forCellReuseIdentifier: viewModel.pokemonCellIdentifier)
        navigationController?.navigationBar.prefersLargeTitles = true
        title = viewModel.title
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if !isAuthenticated {
            let authVC = UserAuthenticationViewController()
            navigationController?.present(authVC, animated: true) { [weak self] in
                self?.isAuthenticated = true
            }
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.numberOfSections
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: viewModel.pokemonCellIdentifier,
                                                 for: indexPath)
        let pokemon = viewModel.pokemon(at: indexPath)
        
        var cellConfiguration = cell.defaultContentConfiguration()
        cellConfiguration.text = pokemon.name
        
        cell.contentConfiguration = cellConfiguration
        cell.accessoryType = .disclosureIndicator
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let pokemon = viewModel.pokemon(at: indexPath)
        
        navigationController?.pushViewController(FavoritePokemonDetailViewController(pokemon: pokemon), animated: true)
    }

}
