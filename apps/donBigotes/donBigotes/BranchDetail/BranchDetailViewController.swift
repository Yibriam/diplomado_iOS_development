//
//  BranchDetailViewController.swift
//  donBigotes
//
//  Created by Yibriam on 23/01/26.
//

import UIKit
import MapKit

class BranchDetailViewController: UIViewController {
    
    private let viewModel: BranchDetailViewModel
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.backgroundColor = .systemBackground
        return scrollView
    }()
    
    private let stackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 16
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private let mapView: MKMapView = {
        let map = MKMapView()
        map.layer.cornerRadius = 12
        map.translatesAutoresizingMaskIntoConstraints = false
        return map
    }()
    
    init(branch: Branch) {
        self.viewModel = BranchDetailViewModel(branch: branch)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupUI()
        configureWithViewModel()
    }
    
    private func setupUI() {
        view.addSubview(scrollView)
        scrollView.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            stackView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 20),
            stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -20),
            stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -20),
            stackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor, constant: -40),
            
            mapView.heightAnchor.constraint(equalToConstant: 300)
        ])
    }
    
    private func configureWithViewModel() {
        self.title = viewModel.name
        
        addLabel(text: viewModel.name, font: .boldSystemFont(ofSize: 26))
        addLabel(text: "📍 \(viewModel.fullAddress)", font: .systemFont(ofSize: 16))
        addLabel(text: "📞 \(viewModel.phone)", font: .systemFont(ofSize: 16), color: .systemBlue)
        
        addLabel(text: "Horarios:", font: .boldSystemFont(ofSize: 18))
        addLabel(text: "• Lunes-Viernes: \(viewModel.mondayFridayHours)")
        addLabel(text: "• Sábado: \(viewModel.saturdayHours)")
        addLabel(text: "• Domingo: \(viewModel.sundayHours)")
        
        addLabel(text: "Servicios Disponibles:", font: .boldSystemFont(ofSize: 18))
        addLabel(text: viewModel.servicesList, font: .systemFont(ofSize: 15), color: .secondaryLabel)
        
        stackView.addArrangedSubview(mapView)
        setupMap()
    }
    
    private func addLabel(text: String, font: UIFont = .systemFont(ofSize: 14), color: UIColor = .label) {
        let label = UILabel()
        label.text = text
        label.font = font
        label.textColor = color
        label.numberOfLines = 0
        stackView.addArrangedSubview(label)
    }
    
    private func setupMap() {
        let coords = viewModel.coordinate
        let coordinate = CLLocationCoordinate2D(latitude: coords.latitude, longitude: coords.longitude)
        
        let annotation = MKPointAnnotation()
        annotation.coordinate = coordinate
        annotation.title = viewModel.name
        
        mapView.addAnnotation(annotation)
        
        let region = MKCoordinateRegion(center: coordinate,
                                        latitudinalMeters: 500,
                                        longitudinalMeters: 500)
        mapView.setRegion(region, animated: true)
    }
}
