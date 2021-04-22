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


// MARK: - View controller methods
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
    func createThreeColumnCompositionalLayout() -> UICollectionViewCompositionalLayout {
        let width = view.bounds.width
        let padding: CGFloat = 12
        let minimumItemSpacing: CGFloat = 10
        // width minus 2x the other variables since we have 3 items per column
        let availableWidth = width - (padding * 2) - (minimumItemSpacing * 2)
        let itemWidth = availableWidth / 3
        
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .absolute(itemWidth),
            heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        // height has +40 and +(padding*2) to account for the label and padding;
        // this is so we get a square-ish image view
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .absolute(itemWidth + 40 + (padding * 2)))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        group.contentInsets = NSDirectionalEdgeInsets(top: padding, leading: padding, bottom: padding, trailing: padding)
        group.interItemSpacing = .flexible(0)
        
        let section = NSCollectionLayoutSection(group: group)
        let layout = UICollectionViewCompositionalLayout(section: section)
        
        return layout
    }
    
    
    func configureCollectionView() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createThreeColumnCompositionalLayout())
        collectionView.register(FollowerCell.self, forCellWithReuseIdentifier: FollowerCell.reuseID)
        view.addSubview(collectionView)
        collectionView.backgroundColor = .systemBackground
    }
}
