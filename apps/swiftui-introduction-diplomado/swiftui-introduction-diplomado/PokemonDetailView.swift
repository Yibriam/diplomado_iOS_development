//
//  PokemonDetailView.swift
//  swiftui-introduction-diplomado
//
//  Created by Alejandro Mendoza on 31/01/26.
//
import SwiftUI

struct PokemonDetailView: View {
    let pokemon: Pokemon
    
    var body: some View {
        VStack {
            CircleImage()
            
            VStack(alignment: .leading) {
                Text(pokemon.name)
                    .font(.title)
                    .fontWeight(.bold)
                    
                HStack {
                    Text(pokemon.num)
                    Spacer()
                    Text("\(pokemon.id)")
                }
                
                Spacer()
            }
        }
        .environment(\.pokemonSoundAction, {
            print("hey, I'm pikachu!")
        })
        .padding()
    }
}

#Preview {
    PokemonDetailView(pokemon: PokemonLoaderService.shared.pokemon[24])
        .padding()
}
