//
//  PokemonLocationViewController.swift
//  diplomado-10-pokedex-kits
//
//  Created by Alejandro Mendoza on 17/01/26.
//

import UIKit
import MapKit

class PokemonLocationViewController: UIViewController {
    
    private let viewModel: PokemonLocationViewModel
    
    private lazy var mapView: MKMapView = {
        let mapView = MKMapView()
        mapView.translatesAutoresizingMaskIntoConstraints = false
        mapView.preferredConfiguration = MKHybridMapConfiguration()
        mapView.showsUserLocation = true
        mapView.delegate = self
        return mapView
    }()
    
    init(pokemon: Pokemon, pokemonImage: UIImage?) {
        self.viewModel = PokemonLocationViewModel(pokemon: pokemon, pokemonImage: pokemonImage)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.delegate = self
        setupView()
        viewModel.startRequestingLocation()
    }
    
    private func setupView() {
        view.addSubview(mapView)
        
        // 1.4: Setup Close Button
        let closeButton = UIButton(type: .system)
        closeButton.setImage(UIImage(systemName: "xmark.circle.fill"), for: .normal)
        closeButton.tintColor = .white
        closeButton.backgroundColor = .black.withAlphaComponent(0.5)
        closeButton.layer.cornerRadius = 15
        closeButton.translatesAutoresizingMaskIntoConstraints = false
        closeButton.addTarget(self, action: #selector(dismissModal), for: .touchUpInside)
        
        view.addSubview(closeButton)
        
        // Setup Show Location Button
        var config = UIButton.Configuration.filled()
        config.title = "Show Pokémon Location"
        let showBtn = UIButton(configuration: config)
        showBtn.translatesAutoresizingMaskIntoConstraints = false
        showBtn.addTarget(self, action: #selector(showPokemonLocationButtonTapped), for: .touchUpInside)
        view.addSubview(showBtn)
        
        NSLayoutConstraint.activate([
            mapView.topAnchor.constraint(equalTo: view.topAnchor),
            mapView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mapView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            mapView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            closeButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            closeButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            closeButton.widthAnchor.constraint(equalToConstant: 30),
            closeButton.heightAnchor.constraint(equalToConstant: 30),
            
            showBtn.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            showBtn.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    @objc private func dismissModal() { dismiss(animated: true) }
    
    @objc private func showPokemonLocationButtonTapped() {
        guard let loc = viewModel.pokemon.location else { return }
        let coord = CLLocationCoordinate2D(latitude: loc.latitude, longitude: loc.longitude)
        
        let annotation = MKPointAnnotation()
        annotation.coordinate = coord
        annotation.title = viewModel.pokemon.name
        mapView.addAnnotation(annotation)
        
        let region = MKCoordinateRegion(center: coord, latitudinalMeters: 500, longitudinalMeters: 500)
        mapView.setRegion(region, animated: true)
    }
}

// 1.6: Respond to ViewModel notifications
extension PokemonLocationViewController: PokemonLocationViewModelDelegate {
    func didUpdateLocation(region: MKCoordinateRegion) {
        mapView.setRegion(region, animated: true)
    }
    
    func didUpdatePermissionStatus(isDenied: Bool) {
        if isDenied {
            let alert = UIAlertController(title: "Location Denied",
                                          message: "Please allow access in settings to see your distance to the Pokémon.",
                                          preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default) { _ in self.dismissModal() })
            present(alert, animated: true)
        }
    }
}

extension PokemonLocationViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard !(annotation is MKUserLocation) else { return nil }
        let view = MKAnnotationView(annotation: annotation, reuseIdentifier: "poke")
        view.image = viewModel.pokemonImage
        view.frame.size = CGSize(width: 40, height: 40)
        return view
    }
}
