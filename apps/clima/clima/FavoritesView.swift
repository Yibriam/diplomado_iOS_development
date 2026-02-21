//
//  FavoritesView.swift
//  clima
//
//  Created by You on 2026-02-21.
//

import SwiftUI

struct FavoritesView: View {
    @EnvironmentObject var favoritesStore: FavoritesStore

    let columns = [GridItem(.flexible()), GridItem(.flexible())]

    var body: some View {
        NavigationView {
            ScrollView {
                LazyVGrid(columns: columns, spacing: 20) {
                    ForEach(favoritesStore.favorites) { fav in
                        NavigationLink(destination: DetailView(location: Location(id: 0, nombre: fav.name))
                                        .environmentObject(favoritesStore)) {
                            Image(fav.assetName)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 80, height: 50)
                                .cornerRadius(6)
                        }
                    }
                }
                .padding()
            }
            .navigationTitle("Favoritos")
        }
    }
}

struct FavoritesView_Previews: PreviewProvider {
    static var previews: some View {
        FavoritesView()
            .environmentObject(FavoritesStore())
    }
}
