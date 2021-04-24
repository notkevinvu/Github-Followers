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
            
            // height has +40 to account for the label;
            // this is so we get a square-ish image view
            let groupSize = NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .absolute(itemWidth + 40))
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
            group.interItemSpacing = .flexible(0)
            
            let section = NSCollectionLayoutSection(group: group)
            section.contentInsets = NSDirectionalEdgeInsets(top: padding, leading: padding, bottom: padding, trailing: padding)
            // seems like 10 is the default inter group spacing for flow layouts
            // determined by comparing content heights vs a similar flow layout
            section.interGroupSpacing = 10
            let layout = UICollectionViewCompositionalLayout(section: section)
            
            return layout
        }
        
        // alternative layout using flow layout (might be simpler lol)
        // compositional layouts would have an advantage in having horizontal
        // scrolling groups with overall vertical scrolling collection view
        static func createThreeColumnFlowLayout(in view: UIView) -> UICollectionViewFlowLayout {
            let width = view.bounds.width
            let padding: CGFloat = 12
            let minimumItemSpacing: CGFloat = 10
            let availableWidth = width - (padding * 2) - (minimumItemSpacing * 2)
            let itemWidth = availableWidth / 3
            
            let flowLayout = UICollectionViewFlowLayout()
            flowLayout.sectionInset = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
            flowLayout.itemSize = CGSize(width: itemWidth, height: itemWidth + 40)
            
            return flowLayout
        }
    }
}


