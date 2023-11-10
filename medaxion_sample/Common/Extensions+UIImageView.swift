//
//  Extensions+UIImageView.swift
//  medaxion_sample
//
//  Created by Casey West on 11/10/23.
//

import UIKit

let imageCache = NSCache<NSString, UIImage>()

extension UIImageView {
    /**
     - Download an image from a URL and set it to the UIImageView.
     - Parameters:
        - link: String value of the URL for fetching the image.
        - completion: Optional completion handler with a possible error.
     - Returns: URLSessionDataTask which can be used to cancel the download.
     */
    @discardableResult
    func downloadFromServer(link: String, completion: ((Error?) -> Void)? = nil) -> URLSessionDataTask? {
        guard let url = URL(string: link) else {
            completion?(NSError(domain: "Invalid URL", code: -1, userInfo: nil))
            return nil
        }
        
        // Check cache first
        if let cachedImage = imageCache.object(forKey: url.absoluteString as NSString) {
            self.image = cachedImage
            completion?(nil)
            return nil
        } else {
            // Start download
            let task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
                if let error = error {
                    DispatchQueue.main.async {
                        completion?(error)
                    }
                    return
                }
                
                guard let data = data,
                      let mimeType = response?.mimeType,
                      mimeType.hasPrefix("image"),
                      let image = UIImage(data: data) else {
                    DispatchQueue.main.async {
                        completion?(NSError(domain: "Data or MIME type issue", code: -1, userInfo: nil))
                    }
                    return
                }

                imageCache.setObject(image, forKey: url.absoluteString as NSString)

                DispatchQueue.main.async {
                    self?.image = image
                    completion?(nil)
                }
            }
            task.resume()
            return task
        }
    }
}
