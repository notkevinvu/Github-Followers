//
//  GFAvatarImageView.swift
//  Github_Followers
//
//  Created by Kevin Vu on 4/21/21.
//

import UIKit

final class GFAvatarImageView: UIImageView {
    
    // MARK: - Properties
    let placeholderImage = UIImage(named: "avatar-placeholder")!
    
    
    // MARK: - Object lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}


// MARK: - Configuration
private extension GFAvatarImageView {
    func configure() {
        layer.cornerRadius = 10
        clipsToBounds = true
        image = placeholderImage
        translatesAutoresizingMaskIntoConstraints = false
    }
}
