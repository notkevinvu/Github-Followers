//
//  GFFollowerItemVC.swift
//  Github_Followers
//
//  Created by Kevin Vu on 5/4/21.
//

import UIKit

final class GFFollowerItemVC: GFItemInfoVC {
    
    // MARK: - View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureItems()
    }
    
}

extension GFFollowerItemVC {
    private func configureItems() {
        itemInfoViewOne.set(itemInfoType: .followers, with: user.followers)
        itemInfoViewTwo.set(itemInfoType: .following, with: user.following)
        actionButton.set(backgroundColor: .systemGreen, title: "Get Followers")
    }
}
