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
    
    private var followers: [Follower] = []
    private var filteredFollowers: [Follower] = []
    
    
    // MARK: - Init
    init(collectionView: UICollectionView) {
        super.init()
        dataSource = makeDataSource(for: collectionView)
    }
}


// MARK: - Property methods
extension FollowerListDiffableDataSource {
    public func getCurrentFollowers() -> [Follower] {
        return followers
    }
    
    public func updateFollowers(withNewFollowers newFollowers: [Follower]) {
        self.followers.append(contentsOf: newFollowers)
    }
    
    public func getFilteredFollowers() -> [Follower] {
        return filteredFollowers
    }
    
    public func updateFilteredFollowers(withNewFollowers newFollowers: [Follower]) {
        filteredFollowers = newFollowers
    }
    
    public func follower(at index: Int, isFiltered: Bool) -> Follower {
        let followerToReturn = isFiltered ? filteredFollowers[index] : followers[index]
        return followerToReturn
    }
}


// MARK: - Utility methods
extension FollowerListDiffableDataSource {
    /**
     Updates the data source with the specified followers array.
     
     Example use case:
     ```
     dataSource.updateFollowers(withNewFollowers: followers)
     dataSource.updateDataOnMainThread(with: dataSource.getFollowersArray())
     ```
    */
    public func updateDataOnMainThread(with followers: [Follower]) {
        var snapshot = Snapshot()
        snapshot.appendSections([.main])
        snapshot.appendItems(followers)
        DispatchQueue.main.async { self.dataSource.apply(snapshot, animatingDifferences: true) }
    }
    
    public func remove(_ follower: Follower, animate: Bool = true) {
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
