//
//  FollowerListVC.swift
//  Github_Followers
//
//  Created by Kevin Vu on 4/15/21.
//

import UIKit

final class FollowerListVC: UIViewController {
    
    // MARK: - UI Properties
    private var collectionView: UICollectionView!
    private lazy var dataSource = FollowerListDiffableDataSource(collectionView: collectionView)
    
    // MARK: - Properties
    // set in getFollowersOnLoad()
    var username: String!
    
    
    // MARK: - View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        configureCollectionView()
        getFollowersOnLoad()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // better functionality with swiping back and forth for navigation
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
}


// MARK: - VC Config methods
private extension FollowerListVC {
    func configureViewController() {
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
    }
}


// MARK: - Network methods
private extension FollowerListVC {
    func getFollowersOnLoad() {
        // libquic failed error is apparently a simulator error - ignore,
        // it does not affect behavior in any apparent way
        NetworkManager.shared.getFollowers(for: username, page: 1) { [weak self] (result) in
            guard let self = self else { return }
            
            switch result {
                case .success(let followers):
                    DispatchQueue.main.async {
                        self.dataSource.applySnapshot(forFollowers: followers)
                    }
                case .failure(let errorMessage):
                    self.presentGFAlertOnMainThread(title: "Bad stuff happened", message: errorMessage.rawValue, buttonTitle: "Ok")
            }
        }
    }
}


// MARK: - Collection view config
private extension FollowerListVC {
    func configureCollectionView() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: UIHelper.CollectionViewMethods.createThreeColumnCompositionalLayout(in: view))
        collectionView.register(FollowerCell.self, forCellWithReuseIdentifier: FollowerCell.reuseID)
        view.addSubview(collectionView)
        collectionView.backgroundColor = .systemBackground
    }
}
