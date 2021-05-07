//
//  FavoritesListVC.swift
//  Github_Followers
//
//  Created by Kevin Vu on 4/13/21.
//

import UIKit

final class FavoritesListVC: UIViewController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        PersistenceManager.retrieveFavorites { result in
            switch result {
                case .success(let favorites):
                    print(favorites)
                case .failure(let error):
                    break
            }
        }
    }
    
}
