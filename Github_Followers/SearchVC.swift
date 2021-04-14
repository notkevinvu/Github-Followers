//
//  ViewController.swift
//  Github_Followers
//
//  Created by Kevin Vu on 4/13/21.
//

import UIKit

class SearchVC: UIViewController {
    
    // MARK: - Properties
    private let searchView = SearchView()
    
    
    // MARK: - View lifecycle
    override func loadView() {
        super.loadView()
        self.view = searchView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
    }


}

