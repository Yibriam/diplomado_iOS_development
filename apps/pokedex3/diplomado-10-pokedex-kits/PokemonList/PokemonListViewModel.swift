//
//  PokemonListViewModel.swift
//  diplomado-10-pokedex-kits
//
//  Created by Alejandro Mendoza on 17/01/26.
//

import UIKit

protocol PokemonListViewModelDelegate: AnyObject {
    func shouldReloadTableData()
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
    
    weak var delegate: PokemonListViewModelDelegate?
    
    init() {
        pokemonList = loadPokemonData()
        favoritePokemonList = Set(loadFavoritePokemon())
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(saveFavoritePokemon),
                                               name: UIApplication.willResignActiveNotification,
                                               object: nil)
    }
    
    // MARK: - public methods
    func pokemon(at indexPath: IndexPath) -> Pokemon {
        pokemonList[indexPath.row]
    }
    
    func addFavoritePokemon(at indexPath: IndexPath) {
        let pokemon = pokemon(at: indexPath)
        favoritePokemonList.insert(pokemon)
        delegate?.shouldReloadTableData()
        saveFavoritePokemon()
    }
    
    func isPokemonFavorite(at indexPath: IndexPath) -> Bool {
        let pokemon = pokemon(at: indexPath)
        
        return favoritePokemonList.contains(pokemon)
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
    
    @objc
    func saveFavoritePokemon() {
        guard let documentsDirectory = FileManager.default.urls(for: .documentDirectory,
                                                                in: .userDomainMask).first
        else {
            assertionFailure("Couldn't find documents directory")
            return
        }
        
        let fileName = "\(favoritePokemonDataFileName).\(favoritePokemonDataFileExtension)"
        let fileURL = documentsDirectory.appending(component: fileName)
        
        let favoritePokemon = Array(favoritePokemonList).sorted { $0.id > $1.id }
        
        do {
            let favoritedPokemonData = try JSONEncoder().encode(favoritePokemon)
            
            let jsonFavoritePokemon = String(data: favoritedPokemonData, encoding: .utf8)
            
            try jsonFavoritePokemon?.write(to: fileURL, atomically: true, encoding: .utf8)
        } catch {
            assertionFailure("Couldn't encode favorite pokemon \(error.localizedDescription)")
        }
    }
    
    func loadFavoritePokemon() -> [Pokemon] {
        guard let documentsURL = FileManager.default.urls(for: .documentDirectory,
                                                          in: .userDomainMask).first
        else {
            assertionFailure("Couldn't find documents directory")
            return []
        }
        
        let favoritePokemonURL = documentsURL.appending(component: "\(favoritePokemonDataFileName).\(favoritePokemonDataFileExtension)")
        
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
