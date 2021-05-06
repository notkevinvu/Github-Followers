//
//  PersistenceManager.swift
//  Github_Followers
//
//  Created by Kevin Vu on 5/6/21.
//

import Foundation

// using an enum to avoid the possibility of initialization since we're
// basically only using static properties/methods
enum PersistenceManager {
    
    // MARK: - Properties
    static private let defaults = UserDefaults.standard
    
    enum Keys {
        static let favorites = "favorites"
    }
    
    
    // MARK: - Methods
    static func retrieveFavorites(completion: @escaping (Result<[Follower], GFError>) -> Void) {
        guard let favoritesData = defaults.object(forKey: Keys.favorites) as? Data else {
            // no objects at given key, first time accessing so we should have
            // nothing in array
            completion(.success([]))
            return
        }
        
        do {
            let decoder = JSONDecoder()
            let favorites = try decoder.decode([Follower].self, from: favoritesData)
            completion(.success(favorites))
        } catch {
            completion(.failure(.unableToFavorite))
        }
    }
    
    
    static func save(favorites: [Follower]) -> GFError? {
        do {
            let encoder = JSONEncoder()
            let encodedFavorites = try encoder.encode(favorites)
            defaults.setValue(encodedFavorites, forKey: Keys.favorites)
            
            return nil
        } catch {
            return .unableToFavorite
        }
    }
    
}
