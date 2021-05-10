//
//  UserInfoVC.swift
//  Github_Followers
//
//  Created by Kevin Vu on 4/27/21.
//

import UIKit

protocol UserInfoVCDelegate: NSObject {
    func didTapGithubProfile(for user: User)
    func didTapGetFollowers(for user: User)
}

final class UserInfoVC: UIViewController {
    
    // MARK: - UI Properties
    let headerView = UIView()
    let itemViewOne = UIView()
    let itemViewTwo = UIView()
    let dateLabel = GFBodyLabel(textAlignment: .center)
    
    
    // MARK: - Properties
    var username: String
    weak var delegate: FollowerListVCDelegate?
    
    
    // MARK: - Init
    init(username: String, delegate: FollowerListVCDelegate) {
        self.username = username
        self.delegate = delegate
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
        let itemViews = [headerView, itemViewOne, itemViewTwo, dateLabel]
        
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
            itemViewTwo.heightAnchor.constraint(equalToConstant: itemHeight),
            
            dateLabel.topAnchor.constraint(equalTo: itemViewTwo.bottomAnchor, constant: padding),
            // textStyle .body is roughly 17 points, so we want slightly bigger
            // source: https://gist.github.com/zacwest/916d31da5d03405809c4
            dateLabel.heightAnchor.constraint(equalToConstant: 18)
        ])
    }
    
    
    func configureUIElements(with user: User) {
        let repoItemVC = GFRepoItemVC(user: user)
        repoItemVC.delegate = self
        
        let followerItemVC = GFFollowerItemVC(user: user)
        followerItemVC.delegate = self
        
        add(childVC: GFUserInfoHeaderVC(user: user), to: headerView)
        add(childVC: repoItemVC, to: itemViewOne)
        add(childVC: followerItemVC, to: itemViewTwo)
        dateLabel.text = "Github user since \(user.createdAt.convertToMonthYearFormat())"
    }
}


// MARK: - Network methods
private extension UserInfoVC {
    func getUser() {
        NetworkManager.shared.getUser(for: username) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
                case .success(let user):
                    DispatchQueue.main.async { self.configureUIElements(with: user) }
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


// MARK: - Delegate methods
extension UserInfoVC: UserInfoVCDelegate {
    
    func didTapGithubProfile(for user: User) {
        guard let url = URL(string: user.htmlUrl) else {
            presentGFAlertOnMainThread(title: "Invalid URL", message: "The URL attached to this user is invalid.", buttonTitle: "Ok")
            return
        }
        presentSafariVC(with: url)
    }
    
    
    func didTapGetFollowers(for user: User) {
        guard user.followers != 0 else {
            presentGFAlertOnMainThread(title: "No followers", message: "This user has no followers. 😔", buttonTitle: "Ok")
            return
        }
        delegate?.didRequestFollowers(for: user.login)
        dismissVC()
    }
    
}
