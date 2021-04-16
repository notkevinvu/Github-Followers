//
//  GFBodyLabel.swift
//  Github_Followers
//
//  Created by Kevin Vu on 4/16/21.
//

import UIKit

final class GFBodyLabel: UILabel {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    init(textAlignment: NSTextAlignment) {
        super.init(frame: .zero)
        self.textAlignment = textAlignment
        configure()
    }
}


// MARK: - Configure methods
private extension GFBodyLabel {
    func configure() {
        textColor = .secondaryLabel
        font = UIFont.preferredFont(forTextStyle: .body)
        adjustsFontSizeToFitWidth = true
        minimumScaleFactor = 0.75
        // saving configuration of numberOfLines for when we instantiate
        lineBreakMode = .byWordWrapping
        translatesAutoresizingMaskIntoConstraints = false
    }
}
