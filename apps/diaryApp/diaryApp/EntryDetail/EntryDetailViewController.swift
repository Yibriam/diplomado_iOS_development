//
//  EntryDetailViewController.swift
//  diaryApp
//
//  Created by Yibriam on 30/01/26.
//

import UIKit
import MapKit

class EntryDetailViewController: UIViewController {
    private let viewModel: EntryDetailViewModel
    
    // MARK: - UI Components
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    private let stackView = UIStackView()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 24)
        label.numberOfLines = 0
        return label
    }()
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.textColor = .secondaryLabel
        return label
    }()
    
    private let imageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.layer.cornerRadius = 12
        iv.backgroundColor = .systemGray6
        return iv
    }()
    
    private let messageLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 16)
        return label
    }()
    
    private let locationLabel: UILabel = {
        let label = UILabel()
        label.font = .italicSystemFont(ofSize: 14)
        label.textColor = .systemBlue
        label.numberOfLines = 0
        return label
    }()
    
    private let mapView = MKMapView()
    
    // Requirement: UISegmentedControl for walking/driving
    private let transportSegmentedControl = UISegmentedControl(items: ["Walking", "Driving"])
    
    // Requirement: Get Directions Button
    private let directionsButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("Get Directions", for: .normal)
        btn.backgroundColor = .systemBlue
        btn.setTitleColor(.white, for: .normal)
        btn.titleLabel?.font = .boldSystemFont(ofSize: 16)
        btn.layer.cornerRadius = 10
        btn.heightAnchor.constraint(equalToConstant: 44).isActive = true
        return btn
    }()

    init(entry: DiaryEntry) {
        self.viewModel = EntryDetailViewModel(entry: entry)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) { fatalError() }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = "Entry Details"
        setupUI()
        configureData()
    }
    
    private func setupUI() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(stackView)
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        stackView.axis = .vertical
        stackView.spacing = 20
        
        // Layout Constraints
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20),
            
            mapView.heightAnchor.constraint(equalToConstant: 200),
            imageView.heightAnchor.constraint(equalToConstant: 250)
        ])
        
        // Add to stack
        [titleLabel, dateLabel, imageView, messageLabel, locationLabel, transportSegmentedControl, directionsButton, mapView].forEach {
            stackView.addArrangedSubview($0)
        }
        
        mapView.delegate = self
        mapView.layer.cornerRadius = 12
        
        transportSegmentedControl.selectedSegmentIndex = 0
        transportSegmentedControl.addTarget(self, action: #selector(didChangeTransportType), for: .valueChanged)
        directionsButton.addTarget(self, action: #selector(didTapGetDirections), for: .touchUpInside)
    }
    
    private func configureData() {
        let entry = viewModel.entry
        titleLabel.text = entry.title
        messageLabel.text = entry.message
        
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        dateLabel.text = formatter.string(from: entry.date)
        
        if let filename = entry.photoFilename {
            imageView.image = viewModel.loadImageFromDisk(filename: filename)
            imageView.isHidden = false
        } else {
            imageView.isHidden = true
        }
        
        if let loc = entry.location {
            locationLabel.text = "📍 \(loc.address)"
            let coord = CLLocationCoordinate2D(latitude: loc.latitude, longitude: loc.longitude)
            let annotation = MKPointAnnotation()
            annotation.coordinate = coord
            mapView.addAnnotation(annotation)
            mapView.setRegion(MKCoordinateRegion(center: coord, latitudinalMeters: 1000, longitudinalMeters: 1000), animated: false)
        } else {
            // Requirement: Hide elements if no location
            locationLabel.isHidden = true
            transportSegmentedControl.isHidden = true
            directionsButton.isHidden = true
            mapView.isHidden = true
        }
    }
    
    @objc private func didChangeTransportType() {
        // If a route is already visible, update it immediately
        if !mapView.overlays.isEmpty {
            didTapGetDirections()
        }
    }
    
    @objc private func didTapGetDirections() {
        let type: MKDirectionsTransportType = transportSegmentedControl.selectedSegmentIndex == 0 ? .walking : .automobile
        
        viewModel.calculateRoute(transportType: type) { [weak self] route in
            guard let self = self, let route = route else { return }
            self.mapView.removeOverlays(self.mapView.overlays)
            self.mapView.addOverlay(route.polyline)
            self.mapView.setVisibleMapRect(route.polyline.boundingMapRect,
                                          edgePadding: UIEdgeInsets(top: 50, left: 50, bottom: 50, right: 50),
                                          animated: true)
        }
    }
}

extension EntryDetailViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        if let polyline = overlay as? MKPolyline {
            let renderer = MKPolylineRenderer(polyline: polyline)
            renderer.strokeColor = .systemBlue
            renderer.lineWidth = 5
            return renderer
        }
        return MKOverlayRenderer()
    }
}
