//
//  FollowerListViewController.swift
//  github_app
//
//  Created by Yibriam on 10/01/26.
//

import UIKit

class FollowersViewController: UIViewController, UICollectionViewDataSource {
    
    let username: String
    var followers: [Follower] = []
    var collectionView: UICollectionView!
    
    init(username: String) {
        self.username = username
        super.init(nibName: nil, bundle: nil)
        title = username
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        setupFavoriteButton()
        fetchFollowers()
    }

    private func setupFavoriteButton() {
        let favoriteButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addToFavorites))
        navigationItem.rightBarButtonItem = favoriteButton
    }

    @objc private func addToFavorites() {
        let favorite = FavoriteUser(login: username, avatar_url: "https://github.com/\(username).png")
        FavoritesManager.shared.addFavorite(favorite)
        
        let alert = UIAlertController(title: "Added to Favorites", message: "\(username) has been saved.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }

    
    private func setupCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 100, height: 120)
        
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.register(FollowerCell.self, forCellWithReuseIdentifier: "FollowerCell")
        
        view.addSubview(collectionView)
    }
    
    private func fetchFollowers() {
        GitHubAPI.shared.getFollowers(for: username) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let followers):
                    self?.followers = followers
                    self?.collectionView.reloadData()
                case .failure(let error):
                    self?.showError(error)
                }
            }
        }
    }

    private func showError(_ error: GitHubError) {
        var message = ""
        switch error {
        case .userNotFound:
            message = "User not found. Verify name entered."
        case .invalidData:
            message = "Error proccessing data information."
        case .networkError:
            message = "Internet conection error. Try again."
        case .unknown:
            message = "Unexpected error."
        }
        
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }

    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return followers.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FollowerCell", for: indexPath) as! FollowerCell
        cell.configure(with: followers[indexPath.item])
        return cell
    }
}
