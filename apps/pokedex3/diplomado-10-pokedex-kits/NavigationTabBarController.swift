//
//  NavigationTabBarController.swift
//  diplomado-10-pokedex-kits
//
//  Created by Alejandro Mendoza on 24/01/26.
//

import UIKit
class NavigationTabBarController: UITabBarController {
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("Programmatic viewcontroller")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViewControllers()
    }
    
    private func setupViewControllers() {
        let pokemonListViewController = PokemonListTableViewController(style: .insetGrouped)
        pokemonListViewController.tabBarItem.title = "Pokedex"
        pokemonListViewController.tabBarItem.image = UIImage(systemName: "lizard")
        
        let pokemonListNavigationController = UINavigationController(rootViewController: pokemonListViewController)
        
        let favoritePokemonListViewController = FavoritePokemonTableViewController(style: .insetGrouped)
        favoritePokemonListViewController.tabBarItem.title = "Favorites"
        favoritePokemonListViewController.tabBarItem.image = UIImage(systemName: "cat")
        
        let favoriteListNavigationController = UINavigationController(rootViewController: favoritePokemonListViewController)
        
        viewControllers = [
            pokemonListNavigationController,
            favoriteListNavigationController
        ]
    }
}
