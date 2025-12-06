//
//  ColoursLocalRepository.swift
//  AppModulo
//
//  Created by Yibriam on 29/11/25.
//

import Foundation

protocol ColoursRepository {
    func getColoursList(for user: String) throws -> [ColourDTO]?
}

struct ColoursLocalRepository: ColoursRepository {
    func getColoursList(for user: String) throws -> [ColourDTO]? {
        guard let url = Bundle.main.url(forResource: "Colours", withExtension: ".json") else { return nil }
        let data = try Data(contentsOf: url)
        return try JSONDecoder().decode([ColourDTO].self, from: data)
    }
}
