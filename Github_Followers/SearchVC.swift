//
//  ViewController.swift
//  Github_Followers
//
//  Created by Kevin Vu on 4/13/21.
//

import UIKit

class SearchVC: UIViewController {
    
    // MARK: - Properties
    private var searchView: SearchView!
    
    
    // MARK: - View lifecycle
    override func loadView() {
        setupView()
        self.view = searchView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
    }
    
    
    // MARK: - Setup methods
    private func setupView() {
        let view = SearchView()
        view.delegate = self
        searchView = view
    }

}


// MARK: - Search view delegate
extension SearchVC: SearchViewDelegate {
    func searchView(_ searchView: SearchView, shouldGetFollowersFor username: String) {
        let followerListVC = FollowerListVC()
        followerListVC.username = username
        followerListVC.title = username
        navigationController?.pushViewController(followerListVC, animated: true)
    }
    
    func searchViewShouldPresentErrorAlert(_ searchView: SearchView) {
        presentGFAlertOnMainThread(title: "Empty username", message: "Please enter a username. We need to know who to search for 😀", buttonTitle: "OK")
    }
}

