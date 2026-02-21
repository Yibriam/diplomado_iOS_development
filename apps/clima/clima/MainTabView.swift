//
//  MainTabView.swift
//  clima
//
//  Created by Yibriam on 21/02/26.
//

import SwiftUI

struct MainTabView: View {
    var body: some View {
        TabView {
            LocationsView()
                .tabItem {
                    Label("Ubicación", systemImage: "mappin")
                }
            
            FavoritesView()
                .tabItem {
                    Label("Favoritos", systemImage: "star")
                }
        }
    }
}


#Preview {
    MainTabView()
}
