//
//  UserInfoVC.swift
//  Github_Followers
//
//  Created by Kevin Vu on 4/27/21.
//

import UIKit

final class UserInfoVC: UIViewController {
    
    // MARK: - UI Properties
    let headerView = UIView()
    let itemViewOne = UIView()
    let itemViewTwo = UIView()
    
    
    // MARK: - Properties
    var username: String
    
    
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
        
        layoutUI()
        
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


// MARK: - UI Config
extension UserInfoVC {
    private func add(childVC: UIViewController, to containerView: UIView) {
        addChild(childVC)
        containerView.addSubview(childVC.view)
        childVC.view.frame = containerView.bounds
        childVC.didMove(toParent: self)
    }
    
    private func layoutUI() {
        let itemViews = [headerView, itemViewOne, itemViewTwo]
        
        let padding: CGFloat = 20
        let itemHeight: CGFloat = 140
        
        for itemView in itemViews {
            view.addSubview(itemView)
            itemView.translatesAutoresizingMaskIntoConstraints = false

            NSLayoutConstraint.activate([
                itemView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
                itemView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding)
            ])
        }
        
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            headerView.heightAnchor.constraint(equalToConstant: 180),
            
            itemViewOne.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: padding),
            itemViewOne.heightAnchor.constraint(equalToConstant: itemHeight),
            
            itemViewTwo.topAnchor.constraint(equalTo: itemViewOne.bottomAnchor, constant: padding),
            itemViewTwo.heightAnchor.constraint(equalToConstant: itemHeight)
        ])
    }
}


// MARK: - Network methods
private extension UserInfoVC {
    func getUser() {
        NetworkManager.shared.getUser(for: username) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
                case .success(let user):
                    DispatchQueue.main.async {
                        self.add(childVC: GFUserInfoHeaderVC(user: user), to: self.headerView)
                        self.add(childVC: GFRepoItemVC(user: user), to: self.itemViewOne)
                        self.add(childVC: GFFollowerItemVC(user: user), to: self.itemViewTwo)
                    }
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
