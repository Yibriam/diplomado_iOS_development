//
//  FavoritesStore.swift
//  clima
//
//  Created by You on 2026-02-21.
//

import Foundation
import Combine
import UIKit

// MARK: - Favorite model
struct Favorite: Codable, Equatable, Identifiable {
    let id: UUID
    let name: String      // location.nombre (used for navigation)
    let country: String   // weather.location.country
    let region: String?   // optional
    let assetName: String // image name in Assets.xcassets

    init(id: UUID = UUID(), name: String, country: String, region: String? = nil, assetName: String) {
        self.id = id
        self.name = name
        self.country = country
        self.region = region
        self.assetName = assetName
    }
}

// MARK: - FavoritesStore
final class FavoritesStore: ObservableObject {
    @Published private(set) var favorites: [Favorite] = []

    private let key = "favorites"
    private var cancellables = Set<AnyCancellable>()

    init() {
        migrateIfNeeded()
        load()
        $favorites
            .sink { [weak self] new in // Combine
                self?.save(new)
            }
            .store(in: &cancellables)
    }

    // MARK: - Public API

    func isFavorite(name: String) -> Bool {
        favorites.contains { $0.name == name }
    }

    func isFavoriteAsset(_ assetName: String) -> Bool {
        favorites.contains { $0.assetName == assetName }
    }

    /// Toggle by providing the assetName to store
    func toggle(name: String, country: String, region: String? = nil, assetName: String) {
        if let idx = favorites.firstIndex(where: { $0.name == name && $0.country == country && $0.assetName == assetName }) {
            favorites.remove(at: idx)
        } else {
            let fav = Favorite(name: name, country: country, region: region, assetName: assetName)
            favorites.append(fav)
        }
    }

    // MARK: - Persistence

    private func load() {
        guard let data = UserDefaults.standard.data(forKey: key) else {
            favorites = []
            return
        }
        do {
            favorites = try JSONDecoder().decode([Favorite].self, from: data)
        } catch {
            print("Favorites decode error:", error)
            favorites = []
        }
    }

    private func save(_ list: [Favorite]) {
        do {
            let data = try JSONEncoder().encode(list)
            UserDefaults.standard.set(data, forKey: key)
        } catch {
            print("Favorites encode error:", error)
        }
    }

    // MARK: - Migration (attempt to convert older formats)
    private func migrateIfNeeded() {
        // If new format already exists, nothing to do
        if UserDefaults.standard.data(forKey: key) != nil { return }

        // Example: try legacy key "favorites_strings" (JSON [String])
        if let legacyData = UserDefaults.standard.data(forKey: "favorites_strings") {
            do {
                let oldStrings = try JSONDecoder().decode([String].self, from: legacyData)
                let migrated = oldStrings.map { Favorite(name: $0, country: "", region: nil, assetName: resolveAssetName(for: $0)) }
                UserDefaults.standard.set(try JSONEncoder().encode(migrated), forKey: key)
            } catch {
                // ignore
            }
        }

        // Example: try comma-joined legacy string under "favorites_joined"
        if let legacyJoined = UserDefaults.standard.string(forKey: "favorites_joined") {
            let parts = legacyJoined.split(separator: ",").map { String($0) }
            let migrated = parts.map { Favorite(name: $0, country: "", region: nil, assetName: resolveAssetName(for: $0)) }
            do {
                let data = try JSONEncoder().encode(migrated)
                UserDefaults.standard.set(data, forKey: key)
            } catch {
                // ignore
            }
        }
    }
}
