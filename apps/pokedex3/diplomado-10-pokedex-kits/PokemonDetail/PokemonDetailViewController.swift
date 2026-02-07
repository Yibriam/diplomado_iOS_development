//
//  PokemonDetailViewController.swift
//  diplomado-10-pokedex-kits
//
//  Created by Alejandro Mendoza on 17/01/26.
//

import UIKit

class PokemonDetailViewController: UIViewController {
    
    private let viewModel: PokemonDetailViewModel
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.backgroundColor = .systemBackground
        
        return scrollView
    }()
    
    private lazy var contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .systemBackground
        
        return view
    }()
    
    private lazy var pokemonImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(systemName: "lizard")
        
        NSLayoutConstraint.activate([
            imageView.widthAnchor.constraint(equalToConstant: 100),
            imageView.heightAnchor.constraint(equalToConstant: 100)
        ])
        
        return imageView
    }()
    
    private lazy var pokemonNumberLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .preferredFont(forTextStyle: .largeTitle)
        label.adjustsFontForContentSizeCategory = true
        label.text = viewModel.pokemonNumber
        return label
    }()
    
    init(pokemon: Pokemon) {
        self.viewModel = PokemonDetailViewModel(pokemon: pokemon)
        super.init(nibName: nil, bundle: nil)
        
        viewModel.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("Programmatic viewcontroller")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
    }
    
    private func setupView() {
        self.view.backgroundColor = .systemBackground
        self.title = viewModel.pokemonName
        
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
//        let redView = UIView()
//        redView.backgroundColor = .red
//        redView.translatesAutoresizingMaskIntoConstraints = false
//        contentView.addSubview(redView)
        
        let contentViewHeightAnchor = contentView.heightAnchor.constraint(equalTo: scrollView.heightAnchor)
        contentViewHeightAnchor.isActive = true
        contentViewHeightAnchor.priority = UILayoutPriority.required - 1
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            
//            redView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
//            redView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
//            redView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
//            redView.widthAnchor.constraint(equalToConstant: 100),
//            redView.heightAnchor.constraint(equalToConstant: 1000),
        ])
        
        
        let pokemonInfoStackView = UIStackView()
        pokemonInfoStackView.translatesAutoresizingMaskIntoConstraints = false
        pokemonInfoStackView.axis = .vertical
        pokemonInfoStackView.alignment = .leading
        pokemonInfoStackView.spacing = 12
        pokemonInfoStackView.distribution = .fillProportionally
        
        contentView.addSubview(pokemonInfoStackView)
        
        pokemonInfoStackView.addArrangedSubview(pokemonImageView)
        pokemonInfoStackView.addArrangedSubview(pokemonNumberLabel)
        
        NSLayoutConstraint.activate([
            pokemonInfoStackView.topAnchor.constraint(equalTo: contentView.topAnchor),
            pokemonInfoStackView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
        ])
        
        
        var locationButtonConfiguration = UIButton.Configuration.filled()
        locationButtonConfiguration.title = "Pokemon location"
        
        let pokemonLocationButton = UIButton(configuration: locationButtonConfiguration)
        pokemonLocationButton.addTarget(self,
                                        action: #selector(locationButtonTapped),
                                        for: .touchUpInside)
        
        pokemonInfoStackView.addArrangedSubview(pokemonLocationButton)
    }
    
    @objc
    private func locationButtonTapped() {
        let locationViewController = PokemonLocationViewController(pokemon: viewModel.pokemon,
                                                                   pokemonImage: pokemonImageView.image)
        
        present(locationViewController, animated: true)
    }
    
}

// MARK: Pokemon Detail Delegate
extension PokemonDetailViewController: PokemonDetailViewModelDelegate {
    func updatePokemonImage(to image: UIImage) {
        pokemonImageView.image = image
    }
}
