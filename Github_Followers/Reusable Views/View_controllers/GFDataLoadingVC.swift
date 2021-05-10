//
//  GFDataLoadingVC.swift
//  Github_Followers
//
//  Created by Kevin Vu on 5/10/21.
//

import UIKit

class GFDataLoadingVC: UIViewController {
    
    // MARK: - Properties
    var containerView: UIView!
    
}


extension GFDataLoadingVC {
    // MARK: - Show loading view
    /**
     Presents and animates a full screen loading animation via `UIActivityIndicatorView`. This view
     has a partially transparent background
     */
    func showLoadingView() {
        containerView = UIView(frame: view.bounds)
        view.addSubview(containerView)
        
        containerView.backgroundColor = .systemBackground
        // start from invis, animate to the partial transparency
        containerView.alpha = 0
        UIView.animate(withDuration: 0.25) { self.containerView.alpha = 0.8 }
        
        let activityIndicator = UIActivityIndicatorView(style: .large)
        containerView.addSubview(activityIndicator)
        
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        
        activityIndicator.startAnimating()
    }
    
    
    // MARK: - Dismiss loading view
    func dismissLoadingView() {
        DispatchQueue.main.async {
            self.containerView.removeFromSuperview()
            self.containerView = nil
        }
    }
    
    
    // MARK: - Show empty state view
    func showEmptyStateView(with message: String, in view: UIView) {
        let emptyStateView = GFEmptyStateView(message: message)
        emptyStateView.frame = view.bounds
        view.addSubview(emptyStateView)
    }
}
