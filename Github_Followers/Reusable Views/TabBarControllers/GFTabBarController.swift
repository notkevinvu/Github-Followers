//
//  GFTabBarController.swift
//  Github_Followers
//
//  Created by Kevin Vu on 5/8/21.
//

import UIKit

final class GFTabBarController: UITabBarController {
    
    // MARK: - View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
}


// MARK: - Factory methods
extension GFTabBarController {
    // creating two similar functions looks cleaner compared to creating a
    // generic function that passes in a type of VC, the title, type of tab bar
    // item, and tag. This is especially evident when we call the functions
    // above in scene(willConnectTo:)
    private func createSearchNC() -> UINavigationController {
        let searchVC = SearchVC()
        searchVC.title = "Search"
        searchVC.tabBarItem = UITabBarItem(tabBarSystemItem: .search, tag: 0)
        
        return UINavigationController(rootViewController: searchVC)
    }
    
    
    private func createFavoritesListNC() -> UINavigationController {
        let favoritesListVC = FavoritesListVC()
        favoritesListVC.title = "Favorites"
        favoritesListVC.tabBarItem = UITabBarItem(tabBarSystemItem: .favorites, tag: 1)
        
        return UINavigationController(rootViewController: favoritesListVC)
    }
    
    
    private func configure() {
        viewControllers = [createSearchNC(), createFavoritesListNC()]
        // app-wide configuration of tab bar
        UITabBar.appearance().tintColor = .systemGreen
    }
}
