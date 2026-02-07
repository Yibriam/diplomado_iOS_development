//
//  PokemonRow.swift
//  swiftui-introduction-diplomado
//
//  Created by Alejandro Mendoza on 31/01/26.
//

import SwiftUI

struct PokemonRow: View {
    let pokemon: Pokemon
    
    var imageURL: URL? {
        return URL(string: pokemon.img)
    }
    
    var body: some View {
        HStack {
            AsyncImage(url: imageURL,
                       scale: 1) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 50, height: 50)
            } placeholder: {
                ProgressView()
            }
            
            Text(pokemon.name)
                .font(.title)
                .fontWeight(.bold)
        }
    }
}

#Preview {
    PokemonRow(pokemon: PokemonLoaderService.shared.pokemon[1])
}
