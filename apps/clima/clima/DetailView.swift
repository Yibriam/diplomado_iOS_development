//
//  DetailView.swift
//  clima
//
//  Created by You on 2026-02-21.
//

import SwiftUI
import MapKit

struct DetailView: View {
    let location: Location
    @EnvironmentObject var favoritesStore: FavoritesStore
    
    @State private var weather: WeatherResponse?
    @State private var isLoading = true
    @State private var showError = false
    @State private var errorMessage = ""
    @State private var unit: TemperatureUnit = .celsius
    
    var body: some View {
        ZStack {
            backgroundColor
                .ignoresSafeArea()
            
            if isLoading {
                ProgressView("Loading weather...")
            } else if let weather = weather {
                content(for: weather)
                    .navigationTitle(location.nombre)
                    .navigationBarTitleDisplayMode(.inline)
            } else {
                Text("No data")
                    .foregroundColor(.primary)
            }
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {
                    let asset = resolveAssetName(for: weather?.location.country ?? location.nombre)
                    favoritesStore.toggle(
                        name: location.nombre,
                        country: weather?.location.country ?? "",
                        region: weather?.location.region,
                        assetName: asset
                    )
                }) {
                    let assetForCheck = weather?.location.country ?? location.nombre
                    let assetName = resolveAssetName(for: assetForCheck)
                    Image(systemName: favoritesStore.isFavoriteAsset(assetName) ? "star.fill" : "star")
                }
            }
        }
        .task {
            if ProcessInfo.processInfo.environment["XCODE_RUNNING_FOR_PREVIEWS"] == "1" {
                self.weather = WeatherResponse.mock
                self.isLoading = false
                return
            }
            await loadWeather()
        }
        .alert("Error", isPresented: $showError) {
            Button("OK") { }
        } message: {
            Text(errorMessage)
        }
    }
    
    @ViewBuilder
    private func content(for weather: WeatherResponse) -> some View {
        ScrollView {
            VStack(spacing: 12) {
                HStack {
                    Color.clear.frame(width: 44, height: 1)
                    Spacer()
                    Text(weather.location.region)
                        .font(.headline)
                        .foregroundColor(.white)
                        .lineLimit(1)
                        .truncationMode(.tail)
                    Spacer()
                    Color.clear.frame(width: 44, height: 1)
                }
                .padding(.top, 6)
                .padding(.horizontal)
                
                Picker("Unit", selection: $unit) {
                    Text("C").tag(TemperatureUnit.celsius)
                    Text("F").tag(TemperatureUnit.fahrenheit)
                }
                .pickerStyle(.segmented)
                .padding(.horizontal, 145)
                
                HStack(alignment: .center, spacing: 16) {
                    if let iconURL = normalizedIconURL(from: weather.current.condition.icon) {
                        AsyncImage(url: iconURL) { image in
                            image.resizable()
                                .scaledToFit()
                                .frame(width: 100, height: 100)
                        } placeholder: {
                            ProgressView()
                                .frame(width: 100, height: 100)
                        }
                    } else {
                        Rectangle()
                            .fill(Color.white.opacity(0.2))
                            .frame(width: 100, height: 100)
                    }
                    
                    Text("\(temperature(for: weather))º")
                        .font(.system(size: 40, weight: .bold))
                        .foregroundColor(.white)
                    
                    Text("UV: \(weather.current.uv)")
                        .font(.headline)
                        .foregroundColor(.white.opacity(0.95))
                    
                    
                    Spacer()
                }
                .padding(.horizontal)
                
                Text("\(formattedDate(weather.location.localtime))")
                    .font(.subheadline)
                    .foregroundColor(.white.opacity(0.9))
                
                Map(coordinateRegion: .constant(MKCoordinateRegion(
                    center: CLLocationCoordinate2D(latitude: weather.location.lat,
                                                   longitude: weather.location.lon),
                    span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5)
                )))
                .frame(height: 320)
                //.cornerRadius(12)
                .padding(.horizontal, 30)
                
                HStack {
                    Spacer()
                    Text("Last Update: \(formattedDate(weather.current.last_updated))")
                        .font(.subheadline)
                        .foregroundColor(.white.opacity(0.9))
                }
                .padding(.horizontal)
            }
            .padding(.vertical)
        }
    }
    
    // MARK: - Helpers
    
    private var backgroundColor: Color {
        guard let weather = weather else { return Color.white }
        return weather.current.is_day == 1 ? Color(.day) : Color(.night)
    }
    
    private func temperature(for weather: WeatherResponse) -> String {
        switch unit {
        case .celsius: return String(format: "%.1f", weather.current.temp_c)
        case .fahrenheit: return String(format: "%.1f", weather.current.temp_f)
        }
    }
    
    private func formattedDate(_ dateString: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm"
        if let date = formatter.date(from: dateString) {
            let output = DateFormatter()
            output.dateFormat = "dd/MM/yyyy HH:mm"
            return output.string(from: date)
        }
        return dateString
    }
    
    private func normalizedIconURL(from iconString: String) -> URL? {
        var s = iconString
        if s.hasPrefix("//") { s = "https:" + s }
        else if s.hasPrefix("/") { s = "https://\(s)" }
        else if !s.hasPrefix("http") { s = "https://\(s)" }
        return URL(string: s)
    }
    
    private func loadWeather() async {
        do {
            weather = try await WeatherService.shared.fetchWeather(for: location.nombre)
            isLoading = false
        } catch {
            errorMessage = (error as? LocalizedError)?.errorDescription ?? error.localizedDescription
            showError = true
            isLoading = false
        }
    }
}

// MARK: - Preview
struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            DetailView(location: Location(id: 1, nombre: "London"))
                .environmentObject(FavoritesStore())
        }
    }
}
