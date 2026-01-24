//
//  PokemonLocationViewModel.swift
//  diplomado-10-pokedex-kits
//
//  Created by Yibriam on 23/01/26.
//

import Foundation
import CoreLocation
import UIKit
import MapKit

protocol PokemonLocationViewModelDelegate: AnyObject {
    func didUpdateLocation(region: MKCoordinateRegion)
    func didUpdatePermissionStatus(isDenied: Bool)
}

class PokemonLocationViewModel: NSObject {
    private let locationManager = CLLocationManager()
    let pokemon: Pokemon
    let pokemonImage: UIImage?
    
    weak var delegate: PokemonLocationViewModelDelegate?
    
    init(pokemon: Pokemon, pokemonImage: UIImage?) {
        self.pokemon = pokemon
        self.pokemonImage = pokemonImage
        super.init()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
    }
    
    func startRequestingLocation() {
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
}

extension PokemonLocationViewModel: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        let region = MKCoordinateRegion(center: location.coordinate,
                                        span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
        delegate?.didUpdateLocation(region: region)
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        let status = manager.authorizationStatus
        if status == .denied || status == .restricted {
            delegate?.didUpdatePermissionStatus(isDenied: true)
        }
    }
}
