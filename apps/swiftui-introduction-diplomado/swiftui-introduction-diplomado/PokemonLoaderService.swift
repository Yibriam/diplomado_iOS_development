//
//  PokemonLoaderService.swift
//  swiftui-introduction-diplomado
//
//  Created by Alejandro Mendoza on 31/01/26.
//

import Foundation

struct Pokemon: Codable, Identifiable {
    let name: String
    let id: Int
    let num: String
    let img: String
}

class PokemonLoaderService {
    public static var shared = PokemonLoaderService()
    
    private(set) var pokemon: [Pokemon] = []
    
    private init() {
        loadPokemon()
    }
    
    func loadPokemon() {
        pokemon = load("pokemon_list.json")
    }
    
    func load<T: Decodable>(_ fileName: String) -> T {
        guard let fileURL = Bundle.main.url(forResource: fileName, withExtension: nil) else {
            fatalError("Cannot find file \(fileName) in Bundle")
        }
        
        let data: Data
        do {
            data = try Data(contentsOf: fileURL)
        } catch {
            fatalError("Couldn't load \(fileName) from Bundle with error: \(error.localizedDescription)")
        }
        
        do {
            let decoder = JSONDecoder()
            return try decoder.decode(T.self, from: data)
        } catch {
            fatalError("Couldn't decode \(fileName) error: \(error.localizedDescription)")
        }
    }
    
}
