//
//  FollowerListVC.swift
//  Github_Followers
//
//  Created by Kevin Vu on 4/15/21.
//

import UIKit

final class FollowerListVC: UIViewController {
    
    
    // MARK: - Properties
    var username: String!
    
    
    // MARK: - View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
        
        getFollowersOnLoad()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // better functionality with swiping back and forth for navigation
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    
    // MARK: - Network methods
    private func getFollowersOnLoad() {
        // libquic failed error is apparently a simulator error - ignore,
        // it does not affect behavior in any apparent way
        NetworkManager.shared.getFollowers(for: username, page: 1) { [weak self] (followers, error) in
            guard let self = self else { return }
            
            guard let followers = followers else {
                self.presentGFAlertOnMainThread(title: "Bad stuff happened", message: error!.rawValue, buttonTitle: "Ok")
                return
            }
            
            print("Followers.count = \(followers.count)")
            print(followers)
        }
    }
}
