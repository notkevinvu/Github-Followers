//
//  FavoritesListVC.swift
//  Github_Followers
//
//  Created by Kevin Vu on 4/13/21.
//

import UIKit

final class FavoritesListVC: UIViewController {
    
    // MARK: - UI Properties
    private let tableView = UITableView()
    
    
    // MARK: - Properties
    private var favorites = [Follower]()
    
    
    // MARK: - View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        configureTableView()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getFavorites()
    }
}


// MARK: - Utility methods
extension FavoritesListVC {
    private func configureViewController() {
        view.backgroundColor = .systemBackground
        title = "Favorites"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    
    // MARK: - Table view config
    private func configureTableView() {
        view.addSubview(tableView)
        
        tableView.frame = view.bounds
        tableView.rowHeight = 80
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(FavoriteCell.self, forCellReuseIdentifier: FavoriteCell.reuseID)
    }
    
    
    // MARK: - Get favorites network call
    private func getFavorites() {
        PersistenceManager.retrieveFavorites { [weak self] result in
            guard let self = self else { return }
            switch result {
                case .success(let favorites):

                    guard !favorites.isEmpty else {
                        DispatchQueue.main.async {
                            self.showEmptyStateView(with: "No favorites?\nGo add some on the followers screen!", in: self.view)
                        }
                        return
                    }
                    
                    self.favorites = favorites
                    
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                        // below accounts for edge case where empty state view
                        // shows despite guard statement
                        self.view.bringSubviewToFront(self.tableView)
                    }
                    
                case .failure(let error):
                    self.presentGFAlertOnMainThread(title: "Something went wrong", message: error.rawValue, buttonTitle: "Ok")
            }
        }
    }
    
}


// keep table view methods here since it's simple at the moment and will be
// for the foreseeable future
extension FavoritesListVC: UITableViewDelegate, UITableViewDataSource {
    // MARK: - Table view data
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favorites.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FavoriteCell.reuseID, for: indexPath) as! FavoriteCell
        let favorite = favorites[indexPath.row]
        cell.set(favorite: favorite)
        
        return cell
    }
    
    
    // MARK: - Table view delegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let favorite = favorites[indexPath.row]
        let destVC = FollowerListVC(username: favorite.login)
        
        navigationController?.pushViewController(destVC, animated: true)
    }
    
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        guard editingStyle == .delete else { return }
        
        let favorite = favorites[indexPath.row]
        
        PersistenceManager.updateWith(favorite: favorite, actionType: .remove) { [weak self] error in
            guard let self = self else { return }
            
            guard error == nil else {
                self.presentGFAlertOnMainThread(title: "Unable to remove", message: error!.rawValue, buttonTitle: "Ok")
                return
            }
            
            // remove from local data sources if error is nil
            self.favorites.remove(at: indexPath.row)
            DispatchQueue.main.async {
                tableView.deleteRows(at: [indexPath], with: .left)
            }
        }
    }
    
}
