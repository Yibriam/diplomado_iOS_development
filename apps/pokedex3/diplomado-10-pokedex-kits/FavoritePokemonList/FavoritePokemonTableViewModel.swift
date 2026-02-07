//
//  FavoritePokemonTableViewModel.swift
//  diplomado-10-pokedex-kits
//
//  Created by Alejandro Mendoza on 24/01/26.
//
import UIKit

class FavoritePokemonTableViewModel {
    private let favoritePokemonDataFileName = "favorite_pokemon_list"
    private let favotitePokemonExtension = "json"
    
    private var favoritePokemonList = [Pokemon]()
    let title = "favorites"
    let pokemonCellIdentifier = "favorite_pokemon_cell"
    
    var numberOfSections: Int { 1 }
    var numberOfRows: Int { favoritePokemonList.count }
    
    init() {
        favoritePokemonList = loadFavoritePokemon()
    }
    
    func pokemon(at indexPath: IndexPath) -> Pokemon {
        favoritePokemonList[indexPath.row]
    }
    
    func loadFavoritePokemon() -> [Pokemon] {
        guard let documentsURL = FileManager.default.urls(for: .documentDirectory,
                                                          in: .userDomainMask).first
        else {
            assertionFailure("Couldn't find documents directory")
            return []
        }
        
        let favoritePokemonURL = documentsURL.appending(component: "\(favoritePokemonDataFileName).\(favotitePokemonExtension)")
        
        do {
            let favoritePokemonData = try Data(contentsOf: favoritePokemonURL)
            let favoritePokemonList = try JSONDecoder().decode([Pokemon].self,
                                                               from: favoritePokemonData)
            return favoritePokemonList
        } catch {
//            assertionFailure("Couldn't load favorite pokemon \(error.localizedDescription)")
            return []
        }
    }
    
}
