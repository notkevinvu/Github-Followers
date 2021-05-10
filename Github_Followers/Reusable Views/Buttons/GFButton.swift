//
//  GFButton.swift
//  Github_Followers
//
//  Created by Kevin Vu on 4/14/21.
//

import UIKit

final class GFButton: UIButton {
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) not implemented")
    }
    
    
    convenience init(backgroundColor: UIColor, title: String) {
        self.init(frame: .zero)
        self.backgroundColor = backgroundColor
        setTitle(title, for: .normal)
    }
    
    
}


// MARK: - Configuration
extension GFButton {
    private func configure() {
        translatesAutoresizingMaskIntoConstraints = false
        
        layer.cornerRadius = 10
        
        titleLabel?.textColor = .white
        // using the preferred font setting to allow for dynamic type
        // accessibility - use Semantic UI from cocoacontrols for testing
        titleLabel?.font = UIFont.preferredFont(forTextStyle: .headline)
    }
    
    
    public func set(backgroundColor: UIColor, title: String) {
        self.backgroundColor = backgroundColor
        setTitle(title, for: .normal)
    }
}
