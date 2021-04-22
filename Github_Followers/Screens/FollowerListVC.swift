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
                    print("Followers.count = \(followers.count)")
                    print(followers)
                    
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
        let insets: CGFloat = 10
        item.contentInsets = NSDirectionalEdgeInsets(top: insets, leading: insets, bottom: 0, trailing: insets)
        
        // height is the width + 40 so we get a more rectangular item. This is
        // because we have both the imageView and the name label, so if we
        // want a roughly square image view, we need extra space for the label
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .absolute(itemWidth + 40))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        let layout = UICollectionViewCompositionalLayout(section: section)
        
        return layout
    }
    
    
    func configureCollectionView() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createThreeColumnCompositionalLayout())
        collectionView.register(FollowerCell.self, forCellWithReuseIdentifier: FollowerCell.reuseID)
        view.addSubview(collectionView)
        collectionView.backgroundColor = .systemPink
    }
}
