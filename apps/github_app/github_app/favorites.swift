//
//  favorites.swift
//  github_app
//
//  Created by Yibriam on 10/01/26.
//

import Foundation

struct FavoriteUser: Codable {
    let login: String
    let avatar_url: String
}

class FavoritesManager {
    static let shared = FavoritesManager()
    private let key = "favoriteUsers"
    
    func addFavorite(_ user: FavoriteUser) {
        var favorites = getFavorites()
        if !favorites.contains(where: { $0.login == user.login }) {
            favorites.append(user)
            saveFavorites(favorites)
        }
    }
    
    func removeFavorite(_ login: String) {
        var favorites = getFavorites()
        favorites.removeAll { $0.login == login }
        saveFavorites(favorites)
    }
    
    func getFavorites() -> [FavoriteUser] {
        guard let data = UserDefaults.standard.data(forKey: key) else { return [] }
        return (try? JSONDecoder().decode([FavoriteUser].self, from: data)) ?? []
    }
    
    private func saveFavorites(_ favorites: [FavoriteUser]) {
        if let data = try? JSONEncoder().encode(favorites) {
            UserDefaults.standard.set(data, forKey: key)
        }
    }
}
