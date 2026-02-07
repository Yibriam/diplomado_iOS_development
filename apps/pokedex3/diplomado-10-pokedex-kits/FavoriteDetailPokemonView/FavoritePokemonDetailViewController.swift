//
//  FavoritePokemonDetailViewController.swift
//  diplomado-10-pokedex-kits
//
//  Created by Alejandro Mendoza on 24/01/26.
//

import UIKit
import PhotosUI
import Lottie

class FavoritePokemonDetailViewController: UIViewController {
    private var viewModel: FavoriteDetailPokemonViewModel
    private var animation: Int = 0
    
    private lazy var pokemonImageView: UIImageView = {
        let pokemonImage = UIImage(systemName: "cat")
        let pokemonImageView = UIImageView(image: pokemonImage)
        pokemonImageView.translatesAutoresizingMaskIntoConstraints = false
        return pokemonImageView
    }()
    
    init(pokemon: Pokemon) {
        viewModel = FavoriteDetailPokemonViewModel(pokemon: pokemon)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("programmatic viewController")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
    }
    
    private func setupView() {
        view.backgroundColor = .systemBackground
        view.addSubview(pokemonImageView)
        
        var animatePokemonButtonConfiguration = UIButton.Configuration.tinted()
        animatePokemonButtonConfiguration.title = "animate"
        
        let animatePokemonButton = UIButton(configuration: animatePokemonButtonConfiguration)
        animatePokemonButton.translatesAutoresizingMaskIntoConstraints = false
        animatePokemonButton.addTarget(self,
                                       action: #selector(animatePokemonButtonTapped),
                                       for: .touchUpInside)
        
        view.addSubview(animatePokemonButton)
        
        
        var capturePokemonButtonConfiguration = UIButton.Configuration.filled()
        capturePokemonButtonConfiguration.title = "Capture"
        
        let capturePokemonButton = UIButton(configuration: capturePokemonButtonConfiguration)
        capturePokemonButton.translatesAutoresizingMaskIntoConstraints = false
        capturePokemonButton.addTarget(self,
                                       action: #selector(capturePokemonButtonTapped),
                                       for: .touchUpInside)
        
        view.addSubview(capturePokemonButton)
        
        let animationView = LottieAnimationView(name: "jumping_pokeball")
        animationView.translatesAutoresizingMaskIntoConstraints = false
        animationView.contentMode = .scaleAspectFit
        animationView.loopMode = .loop
        animationView.play()
        
        view.addSubview(animationView)
        
        NSLayoutConstraint.activate([
            pokemonImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            pokemonImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: -8),
            
            capturePokemonButton.bottomAnchor.constraint(equalTo: animatePokemonButton.topAnchor, constant: -10),
            capturePokemonButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            animatePokemonButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            animatePokemonButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            
            animationView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            animationView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])
    }
    
    //    @objc
    //    private func capturePokemonButtonTapped() {
    //#if targetEnvironment(simulator)
    //        var photoPickerConfiguration = PHPickerConfiguration()
    //        photoPickerConfiguration.filter = .images
    //        photoPickerConfiguration.selectionLimit = 1
    //
    //        let photoPicker = PHPickerViewController(configuration: photoPickerConfiguration)
    //        photoPicker.delegate = self
    //        present(photoPicker, animated: true)
    //#else
    //        let imagePicker = UIImagePickerController()
    //
    //        imagePicker.sourceType = .camera
    //        imagePicker.delegate = self
    //        present(imagePicker, animated: true)
    //#endif
    //    }
    
    @objc
    private func capturePokemonButtonTapped() {
        let actionSheet = UIAlertController(title: "Select Photo", message: nil, preferredStyle: .actionSheet)
        
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            actionSheet.addAction(UIAlertAction(title: "Camera", style: .default, handler: { [weak self] _ in
                let picker = UIImagePickerController()
                picker.sourceType = .camera
                picker.delegate = self
                self?.present(picker, animated: true)
            }))
        }
        
        actionSheet.addAction(UIAlertAction(title: "Gallery", style: .default, handler: { [weak self] _ in
            guard let self = self else { return }
            let config = self.viewModel.getPHPickerConfiguration()
            let picker = PHPickerViewController(configuration: config)
            picker.delegate = self
            self.present(picker, animated: true)
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        present(actionSheet, animated: true)
    }
    
    @objc
    private func animatePokemonButtonTapped() {
        UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 5) {
            switch self.animation {
            case 0:
                self.pokemonImageView.transform = CGAffineTransform(scaleX: 2, y: 2)
                self.pokemonImageView.alpha = 0.1
            case 1:
                self.pokemonImageView.transform = .identity
                self.pokemonImageView.alpha = 1
            case 2:
                self.pokemonImageView.transform = CGAffineTransform(translationX: 0, y: 100)
                self.pokemonImageView.backgroundColor = .purple
            case 3:
                self.pokemonImageView.transform = .identity
                self.pokemonImageView.backgroundColor = .clear
            case 4:
                self.pokemonImageView.transform = CGAffineTransform(rotationAngle: .pi)
            case 5:
                self.pokemonImageView.transform = .identity
                
            default:
                break
            }
        } completion: { _ in
            self.animation = self.animation >= 5 ? 0 : self.animation + 1
        }
    }
}

extension FavoritePokemonDetailViewController: PHPickerViewControllerDelegate {
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        picker.dismiss(animated: true)
        
        guard let itemProvider = results.first?.itemProvider,
              itemProvider.canLoadObject(ofClass: UIImage.self)
        else { return }
        
        itemProvider.loadObject(ofClass: UIImage.self) { [weak self] image, error in
            guard let image = image as? UIImage, error == nil else { return }
            DispatchQueue.main.async {
                self?.viewModel.handleImageSelection(image)
                self?.pokemonImageView.image = image
            }
        }
    }
}

extension FavoritePokemonDetailViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true)
        if let image = info[.originalImage] as? UIImage {
            viewModel.handleImageSelection(image)
            pokemonImageView.image = image
        }
    }
}
