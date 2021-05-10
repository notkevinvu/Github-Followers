//
//  GFSecondaryTitleLabel.swift
//  Github_Followers
//
//  Created by Kevin Vu on 5/2/21.
//

import UIKit

// prefer to create an entirely new reusable label specifically for secondary
// titles rather than create one label that is very flexible. This is for
// ease of use (i.e. if we ever need to add a secondary title label, we just
// use this class instead of having to pass in numerous parameters
final class GFSecondaryTitleLabel: UILabel {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    convenience init(fontSize: CGFloat) {
        self.init(frame: .zero)
        font = UIFont.systemFont(ofSize: fontSize, weight: .medium)
    }
}


// MARK: - Configure methods
private extension GFSecondaryTitleLabel {
    func configure() {
        textColor = .secondaryLabel
        adjustsFontSizeToFitWidth = true
        minimumScaleFactor = 0.90
        // saving configuration of numberOfLines for when we instantiate
        lineBreakMode = .byTruncatingTail
        translatesAutoresizingMaskIntoConstraints = false
    }
}
