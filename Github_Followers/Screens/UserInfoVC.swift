//
//  UserInfoVC.swift
//  Github_Followers
//
//  Created by Kevin Vu on 4/27/21.
//

import UIKit

final class UserInfoVC: UIViewController {
    
    // MARK: - Properties
    var follower: Follower
    
    
    // MARK: - UI Properties
    
    
    // MARK: - Init
    init(follower: Follower) {
        self.follower = follower
        super.init(nibName: nil, bundle: nil)
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
    }
    
}


private extension UserInfoVC {
    func configureViewController() {
        view.backgroundColor = .systemBackground
    }
}
