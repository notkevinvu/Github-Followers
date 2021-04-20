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
    
    
    init(backgroundColor: UIColor, title: String) {
        super.init(frame: .zero)
        self.backgroundColor = backgroundColor
        setTitle(title, for: .normal)
        configure()
    }
    
    
    private func configure() {
        translatesAutoresizingMaskIntoConstraints = false
        
        layer.cornerRadius = 10
        
        titleLabel?.textColor = .white
        // using the preferred font setting to allow for dynamic type
        // accessibility - use Semantic UI from cocoacontrols for testing
        titleLabel?.font = UIFont.preferredFont(forTextStyle: .headline)
    }
    
}
