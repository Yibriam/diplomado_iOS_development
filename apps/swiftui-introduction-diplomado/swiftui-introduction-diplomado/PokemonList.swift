//
//  PokemonList.swift
//  swiftui-introduction-diplomado
//
//  Created by Alejandro Mendoza on 31/01/26.
//

import SwiftUI

struct PokemonList: View {
    let pokemon = PokemonLoaderService.shared.pokemon
    
    var body: some View {
        List {
            ForEach(pokemon) { pokemon in
                PokemonRow(pokemon: pokemon)
            }
        }
        .listStyle(.insetGrouped)
    }
}

#Preview {
    PokemonList()
}
