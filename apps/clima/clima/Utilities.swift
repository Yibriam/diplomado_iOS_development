//
//  Utilities.swift
//  clima
//
//  Created by Yibriam on 21/02/26.
//

import Foundation
import UIKit

func resolveAssetName(for source: String) -> String {
    let explicit: [String: String] = [
        "Argentina": "Argentina",
        "Brazil": "Brazil",
        "Canada": "CanadáCA",
        "Canadá": "CanadáCA",
        "China": "China",
        "France": "France",
        "Germany": "Germany",
        "Japan": "Japan",
        "United Kingdom": "London",
        "London": "London",
        "Mexico": "Mexico",
        "México": "Mexico",
        "Spain": "Spain"
    ]

    if let mapped = explicit[source] {
        if UIImage(named: mapped) != nil { return mapped }
    }

    // Try exact source as-is (asset names are case-sensitive in asset catalog)
    if UIImage(named: source) != nil { return source }

    // Try lowercased
    let lower = source.lowercased()
    if UIImage(named: lower) != nil { return lower }

    // Normalize: remove diacritics and non-alphanumerics
    let normalized = source.folding(options: .diacriticInsensitive, locale: .current)
        .components(separatedBy: CharacterSet.alphanumerics.inverted)
        .joined()
    if !normalized.isEmpty {
        if UIImage(named: normalized) != nil { return normalized }
        if UIImage(named: normalized.lowercased()) != nil { return normalized.lowercased() }
    }

    // Remove spaces
    let noSpaces = source.replacingOccurrences(of: " ", with: "")
    if UIImage(named: noSpaces) != nil { return noSpaces }
    if UIImage(named: noSpaces.lowercased()) != nil { return noSpaces.lowercased() }

    // Fallback: return a safe placeholder asset name if you have one, otherwise return source lowercased
    // Make sure you have a placeholder asset named "flag_placeholder" or change accordingly.
    if UIImage(named: "flag_placeholder") != nil { return "flag_placeholder" }

    return lower
}
