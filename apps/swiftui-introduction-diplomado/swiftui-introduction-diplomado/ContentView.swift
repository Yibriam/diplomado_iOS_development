//
//  ContentView.swift
//  swiftui-introduction-diplomado
//
//  Created by Alejandro Mendoza on 31/01/26.
//

import SwiftUI
import MapKit

struct ContentView: View {
    let pokemon = PokemonLoaderService.shared.pokemon
    
    var body: some View {
        NavigationSplitView {
            List {
                ForEach(pokemon) { pokemon in
                    NavigationLink {
                        PokemonDetailView(pokemon: pokemon)
                    } label: {
                        PokemonRow(pokemon: pokemon)
                    }
                }
            }
        } detail: {
            Text("select a pokemon")
        }

    }
}

#Preview {
    ContentView()
}
