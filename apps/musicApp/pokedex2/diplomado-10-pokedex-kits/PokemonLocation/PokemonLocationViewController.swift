//
//  PokemonLocationViewController.swift
//  diplomado-10-pokedex-kits
//
//  Created by Alejandro Mendoza on 17/01/26.
//

import UIKit
import MapKit
import CoreLocation

class PokemonLocationViewController: UIViewController {
    
    private lazy var mapView: MKMapView = {
        let mapView = MKMapView()
        mapView.translatesAutoresizingMaskIntoConstraints = false
        mapView.preferredConfiguration = MKHybridMapConfiguration()
        mapView.showsUserLocation = true
        mapView.delegate = self
        return mapView
    }()
    
    private let locationManager = CLLocationManager()
    
    private let pokemon: Pokemon
    private let pokemonImage: UIImage?
    
    init(pokemon: Pokemon, pokemonImage: UIImage?) {
        self.pokemon = pokemon
        self.pokemonImage = pokemonImage
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("Programmatic viewcontroller")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    private func setupView() {
        view.addSubview(mapView)
        
        NSLayoutConstraint.activate([
            mapView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mapView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            mapView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            mapView.topAnchor.constraint(equalTo: view.topAnchor)
        ])
        
        var showPokemonLocationConfiguration = UIButton.Configuration.filled()
        showPokemonLocationConfiguration.title = "Show pokemon location"
        
        let showPokemonLocationButton = UIButton(configuration: showPokemonLocationConfiguration)
        showPokemonLocationButton.translatesAutoresizingMaskIntoConstraints = false
        showPokemonLocationButton.addTarget(self,
                                            action: #selector(showPokemonLocationButtonTapped),
                                            for: .touchUpInside)
        
        view.addSubview(showPokemonLocationButton)
        
        NSLayoutConstraint.activate([
            showPokemonLocationButton.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            showPokemonLocationButton.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    @objc
    private func showPokemonLocationButtonTapped() {
        guard let pokemonLocation = pokemon.location else { return }
        
        let pokemonCoordinate = CLLocationCoordinate2D(latitude: pokemonLocation.latitude,
                                                       longitude: pokemonLocation.longitude)
        
        let pokemonAnnotation = MKPointAnnotation()
        pokemonAnnotation.coordinate = pokemonCoordinate
        pokemonAnnotation.title = pokemon.name
        
        mapView.addAnnotation(pokemonAnnotation)
        
        let mapRegion = MKCoordinateRegion(center: pokemonCoordinate,
                                           latitudinalMeters: 0.005,
                                           longitudinalMeters: 0.005)
        mapView.region = mapRegion
        
    }

}

extension PokemonLocationViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        
        let coordinate = CLLocationCoordinate2D(latitude: location.coordinate.latitude,
                                                longitude: location.coordinate.longitude)
        
//        let userAnnotation = MKPointAnnotation()
//        userAnnotation.coordinate = coordinate
//        
//        mapView.addAnnotation(userAnnotation)
        
        let mapRegion = MKCoordinateRegion(center: coordinate,
                                           span: MKCoordinateSpan(latitudeDelta: 0.01,
                                                                  longitudeDelta: 0.01))
        mapView.region = mapRegion
    }
}

extension PokemonLocationViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: any MKAnnotation) -> MKAnnotationView? {
        guard !(annotation is MKUserLocation) else { return nil }
        
        let annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: nil)
        annotationView.image = pokemonImage
        
        return annotationView
    }
}
