//
//  GFAvatarImageView.swift
//  Github_Followers
//
//  Created by Kevin Vu on 4/21/21.
//

import UIKit

final class GFAvatarImageView: UIImageView {
    
    // MARK: - Properties
    let cache = NetworkManager.shared.cache
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
        
        let cacheKey = NSString(string: urlString)
        
        // retrieving image from network manager cache if it exists for faster
        // retrieval compared to re-downloading images if we need to reuse cells
        if let cacheImage = cache.object(forKey: cacheKey) {
            self.image = cacheImage
            return
        }
        
        guard let url = URL(string: urlString) else { return }
        
        // downloading image from url
        let downloadTask = URLSession.shared.dataTask(with: url) { [weak self] (data, response, error) in
            
            guard let self = self else { return }
            
            guard
                error == nil,
                let response = response as? HTTPURLResponse,
                response.statusCode == 200,
                let data = data,
                let image = UIImage(data: data)
            else { return }
            
            // once we get the image, add it to the cache for faster local reuse
            self.cache.setObject(image, forKey: cacheKey)
            
            DispatchQueue.main.async {
                self.image = image
            }
        }
        
        downloadTask.resume()
    }
}
