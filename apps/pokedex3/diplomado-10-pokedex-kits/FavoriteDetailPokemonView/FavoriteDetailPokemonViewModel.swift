//
//  FavoriteDetailPokemonViewModel.swift
//  diplomado-10-pokedex-kits
//
//  Created by Alejandro Mendoza on 24/01/26.
//

import UIKit
import PhotosUI

protocol FavoriteDetailPokemonViewModelDelegate: AnyObject {
    func didSelectImage(_ image: UIImage)
}

class FavoriteDetailPokemonViewModel: NSObject {
    private let pokemon: Pokemon
    weak var delegate: FavoriteDetailPokemonViewModelDelegate?

    var pokemonName: String { pokemon.name }

    init(pokemon: Pokemon) {
        self.pokemon = pokemon
    }

    func getPHPickerConfiguration() -> PHPickerConfiguration {
        var config = PHPickerConfiguration()
        config.filter = .images
        config.selectionLimit = 1
        return config
    }

    func handleImageSelection(_ image: UIImage) {
        delegate?.didSelectImage(image)
    }
}
