//
//  AuthenticationViewController.swift
//  diaryApp
//
//  Created by Yibriam on 30/01/26.
//

import UIKit

class AuthenticationViewController: UIViewController {
    private let viewModel = AuthenticationViewModel()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Welcome to My Diary 📔"
        label.font = UIFont.boldSystemFont(ofSize: 24)
        label.textAlignment = .center
        return label
    }()

    private let authButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Authenticate", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        button.backgroundColor = .systemBlue
        button.tintColor = .white
        button.layer.cornerRadius = 8
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground

        view.addSubview(titleLabel)
        view.addSubview(authButton)

        authButton.addTarget(self, action: #selector(authenticate), for: .touchUpInside)

        setupConstraints()
        setupNotifications()
    }

    private func setupConstraints() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -40),

            authButton.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            authButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            authButton.widthAnchor.constraint(equalToConstant: 160),
            authButton.heightAnchor.constraint(equalToConstant: 44)
        ])
    }

    private func setupNotifications() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(lockApp),
            name: UIApplication.willResignActiveNotification,
            object: nil
        )

        NotificationCenter.default.addObserver(
            self,
            selector: #selector(unlockApp),
            name: UIApplication.didBecomeActiveNotification,
            object: nil
        )
    }

    @objc private func authenticate() {
        viewModel.authenticate { success in
            if success {
                let listVC = DiaryListTableViewController()
                let nav = UINavigationController(rootViewController: listVC)

                if let sceneDelegate = UIApplication.shared.connectedScenes
                    .first?.delegate as? SceneDelegate,
                   let window = sceneDelegate.window {
                    window.rootViewController = nav
                }
            }
        }
    }

    @objc private func lockApp() {
        if let sceneDelegate = UIApplication.shared.connectedScenes
            .first?.delegate as? SceneDelegate,
           let window = sceneDelegate.window {
            window.rootViewController = UINavigationController(rootViewController: AuthenticationViewController())
        }
    }

    @objc private func unlockApp() {
        authenticate()
    }
}
