//
//  PokemonListViewModel.swift
//  diplomado-10-pokedex-kits
//
//  Created by Alejandro Mendoza on 17/01/26.
//

import UIKit

protocol PokemonListViewModelDelegate: AnyObject  {
    func shoulUpdateTableViewModel()
}
class PokemonListViewModel {
    private let pokemonDataFileName = "pokemon_list"
    private let pokemonDataFileExtension = "json"
    
    private let favoritePokemonDataFileName = "favorite_pokemon_list"
    private let favoritePokemonDataFileExtension = "json"
    
    private var pokemonList: [Pokemon] = []
    
    public var pokemonCellIdentifier = "pokemon-cell"
    public let title = "Pokedex"
    public var pokemonCount: Int { pokemonList.count }
    
    private var favoritePokemonList: Set<Pokemon> = []
    
    weak var delegate: PokemonListViewModelDelegate!
    
    init() {
        pokemonList = loadPokemonData()
        favoritePokemonList = Set(loadFavoritePokemon())
    }
    
    // MARK: - public methods
    func pokemon(at indexPath: IndexPath) -> Pokemon {
        pokemonList[indexPath.row]
    }
    
    func addFavoritePokemon(at indexPath: IndexPath) {
        let pokemon = pokemon(at: indexPath)
        favoritePokemonList.insert(pokemon)
    }
    
    func isPokemonFavorite(at indexPath: IndexPath) {
        
    }
    
    
    // MARK: - private methods
    func loadPokemonData() -> [Pokemon] {
        guard let fileURL = Bundle.main.url(forResource: pokemonDataFileName,
                                            withExtension: pokemonDataFileExtension),
              let pokemonData = try? Data(contentsOf: fileURL),
              let pokemonList = try? JSONDecoder().decode([Pokemon].self, from: pokemonData)
        else {
            assertionFailure("Cannot find file \(pokemonDataFileName).\(pokemonDataFileExtension)")
            return []
        }
        
        
        return pokemonList
    }
    
    func saveFavoritePokemon() {
        guard let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
        else {
            assertionFailure("Couldn't")
            return
        }
        
        let fileName = "\(favoritePokemonDataFileName).\(favoritePokemonDataFileExtension)"
        let fileURL = documentsDirectory.appending(component: fileName)
        
        let favoritePokemon = Array(favoritePokemonList).sorted{ $0.id > $1.id }
        
        do {
            let favoritePokemonData = try JSONEncoder().encode(favoritePokemon)
            
            let jsonFavoritePokemon = String(data: favoritePokemonData, encoding: .utf8)
            
            try jsonFavoritePokemon?.write(to: fileURL, atomically: true, encoding: .utf8)
        } catch {
            assertionFailure("Couldn't \(error.localizedDescription)")
        }
    }
    
    
    func loadFavoritePokemon() -> [Pokemon] {
        guard let documentURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
        else {
            assertionFailure("Couldn't")
            return []
        }
        
        let favoritePokemonURL = documentURL.appending(component: "")
        
        do {
            let favoritePokemonData = try Data(Data(contentsOf: favoritePokemonURL))
            let favoritePokemonList = try (JSONDecoder().decode([Pokemon].self,
                                                               from: favoritePokemonData))
            return favoritePokemonList
        } catch {
            assertionFailure("Couldn't")
            return []
        }
        
    }
}
