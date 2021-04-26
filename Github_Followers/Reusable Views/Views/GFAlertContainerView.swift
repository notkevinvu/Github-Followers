//
//  GFAlertContainerView.swift
//  Github_Followers
//
//  Created by Kevin Vu on 4/16/21.
//

import UIKit

final class GFAlertContainerView: UIView {
    
    // MARK: - Object lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}


// MARK: - Setup methods
private extension GFAlertContainerView {
    func configure() {
        backgroundColor = .systemBackground
        layer.cornerRadius = 16
        // white border will provide a visual separation when the app is in
        // dark mode, as the container view and the underlying view will
        // likely be the same color
        layer.borderWidth = 2
        layer.borderColor = UIColor.white.cgColor
        
        translatesAutoresizingMaskIntoConstraints = false
    }
}
