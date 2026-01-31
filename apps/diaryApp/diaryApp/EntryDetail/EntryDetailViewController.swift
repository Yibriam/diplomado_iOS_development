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
    
    private let titleLabel = UILabel()
    private let messageLabel = UILabel()
    private let dateLabel = UILabel()
    private let imageView = UIImageView()
    private let locationLabel = UILabel()
    private let segmentedControl = UISegmentedControl(items: ["Walking", "Driving"])
    private let directionsButton = UIButton(type: .system)
    
    init(entry: DiaryEntry) {
        self.viewModel = EntryDetailViewModel(entry: entry)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupUI()
        configureWithEntry()
    }
    
    private func setupUI() {
        titleLabel.font = UIFont.boldSystemFont(ofSize: 22)
        messageLabel.numberOfLines = 0
        dateLabel.font = UIFont.italicSystemFont(ofSize: 14)
        locationLabel.textColor = .secondaryLabel
        
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.heightAnchor.constraint(equalToConstant: 200).isActive = true
        
        segmentedControl.selectedSegmentIndex = 0
        
        directionsButton.setTitle("Get Directions", for: .normal)
        directionsButton.addTarget(self, action: #selector(showDirections), for: .touchUpInside)
        
        let stack = UIStackView(arrangedSubviews: [
            titleLabel,
            dateLabel,
            messageLabel,
            imageView,
            locationLabel,
            segmentedControl,
            directionsButton
        ])
        stack.axis = .vertical
        stack.spacing = 12
        stack.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(stack)
        NSLayoutConstraint.activate([
            stack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            stack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            stack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
        ])
    }
    
    private func configureWithEntry() {
        let entry = viewModel.entry
        titleLabel.text = entry.title
        messageLabel.text = entry.message
        dateLabel.text = DateFormatter.localizedString(from: entry.date, dateStyle: .medium, timeStyle: .short)
        
        if let photoFilename = entry.photoFilename {
            let documents = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
            let photoURL = documents.appendingPathComponent(photoFilename)
            if let data = try? Data(contentsOf: photoURL) {
                imageView.image = UIImage(data: data)
            }
        }
        
        if let location = entry.location {
            locationLabel.text = location.address
            directionsButton.isHidden = false
            segmentedControl.isHidden = false
        } else {
            locationLabel.text = "No location"
            directionsButton.isHidden = true
            segmentedControl.isHidden = true
        }
    }
    
    @objc private func showDirections() {
        viewModel.openDirections(transportType: segmentedControl.selectedSegmentIndex == 0 ? .walking : .automobile)
    }
}
