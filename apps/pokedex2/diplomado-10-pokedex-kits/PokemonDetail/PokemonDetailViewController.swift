//
//  PokemonDetailViewController.swift
//  diplomado-10-pokedex-kits
//
//  Created by Alejandro Mendoza on 17/01/26.
//

import UIKit

class PokemonDetailViewController: UIViewController {
    
    private let viewModel: PokemonDetailViewModel
    
    // MARK: - UI Components
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.backgroundColor = .systemBackground
        return scrollView
    }()
    
    private lazy var contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var pokemonImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(systemName: "lizard")
        return imageView
    }()
    
    private lazy var pokemonNumberLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .preferredFont(forTextStyle: .largeTitle)
        label.text = viewModel.pokemonNumber
        return label
    }()
    
    // MARK: - Init
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
    
    // MARK: - Setup UI
    private func setupView() {
        self.view.backgroundColor = .systemBackground
        self.title = viewModel.pokemonName
        
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        let pokemonInfoStackView = UIStackView()
        pokemonInfoStackView.translatesAutoresizingMaskIntoConstraints = false
        pokemonInfoStackView.axis = .vertical
        pokemonInfoStackView.alignment = .center
        pokemonInfoStackView.spacing = 20
        
        contentView.addSubview(pokemonInfoStackView)
        
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
            
            pokemonImageView.widthAnchor.constraint(equalToConstant: 200),
            pokemonImageView.heightAnchor.constraint(equalToConstant: 200),
            
            pokemonInfoStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            pokemonInfoStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            pokemonInfoStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            pokemonInfoStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20)
        ])
        
        pokemonInfoStackView.addArrangedSubview(pokemonImageView)
        pokemonInfoStackView.addArrangedSubview(pokemonNumberLabel)
        
        var locationConfig = UIButton.Configuration.filled()
        locationConfig.title = "Pokemon Location"
        let locationBtn = UIButton(configuration: locationConfig)
        locationBtn.addTarget(self, action: #selector(locationButtonTapped), for: .touchUpInside)
        pokemonInfoStackView.addArrangedSubview(locationBtn)
        
        if let weaknesses = viewModel.pokemon.weaknesses {
            let label = UILabel()
            label.text = "Weaknesses: \(weaknesses.joined(separator: ", "))"
            label.numberOfLines = 0
            label.textAlignment = .center
            pokemonInfoStackView.addArrangedSubview(label)
        }
        
        if let prevEvolutions = viewModel.pokemon.prevEvolution {
            addEvolutionButtons(for: prevEvolutions, title: "Prev: ", to: pokemonInfoStackView)
        }
        
        if let nextEvolutions = viewModel.pokemon.nextEvolution {
            addEvolutionButtons(for: nextEvolutions, title: "Next: ", to: pokemonInfoStackView)
        }
    }

    private func addEvolutionButtons(for evolutions: [Evolution], title: String, to stackView: UIStackView) {
        for evo in evolutions {
            var config = UIButton.Configuration.tinted()
            config.title = evo.name
            config.subtitle = title + evo.num
            
            let button = UIButton(configuration: config)
            button.setTitle(evo.name, for: .normal)
            button.addTarget(self, action: #selector(evolutionTapped(_:)), for: .touchUpInside)
            stackView.addArrangedSubview(button)
        }
    }
    
    // MARK: - Actions
    @objc private func locationButtonTapped() {
        let locationViewController = PokemonLocationViewController(pokemon: viewModel.pokemon,
                                                                   pokemonImage: pokemonImageView.image)
        present(locationViewController, animated: true)
    }
    
    @objc private func evolutionTapped(_ sender: UIButton) {
        guard let name = sender.configuration?.title else { return }
        
        if let evolvedPokemon = viewModel.findPokemon(by: name) {
            let detailVC = PokemonDetailViewController(pokemon: evolvedPokemon)
            navigationController?.pushViewController(detailVC, animated: true)
        } else {
            let alert = UIAlertController(title: "Not Found", message: "Pokemon \(name) not found in the Pokedex.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            present(alert, animated: true)
        }
    }
}

extension PokemonDetailViewController: PokemonDetailViewModelDelegate {
    func updatePokemonImage(to image: UIImage) {
        pokemonImageView.image = image
    }
}
