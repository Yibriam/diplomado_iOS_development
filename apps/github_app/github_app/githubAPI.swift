//
//  githubAPI.swift
//  github_app
//
//  Created by Yibriam on 10/01/26.
//

import Foundation

enum GitHubError: Error {
    case userNotFound
    case invalidData
    case networkError
    case unknown
}

struct Follower: Decodable {
    let login: String
    let avatar_url: String
}

class GitHubAPI {
    static let shared = GitHubAPI()
    
    func getFollowers(for username: String, completion: @escaping (Result<[Follower], GitHubError>) -> Void) {
        let urlString = "https://api.github.com/users/\(username)/followers"
        guard let url = URL(string: urlString) else {
            completion(.failure(.unknown))
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let _ = error {
                completion(.failure(.networkError))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse else {
                completion(.failure(.unknown))
                return
            }
            
            if httpResponse.statusCode == 404 {
                completion(.failure(.userNotFound))
                return
            }
            
            guard let data = data else {
                completion(.failure(.invalidData))
                return
            }
            
            do {
                let followers = try JSONDecoder().decode([Follower].self, from: data)
                completion(.success(followers))
            } catch {
                completion(.failure(.invalidData))
            }
        }.resume()
    }

}
