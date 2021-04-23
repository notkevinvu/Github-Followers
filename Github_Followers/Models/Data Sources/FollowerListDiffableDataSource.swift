//
//  FollowerListDiffableDataSource.swift
//  Github_Followers
//
//  Created by Kevin Vu on 4/22/21.
//

import UIKit

final class FollowerListDiffableDataSource: NSObject {
    
    // MARK: - Properties
    typealias DataSource = UICollectionViewDiffableDataSource<Section, Follower>
    var dataSource: DataSource!
    
    typealias Snapshot = NSDiffableDataSourceSnapshot<Section, Follower>
    
    
    // MARK: - Init
    init(collectionView: UICollectionView) {
        super.init()
        dataSource = makeDataSource(for: collectionView)
    }
}


// MARK: - Utility methods
extension FollowerListDiffableDataSource {
    func applySnapshot(forFollowers followers: [Follower]) {
        var snapshot = Snapshot()
        snapshot.appendSections([.main])
        snapshot.appendItems(followers)
        
        dataSource.apply(snapshot)
    }
    
    func remove(_ follower: Follower, animate: Bool = true) {
        var snapshot = dataSource.snapshot()
        snapshot.deleteItems([follower])
        dataSource.apply(snapshot, animatingDifferences: animate)
    }
}


// MARK: - Setup methods
private extension FollowerListDiffableDataSource {
    func makeDataSource(for collectionView: UICollectionView) -> DataSource {
        return DataSource(collectionView: collectionView) { (collectionView, indexPath, follower) -> UICollectionViewCell? in
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FollowerCell.reuseID, for: indexPath) as? FollowerCell
            cell?.set(follower: follower)
            
            return cell
        }
    }
}


// MARK: - Sections
extension FollowerListDiffableDataSource {
    enum Section { case main }
}
