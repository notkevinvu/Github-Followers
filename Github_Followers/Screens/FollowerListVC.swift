//
//  FollowerListVC.swift
//  Github_Followers
//
//  Created by Kevin Vu on 4/15/21.
//

import UIKit

final class FollowerListVC: UIViewController {
    
    
    // MARK: - Properties
    var username: String!
    
    
    // MARK: - View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // using screen-edge swiping for navigation won't keep
        // suddenly showing and hiding the nav bar, but instead keeps the
        // nav bar constrained to the VC that needs it shown
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
}
