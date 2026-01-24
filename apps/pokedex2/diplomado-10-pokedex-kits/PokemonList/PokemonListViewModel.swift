//
//  PokemonListViewModel.swift
//  diplomado-10-pokedex-kits
//
//  Created by Alejandro Mendoza on 17/01/26.
//

import Foundation

class PokemonListViewModel {
    private let pokemonDataFileName = "pokemon_list"
    private let pokemonDataFileExtension = "json"
    
    private var pokemonList: [Pokemon] = []
    private var filteredPokemon: [Pokemon] = []
    private var isSearching = false
    
    public var pokemonCellIdentifier = "pokemon-cell"
    public let title = "Pokedex"
    var pokemonCount: Int {
        return isSearching ? filteredPokemon.count : pokemonList.count
    }
    
    init() {
        pokemonList = loadPokemonData()
    }
    
    // MARK: - public methods
    func pokemon(at indexPath: IndexPath) -> Pokemon {
        return isSearching ? filteredPokemon[indexPath.row] : pokemonList[indexPath.row]
    }

    func filterPokemon(with query: String) {
        if query.isEmpty {
            isSearching = false
        } else {
            isSearching = true
            filteredPokemon = pokemonList.filter {
                $0.name.lowercased().contains(query.lowercased()) ||
                $0.number.contains(query)
            }
        }
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
}
