//
//  GFAvatarImageView.swift
//  Github_Followers
//
//  Created by Kevin Vu on 4/21/21.
//

import UIKit

final class GFAvatarImageView: UIImageView {
    
    // MARK: - Properties
    let placeholderImage = UIImage(named: "avatar-placeholder")!
    
    
    // MARK: - Object lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}


// MARK: - Configuration
private extension GFAvatarImageView {
    func configure() {
        layer.cornerRadius = 10
        clipsToBounds = true
        image = placeholderImage
        translatesAutoresizingMaskIntoConstraints = false
    }
}


// MARK: - Utility methods
extension GFAvatarImageView {
    func downloadImage(from urlString: String) {
        guard let url = URL(string: urlString) else { return }
        
        let downloadTask = URLSession.shared.dataTask(with: url) { [weak self] (data, response, error) in
            
            guard let self = self else { return }
            
            guard
                error == nil,
                let response = response as? HTTPURLResponse,
                response.statusCode == 200,
                let data = data,
                let image = UIImage(data: data)
            else { return }
            
            DispatchQueue.main.async {
                self.image = image
            }
        }
        
        downloadTask.resume()
    }
}
