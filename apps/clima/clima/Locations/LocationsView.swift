//
//  LocationView.swift
//  clima
//
//  Created by Yibriam on 21/02/26.
//

import SwiftUI

struct LocationsView: View {
    @State private var locations: [Location] = []

    private let explicitAssetMap: [String: String] = [
        "Canada": "CanadáCA",
        "Mexico": "Mexico",
        "United Kingdom": "London",
        "United States": "USA"
    ]

    var body: some View {
        NavigationView {
            ScrollView {
                LazyVStack(spacing: 12) {
                    ForEach(locations) { location in
                        NavigationLink(destination: DetailView(location: location)) {
                            HStack(spacing: 12) {
                                imageForLocation(location.nombre)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 60, height: 38)
                                    .cornerRadius(6)
                                    .shadow(radius: 1)

                                Text(location.nombre)
                                    .font(.headline)

                                Spacer()
                            }
                            .padding(.horizontal)
                            .padding(.vertical, 6)
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                }
                .padding(.vertical)
            }
            .navigationTitle("Ubicaciones")
        }
        .onAppear {
            loadLocations()
        }
    }

    // MARK: - Image resolution

    private func imageForLocation(_ name: String) -> Image {
        if let mapped = explicitAssetMap[name], let _ = UIImage(named: mapped) {
            return Image(mapped)
        }
        
        if let _ = UIImage(named: name) {
            return Image(name)
        }

        let candidates = generateCandidates(from: name)
        for candidate in candidates {
            if let _ = UIImage(named: candidate) {
                return Image(candidate)
            }
        }

        return Image(systemName: "flag.fill")
    }

    private func generateCandidates(from name: String) -> [String] {
        var results: [String] = []
        
        results.append(name.lowercased())

        let normalized = name.folding(options: .diacriticInsensitive, locale: .current)
            .components(separatedBy: CharacterSet.alphanumerics.inverted)
            .joined()

        if !normalized.isEmpty {
            results.append(normalized)
            results.append(normalized.lowercased())
        }

        let noSpaces = name.replacingOccurrences(of: " ", with: "")
        if !noSpaces.isEmpty {
            results.append(noSpaces)
            results.append(noSpaces.lowercased())
        }

        let underscore = name.replacingOccurrences(of: " ", with: "_")
        if !underscore.isEmpty {
            results.append(underscore)
            results.append(underscore.lowercased())
        }

        results.append(name.capitalized)
        
        var seen = Set<String>()
        return results.filter { seen.insert($0).inserted }
    }

    // MARK: - Load JSON

    private func loadLocations() {
        if let url = Bundle.main.url(forResource: "LocationList", withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                locations = try JSONDecoder().decode([Location].self, from: data)
            } catch {
                print("Error loading locations: \(error)")
            }
        } else {
            print("LocationList.json not found in bundle.")
        }
    }
}

#Preview {
    LocationsView()
}


