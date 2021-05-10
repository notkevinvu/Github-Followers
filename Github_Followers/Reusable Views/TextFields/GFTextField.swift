//
//  GFTextField.swift
//  Github_Followers
//
//  Created by Kevin Vu on 4/14/21.
//

import UIKit

final class GFTextField: UITextField {
    
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}


extension GFTextField {
    // MARK: - Configuration
    private func configure() {
        translatesAutoresizingMaskIntoConstraints = false
        
        layer.cornerRadius = 10
        layer.borderWidth = 2
        // use semantic UI to look and choose these types of colors -
        // system colors also help conform to dark and light mode accessibility
        // options
        layer.borderColor = UIColor.systemGray4.cgColor
        
        // label color automatically adjusts for dark/light mode
        textColor = .label
        tintColor = .label
        textAlignment = .center
        font = UIFont.preferredFont(forTextStyle: .title2)
        // squish font size to keep within text field, but have a minimum font
        // size such that we don't just keep shrinking text
        adjustsFontSizeToFitWidth = true
        minimumFontSize = 12
        
        backgroundColor = .tertiarySystemBackground
        autocorrectionType = .no
        returnKeyType = .go
        clearButtonMode = .whileEditing
        autocapitalizationType = .none
        
        placeholder = "Enter a username"
    }
}
