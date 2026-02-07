//
//  PokemonListTableViewController.swift
//  diplomado-10-pokedex-kits
//
//  Created by Alejandro Mendoza on 17/01/26.
//

import UIKit

class PokemonListTableViewController: UITableViewController {
    let model = PokemonListViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        model.delegate = self
        self.title = model.title
        self.navigationController?.navigationBar.prefersLargeTitles = true
        
        tableView.register(UITableViewCell.self,
                           forCellReuseIdentifier: model.pokemonCellIdentifier)

    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int { 1 }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.pokemonCount
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: model.pokemonCellIdentifier,
                                                 for: indexPath)

        var cellConfiguration = cell.defaultContentConfiguration()
        let pokemon = model.pokemon(at: indexPath)
        
        let pokemonName: String
        if model.isPokemonFavorite(at: indexPath) {
            pokemonName = pokemon.name + "♥️"
        } else {
            pokemonName = pokemon.name
        }
        
        cellConfiguration.text = pokemonName
        cellConfiguration.secondaryText = pokemon.number

        cell.contentConfiguration = cellConfiguration
        
        return cell
    }
}

// MARK: - TableView Delegate
extension PokemonListTableViewController {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let selectedPokemon = model.pokemon(at: indexPath)
        let detailViewController = PokemonDetailViewController(pokemon: selectedPokemon)
        
        navigationController?.pushViewController(detailViewController,
                                                 animated: true)
    }
    
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let favoriteAction = UIContextualAction(style: .normal,
                                                title: "add to favorite",
                                                handler: { [weak self] _, _, completion in
            guard let self else { return }
            
            self.model.addFavoritePokemon(at: indexPath)
            
            completion(true)
        })
        
        favoriteAction.backgroundColor = .red
        favoriteAction.image = UIImage(systemName: "heart")
        
        return UISwipeActionsConfiguration(actions: [favoriteAction])
    }
}

// MARK: PokemonLisViewModelDelegate
extension PokemonListTableViewController: PokemonListViewModelDelegate {
    func shouldReloadTableData() {
        self.tableView.reloadData()
    }
}
