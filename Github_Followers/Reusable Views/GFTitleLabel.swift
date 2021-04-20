//
//  GFTitleLabel.swift
//  Github_Followers
//
//  Created by Kevin Vu on 4/16/21.
//

import UIKit

final class GFTitleLabel: UILabel {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // specifying a font size rather than using preferred font since we should
    // always have our titles big and bold (no worry about it being too small
    // for accessibility issues)
    init(textAlignment: NSTextAlignment, fontSize: CGFloat) {
        super.init(frame: .zero)
        self.textAlignment = textAlignment
        self.font = UIFont.systemFont(ofSize: fontSize, weight: .bold)
        configure()
    }
}


// MARK: - Configure methods
private extension GFTitleLabel {
    func configure() {
        textColor = .label
        adjustsFontSizeToFitWidth = true
        // shrink to 90% of its original size at minimum (i.e. can't go below 90%)
        minimumScaleFactor = 0.9
        // we want one line titles, so we just cut off the end after hitting
        // the 90% scale factor
        lineBreakMode = .byTruncatingTail
        translatesAutoresizingMaskIntoConstraints = false
    }
}
