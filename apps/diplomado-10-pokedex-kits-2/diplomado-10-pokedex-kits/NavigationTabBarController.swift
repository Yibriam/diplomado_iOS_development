//
//  NavigationTabBarController.swift
//  diplomado-10-pokedex-kits
//
//  Created by Yibriam on 24/01/26.
//

import UIKit

class NavigationTabBarController: UITabBarController {
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init(coder: NSCoder) {
        fatalError("Programmatic")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViewController()
    }
    
    private func setupViewController() {
        let pokemonListViewController = PokemonListTableViewController(style: .insetGrouped)
        pokemonListViewController.tabBarItem.title = "Pokedex"
        pokemonListViewController.tabBarItem.image = UIImage(systemName: "lizard")
        
        let pokemonListNavigationController = UINavigationController(rootViewController: table)
    }
    
}
