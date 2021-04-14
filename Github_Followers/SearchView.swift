//
//  SearchView.swift
//  Github_Followers
//
//  Created by Kevin Vu on 4/14/21.
//

import UIKit

final class SearchView: UIView {
    
    
    // MARK: - Properties
    private let logoImageView: UIImageView = {
        let imView = UIImageView(frame: .zero)
        imView.translatesAutoresizingMaskIntoConstraints = false
        imView.image = UIImage(named: "gh-logo")!
        return imView
    }()
    
    private let usernameTextField = GFTextField()
    
    private let getFollowersButton = GFButton(
        backgroundColor: .systemGreen,
        title: "Get followers")
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemBackground
        configureSubviews()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func configureLogoImageViewConstraints() {
        addSubview(logoImageView)
        
        let imageTopAnchor = logoImageView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 80)
        let imageCenterXAnchor = logoImageView.centerXAnchor.constraint(equalTo: centerXAnchor)
        
        let imageHeightAnchor = logoImageView.heightAnchor.constraint(equalToConstant: 200)
        imageHeightAnchor.priority = UILayoutPriority(999)
        let imageWidthAnchor = logoImageView.widthAnchor.constraint(equalToConstant: 200)
        imageWidthAnchor.priority = UILayoutPriority(999)
        
        NSLayoutConstraint.activate([
            imageTopAnchor,
            imageCenterXAnchor,
            imageHeightAnchor,
            imageWidthAnchor
        ])
    }
    
    
    private func configureSubviews() {
        configureLogoImageViewConstraints()
    }
    
}
