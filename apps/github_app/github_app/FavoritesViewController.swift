//
//  FavoritesViewController.swift
//  github_app
//
//  Created by Yibriam on 10/01/26.
//

import UIKit

class FavoritesViewController: UITableViewController {
    
    var favorites: [FavoriteUser] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Favorites"
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        favorites = FavoritesManager.shared.getFavorites()
        tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favorites.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let user = favorites[indexPath.row]
        cell.textLabel?.text = user.login
        
        if let url = URL(string: user.avatar_url) {
            DispatchQueue.global().async {
                if let data = try? Data(contentsOf: url) {
                    DispatchQueue.main.async {
                        cell.imageView?.image = UIImage(data: data)
                        cell.setNeedsLayout()
                    }
                }
            }
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let user = favorites[indexPath.row]
        let followersVC = FollowersViewController(username: user.login)
        navigationController?.pushViewController(followersVC, animated: true)
    }
}

