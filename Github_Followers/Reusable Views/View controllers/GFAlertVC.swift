//
//  GFAlertVC.swift
//  Github_Followers
//
//  Created by Kevin Vu on 4/16/21.
//

import UIKit

final class GFAlertVC: UIViewController {
    
    // MARK: - UI Properties
    // add custom class for a reusable container view? i.e. GFAlertContainerView
    private let containerView = GFAlertContainerView()
    private let titleLabel = GFTitleLabel(textAlignment: .center, fontSize: 20)
    private let messageLabel = GFBodyLabel(textAlignment: .center)
    private let actionButton = GFButton(backgroundColor: .systemPink, title: "Ok")
    
    
    // MARK: - Properties
    var alertTitle: String
    var message: String
    var buttonTitle: String
    
    let padding: CGFloat = 20
    
    
    // MARK: - Object lifecycle
    init(title: String, message: String, buttonTitle: String) {
        self.alertTitle = title
        self.message = message
        self.buttonTitle = buttonTitle
        super.init(nibName: nil, bundle: nil)
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // transparent black background
        view.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.75)
        
        configureSubviews()
    }
    
}


// MARK: - Configuration/setup methods
private extension GFAlertVC {
    func configureContainerView() {
        view.addSubview(containerView)
        
        NSLayoutConstraint.activate([
            containerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            containerView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            // reminder that smallest iphone point width is 320, just keep
            // the width smaller with some padding
            containerView.widthAnchor.constraint(equalToConstant: 280),
            // could possibly include height adjustment within GFAlertContainerView
            // to adapt to the amount of content within
            containerView.heightAnchor.constraint(equalToConstant: 220)
        ])
    }
    
    
    func configureTitleLabel() {
        containerView.addSubview(titleLabel)
        titleLabel.text = alertTitle
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: padding),
            titleLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: padding),
            titleLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -padding),
            titleLabel.heightAnchor.constraint(equalToConstant: 28)
        ])
    }
    
    
    func configureActionButton() {
        containerView.addSubview(actionButton)
        actionButton.setTitle(buttonTitle, for: .normal)
        actionButton.addTarget(self, action: #selector(dismissVC), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            actionButton.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -padding),
            actionButton.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: padding),
            actionButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -padding),
            // user interface guideline touch target height minimum is 44
            actionButton.heightAnchor.constraint(equalToConstant: 44)
        ])
    }
    
    
    func configureMessageLabel() {
        containerView.addSubview(messageLabel)
        messageLabel.text = message
        // max of 4 lines; we try to keep error messages short and concise
        messageLabel.numberOfLines = 4
        
        NSLayoutConstraint.activate([
            messageLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            messageLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: padding),
            messageLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -padding),
            messageLabel.bottomAnchor.constraint(equalTo: actionButton.topAnchor, constant: -12)
        ])
    }
    
    
    func configureSubviews() {
        configureContainerView()
        configureTitleLabel()
        // configure button before message so that we can pin message label
        // to bottom of title and top of button
        configureActionButton()
        configureMessageLabel()
    }
}


// MARK: - Utility methods
private extension GFAlertVC {
    @objc func dismissVC() {
        dismiss(animated: true)
    }
}
