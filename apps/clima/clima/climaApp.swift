//
//  climaApp.swift
//  clima
//
//  Created by Yibriam on 21/02/26.
//

import SwiftUI

@main
struct ClimaApp: App {
    @StateObject private var favoritesStore = FavoritesStore()

    var body: some Scene {
        WindowGroup {
            MainTabView()
                .environmentObject(favoritesStore)
        }
    }
}

