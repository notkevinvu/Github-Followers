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
        searchView.clearTextField()
        navigationController?.setNavigationBarHidden(true, animated: true)
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
    func searchView(_ searchView: SearchView, didSubmitSearchFor username: String) {
        let followerListVC = FollowerListVC(username: username)
        followerListVC.title = username
        navigationController?.pushViewController(followerListVC, animated: true)
    }
    
    func searchViewDidReceiveError(_ searchView: SearchView) {
        presentGFAlertOnMainThread(title: "Empty username", message: "Please enter a username. We need to know who to search for 😀", buttonTitle: "OK")
    }
}

