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
    
    enum PersistenceActionType {
        case add, remove
    }
    
    
    // MARK: - Methods
    static func updateWith(favorite: Follower, actionType: PersistenceActionType, completion: @escaping (GFError?) -> Void) {
        retrieveFavorites { result in
            // finished retrieving, now analyze result
            switch result {
                case .success(let favorites):
                    // if success, we have an array of favorites
                    var retrievedFavorites = favorites
                    
                    // perform the desired action
                    switch actionType {
                        case .add:
                            guard !retrievedFavorites.contains(favorite) else {
                                completion(.alreadyInFavorites)
                                return
                            }
                            
                            // add specified follower to favorites if they aren't
                            // already present
                            retrievedFavorites.append(favorite)
                        case .remove:
                            // remove favorite from favorites array
                            retrievedFavorites.removeAll { $0.login == favorite.login }
                    }
                    
                    // finished adding/removing, save and pass the result
                    // to the completion handler
                    completion(save(favorites: retrievedFavorites))
                    
                case .failure(let error):
                    completion(error)
            }
        }
    }
    
    
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
