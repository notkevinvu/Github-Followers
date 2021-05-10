//
//  SearchView.swift
//  Github_Followers
//
//  Created by Kevin Vu on 4/14/21.
//

import UIKit

protocol SearchViewDelegate: AnyObject {
    func searchView(_ searchView: SearchView, didSubmitSearchFor username: String)
    // maybe add a parameter that allows us to specify a specific error
    // via an enum (i.e. .emptyUsername, .networkError, etc)
    func searchViewDidReceiveError(_ searchView: SearchView)
}

final class SearchView: UIView {
    
    // MARK: - Delegate
    weak var delegate: SearchViewDelegate?
    
    
    // MARK: - UI Properties
    private let logoImageView: UIImageView = {
        let imView = UIImageView(frame: .zero)
        imView.translatesAutoresizingMaskIntoConstraints = false
        imView.image = UIImage(named: Images.ghLogo)!
        return imView
    }()
    
    private let usernameTextField = GFTextField()
    
    private let getFollowersButton = GFButton(
        backgroundColor: .systemGreen,
        title: "Get followers"
    )
    
    
    // MARK: - Object lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemBackground
        configureSubviews()
        createDismissKeyboardTapGesture()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}


extension SearchView {
    // MARK: - Subview methods
    private func configureLogoImageView() {
        addSubview(logoImageView)
        
        let topConstraintConstant: CGFloat = DeviceTypes.isiPhoneSE || DeviceTypes.isiPhone8Zoomed ? 20 : 80
        
        let imageTopAnchor = logoImageView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: topConstraintConstant)
        let imageCenterXAnchor = logoImageView.centerXAnchor.constraint(equalTo: centerXAnchor)
        
        let imageHeightAnchor = logoImageView.heightAnchor.constraint(equalToConstant: 200)
        imageHeightAnchor.priority = UILayoutPriority(999)
        let imageWidthAnchor = logoImageView.widthAnchor.constraint(equalToConstant: 200)
        imageWidthAnchor.priority = UILayoutPriority(999)
        
        NSLayoutConstraint.activate([
            imageTopAnchor,
            imageCenterXAnchor,
            imageHeightAnchor,
            imageWidthAnchor
        ])
    }
    
    
    private func configureUsernameTextField() {
        addSubview(usernameTextField)
        usernameTextField.delegate = self
        
        let tfTopAnchor = usernameTextField.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 48)
        let tfLeadingAnchor = usernameTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 50)
        
        // user interface guideline recommends any button/touch target should
        // be at least 44 pts tall
        let tfHeightAnchor = usernameTextField.heightAnchor.constraint(equalToConstant: 50)
        tfHeightAnchor.priority = UILayoutPriority(999)
        let tfTrailingAnchor = usernameTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -50)
        tfTrailingAnchor.priority = UILayoutPriority(999)
        
        NSLayoutConstraint.activate([
            tfTopAnchor,
            tfLeadingAnchor,
            tfHeightAnchor,
            tfTrailingAnchor
        ])
    }
    
    
    private func configureGetFollowersButton() {
        addSubview(getFollowersButton)
        getFollowersButton.addTarget(self, action: #selector(pushFollowerListVC), for: .touchUpInside)
        
        // pinning to bottom, while specifying height
        let btnBottomAnchor = getFollowersButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -50)
        let btnLeadingAnchor = getFollowersButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 50)
        
        let btnTrailingAnchor = getFollowersButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -50)
        btnTrailingAnchor.priority = UILayoutPriority(999)
        let btnHeightAnchor = getFollowersButton.heightAnchor.constraint(equalToConstant: 50)
        btnHeightAnchor.priority = UILayoutPriority(999)
        
        NSLayoutConstraint.activate([
            btnBottomAnchor,
            btnLeadingAnchor,
            btnTrailingAnchor,
            btnHeightAnchor
        ])
    }
    
    
    private func configureSubviews() {
        configureLogoImageView()
        configureUsernameTextField()
        configureGetFollowersButton()
    }
    
    
    // MARK: - Utility methods
    private func createDismissKeyboardTapGesture() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(endEditing(_:)))
        addGestureRecognizer(tap)
    }
    
    
    public func clearTextField() {
        usernameTextField.text = ""
    }
    
    
    // MARK: - Navigation method
    @objc private func pushFollowerListVC() {
        guard
            let username = usernameTextField.text,
            !username.trimmingCharacters(in: .whitespaces).isEmpty
        else {
            delegate?.searchViewDidReceiveError(self)
            return
        }
        delegate?.searchView(self, didSubmitSearchFor: username)
    }
}


// MARK: - Text field delegate
extension SearchView: UITextFieldDelegate {
    // passing data and dismissing keyboard after pressing return/go
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        pushFollowerListVC()
        textField.resignFirstResponder()
        return true
    }
}
