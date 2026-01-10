//
//  ViewController.swift
//  github_app
//
//  Created by Yibriam on 10/01/26.
//

import UIKit

class SearchViewController: UIViewController {
    
    let imageLogo = UIImage()
    let usernameTextField = UITextField()
    let getFollowersButton = UIButton(type: .system)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        setupUI()
    }
    
    private func setupUI() {

        let imageLogoView = UIImageView(image: UIImage(named: "githublogo"))
        imageLogoView.contentMode = .scaleAspectFit
        imageLogoView.translatesAutoresizingMaskIntoConstraints = false
        imageLogoView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        imageLogoView.widthAnchor.constraint(equalToConstant: 100).isActive = true

        usernameTextField.placeholder = "Enter GitHub username"
        usernameTextField.borderStyle = .roundedRect
        usernameTextField.addTarget(self, action: #selector(textChanged), for: .editingChanged)

        getFollowersButton.setTitle("Get Followers", for: .normal)
        getFollowersButton.isHidden = true
        getFollowersButton.addTarget(self, action: #selector(getFollowersTapped), for: .touchUpInside)

        let stack = UIStackView(arrangedSubviews: [imageLogoView, usernameTextField, getFollowersButton])
        stack.axis = .vertical
        stack.spacing = 20
        stack.alignment = .center
        stack.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(stack)

        NSLayoutConstraint.activate([
            stack.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stack.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            stack.widthAnchor.constraint(equalToConstant: 300)
        ])
    }

    
    @objc private func textChanged() {
        getFollowersButton.isHidden = usernameTextField.text?.isEmpty ?? true
    }
    
    @objc private func getFollowersTapped() {
        guard let username = usernameTextField.text, !username.isEmpty else { return }
        let followersVC = FollowersViewController(username: username)
        navigationController?.pushViewController(followersVC, animated: true)
    }
}
