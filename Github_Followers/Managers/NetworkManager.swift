//
//  NetworkManager.swift
//  Github_Followers
//
//  Created by Kevin Vu on 4/20/21.
//

import UIKit

final class NetworkManager {
    // MARK: - Properties
    static let shared = NetworkManager()
    // TODO: Maybe utilize URLComponents eventually?
    private let baseURL = "https://api.github.com/"
    private let numberOfFollowersPerPage = 100
    let cache = NSCache<NSString, UIImage>()
    
    // MARK: - Init
    private init() {}
    
}


// MARK: - Public methods
extension NetworkManager {
    
    
    // MARK: - Get followers
    public func getFollowers(for username: String, page: Int, completion: @escaping (Result<[Follower], GFError>) -> Void) {
        let endpoint = baseURL + "users/\(username)/followers?per_page=\(numberOfFollowersPerPage)&page=\(page)"
        _getJSONData(forEndpoint: endpoint, completion: completion)
    }
    
    
    // MARK: - Get user
    public func getUser(for username: String, completion: @escaping (Result<User, GFError>) -> Void) {
        let endpoint = baseURL + "users/\(username)"
        _getJSONData(forEndpoint: endpoint, completion: completion)
    }
    
    
    // MARK: - Download image
    func downloadImage(from urlString: String, completion: @escaping (UIImage?) -> Void) {
        let cacheKey = NSString(string: urlString)
        
        // retrieving image from network manager cache if it exists for faster
        // retrieval compared to re-downloading images if we need to reuse cells
        if let cacheImage = cache.object(forKey: cacheKey) {
            completion(cacheImage)
            return
        }
        
        guard let url = URL(string: urlString) else { completion(nil); return }
        
        // downloading image from url
        let downloadTask = URLSession.shared.dataTask(with: url) { [weak self] (data, response, error) in
            
            guard
                let self = self,
                error == nil,
                let response = response as? HTTPURLResponse,
                response.statusCode == 200,
                let data = data,
                let image = UIImage(data: data)
            else {
                completion(nil)
                return
            }
            
            // once we get the image, add it to the cache for faster local reuse
            self.cache.setObject(image, forKey: cacheKey)
            completion(image)
        }
        
        downloadTask.resume()
    }
}


// MARK: - Generic network request
private extension NetworkManager {
    private func _getJSONData<T: Decodable>(forEndpoint endpoint: String, completion: @escaping (Result<T, GFError>) -> Void) {
        guard let url = URL(string: endpoint) else {
            completion(.failure(.invalidUsername))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard error == nil else {
                completion(.failure(.unableToComplete))
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completion(.failure(.invalidResponse))
                return
            }
            
            guard let data = data else {
                completion(.failure(.invalidData))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                decoder.dateDecodingStrategy = .iso8601
                
                let model = try decoder.decode(T.self, from: data)
                completion(.success(model))
            } catch {
                completion(.failure(.invalidData))
            }
        }
        
        task.resume()
    }
    
}
