//
//  UserInfoVC.swift
//  Github_Followers
//
//  Created by Kevin Vu on 4/27/21.
//

import UIKit

final class UserInfoVC: UIViewController {
    
    // MARK: - Properties
    var username: String {
        didSet { navigationItem.title = username }
    }
    
    
    // MARK: - UI Properties
    
    
    // MARK: - Init
    init(username: String) {
        self.username = username
        super.init(nibName: nil, bundle: nil)
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        configureNavController()
        
        getUser()
    }
    
}


// MARK: - Configuration
private extension UserInfoVC {
    func configureViewController() {
        view.backgroundColor = .systemBackground
    }
    
    
    func configureNavController() {
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismissVC))
        navigationItem.rightBarButtonItem = doneButton
    }
}


// MARK: - Network methods
private extension UserInfoVC {
    func getUser() {
        NetworkManager.shared.getUser(for: username) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
                case .success(let user):
                    print(user)
                case .failure(let error):
                    self.presentGFAlertOnMainThread(title: "Something went wrong", message: error.rawValue, buttonTitle: "Ok")
            }
        }
    }
}


// MARK: - Utility methods
private extension UserInfoVC {
    @objc func dismissVC() {
        dismiss(animated: true)
    }
}
