//
//  GFRepoItemVC.swift
//  Github_Followers
//
//  Created by Kevin Vu on 5/4/21.
//

import UIKit

final class GFRepoItemVC: GFItemInfoVC {
    
    // MARK: - View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureItems()
    }
    
}

extension GFRepoItemVC {
    private func configureItems() {
        itemInfoViewOne.set(itemInfoType: .repos, with: user.publicRepos)
        itemInfoViewTwo.set(itemInfoType: .gists, with: user.publicGists)
        actionButton.set(backgroundColor: .systemPurple, title: "Github Profile")
    }
}
