//
//  HomeViewController.swift
//  donBigotes
//
//  Created by Yibriam on 23/01/26.
//

import UIKit

class HomeViewController: UIViewController {
    private let viewModel = HomeViewModel()
    
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    
    private let logoImageView: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(systemName: "pawprint.circle.fill")
//        iv.image = UIImage(store?.logoUrl)
        iv.tintColor = .systemOrange
        iv.contentMode = .scaleAspectFit
        return iv
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 34, weight: .bold)
        label.textAlignment = .center
        return label
    }()
    
    private let sloganLabel: UILabel = {
        let label = UILabel()
        label.font = .italicSystemFont(ofSize: 18)
        label.textColor = .secondaryLabel
        label.textAlignment = .center
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 16)
        label.textAlignment = .justified
        return label
    }()
    
    private lazy var viewBranchesButton: UIButton = {
        var config = UIButton.Configuration.filled()
        config.title = "View Branches"
        config.baseBackgroundColor = .systemOrange
        let button = UIButton(configuration: config)
        button.addTarget(self, action: #selector(goToBranches), for: .touchUpInside)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupUI()
        displayData()
    }
    
    private func setupUI() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false
        
        [logoImageView, nameLabel, sloganLabel, descriptionLabel, viewBranchesButton].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            contentView.addSubview($0)
        }
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            
            logoImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 40),
            logoImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            logoImageView.heightAnchor.constraint(equalToConstant: 120),
            
            nameLabel.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 16),
            nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            
            sloganLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 8),
            sloganLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            
            descriptionLabel.topAnchor.constraint(equalTo: sloganLabel.bottomAnchor, constant: 24),
            descriptionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            descriptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            
            viewBranchesButton.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 30),
            viewBranchesButton.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            viewBranchesButton.heightAnchor.constraint(equalToConstant: 50),
            viewBranchesButton.widthAnchor.constraint(equalToConstant: 200),
            viewBranchesButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -40)
        ])
    }
    
    private func displayData() {
        title = "Don Bigotes"
        nameLabel.text = viewModel.name
        sloganLabel.text = viewModel.slogan
        descriptionLabel.text = viewModel.description
    }
    
    @objc private func goToBranches() {
        let vc = BranchListViewController(branches: viewModel.getBranches())
        navigationController?.pushViewController(vc, animated: true)
    }
}
