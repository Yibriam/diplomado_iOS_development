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
    
    public var pokemonCellIdentifier = "pokemon-cell"
    public let title = "Pokedex"
    public var pokemonCount: Int { pokemonList.count }
    
    init() {
        pokemonList = loadPokemonData()
    }
    
    // MARK: - public methods
    func pokemon(at indexPath: IndexPath) -> Pokemon {
        pokemonList[indexPath.row]
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
