//
//  NetworkManager.swift
//  Github_Followers
//
//  Created by Kevin Vu on 4/20/21.
//

import Foundation

final class NetworkManager {
    // MARK: - Properties
    static let shared = NetworkManager()
    let baseURL = "https://api.github.com/"
    let numberOfFollowersPerPage = 100
    
    // MARK: - Init
    private init() {}
    
    
    public func getFollowers(for username: String, page: Int, completion: @escaping ([Follower]?, GFError?) -> Void) {
        let endpoint = baseURL + "users/\(username)/followers?per_page=\(numberOfFollowersPerPage)&page=\(page)"
        
        guard let url = URL(string: endpoint) else {
            completion(nil, .invalidUsername)
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard error == nil else {
                completion(nil, .unableToComplete)
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completion(nil, .invalidResponse)
                return
            }
            
            guard let data = data else {
                completion(nil, .invalidData)
                return
            }
            
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let followers = try decoder.decode([Follower].self, from: data)
                completion(followers, nil)
            } catch {
                completion(nil, .invalidData)
            }
        }
        
        task.resume()
    }
}
