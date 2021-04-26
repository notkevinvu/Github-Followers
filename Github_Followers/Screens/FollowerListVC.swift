//
//  FollowerListVC.swift
//  Github_Followers
//
//  Created by Kevin Vu on 4/15/21.
//

import UIKit

final class FollowerListVC: UIViewController {
    
    // MARK: - UI Properties
    private var collectionView: UICollectionView!
    private lazy var dataSource = FollowerListDiffableDataSource(collectionView: collectionView)
    
    // MARK: - Properties
    // set in getFollowersOnLoad()
    var username: String
    var page = 1
    var hasMoreFollowers = true
    
    
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
        configureCollectionView()
        getFollowers(for: username, page: page)
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // better functionality with swiping back and forth for navigation
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
}


// MARK: - VC Config methods
private extension FollowerListVC {
    func configureViewController() {
        view.backgroundColor = .systemBackground
        title = username
        navigationController?.navigationBar.prefersLargeTitles = true
    }
}


// MARK: - Network methods
private extension FollowerListVC {
    // we keep the network call here instead of in the data source to avoid
    // extra completion handlers (i.e. in the data source, if we get a .failure
    // result, we would have to pass the .failure again here in order to
    // present the GFAlert).
    func getFollowers(for username: String, page: Int) {
        
        showLoadingView()
        
        NetworkManager.shared.getFollowers(for: username, page: page) { [weak self] (result) in
            guard let self = self else { return }
            
            // dismiss the loading view in the completion as we have finished
            // the network request/loading
            self.dismissLoadingView()
            
            switch result {
                case .success(let followers):
                    if followers.count < 100 { self.hasMoreFollowers = false }
                    
                    // app crashes if we don't specify main queue here;
                    // the problem is not the updateFollowers method
                    DispatchQueue.main.async {
                        self.dataSource.updateFollowers(withNewFollowers: followers)
                        self.dataSource.updateData()
                    }
                    
                case .failure(let errorMessage):
                    self.presentGFAlertOnMainThread(title: "Bad stuff happened", message: errorMessage.rawValue, buttonTitle: "Ok")
            }
        }
    }
}


// MARK: - Collection/Scroll delegate
extension FollowerListVC: UICollectionViewDelegate {
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        
        // if we have no more followers, just return instead of trying to
        // get more followers
        guard hasMoreFollowers else { return }
        
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        // could use bounds here too, doesn't matter
        let viewHeight = scrollView.frame.height
        
        // calculating if user has scrolled to the end of the view
        if offsetY > contentHeight - viewHeight {
            page += 1
            getFollowers(for: username, page: page)
        }
    }
}


// MARK: - Collection view config
private extension FollowerListVC {
    func configureCollectionView() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: UIHelper.CollectionViewMethods.createThreeColumnCompositionalLayout(in: view))
        collectionView.register(FollowerCell.self, forCellWithReuseIdentifier: FollowerCell.reuseID)
        collectionView.delegate = self
        view.addSubview(collectionView)
        collectionView.backgroundColor = .systemBackground
    }
}
