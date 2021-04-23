//
//  UIHelper.swift
//  Github_Followers
//
//  Created by Kevin Vu on 4/22/21.
//

import UIKit

enum UIHelper {
    enum CollectionViewMethods {
        static func createThreeColumnCompositionalLayout(in view: UIView) -> UICollectionViewCompositionalLayout {
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
    }
}


