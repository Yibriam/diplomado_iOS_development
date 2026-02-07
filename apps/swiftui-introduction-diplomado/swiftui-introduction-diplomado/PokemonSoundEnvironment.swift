//
//  PokemonSoundEnvironment.swift
//  swiftui-introduction-diplomado
//
//  Created by Alejandro Mendoza on 31/01/26.
//


import SwiftUI

public typealias PokemonSoundAction = (() -> Void)?

public struct PokemonSoundEnvironmentKey: EnvironmentKey {
    public static let defaultValue: PokemonSoundAction = {
        print("playing a pokemon sound is not implemented in this environment")
    }
}

public extension EnvironmentValues {
    var pokemonSoundAction: PokemonSoundAction {
        get { self[PokemonSoundEnvironmentKey.self] }
        set { self[PokemonSoundEnvironmentKey.self] = newValue }
    }
}
