//
//  HomeCollectionViewCell.swift
//  medaxion_sample
//
//  Created by Casey West on 11/9/23.
//

import UIKit

class HomeCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var characterImage: UIImageView!
    @IBOutlet weak var characterName: UILabel!
    
    var gradientLayer = CAGradientLayer()

    private var imageDownloadTask: URLSessionDataTask?

    /**
    - Use didSet to respond to a change in character so when we assign values in controller it is a simple implementation
    */
    var character: MarvelCharacter? {
        didSet {
            setupCharacterInfo()
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        setupGradientLayer()        
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        characterName.text = ""
        characterImage.image = UIImage()
        
        gradientLayer.removeFromSuperlayer() // This is important to prevent layering multiple gradients
        imageDownloadTask?.cancel()

    }
    
    // Call this method in both layoutSubviews and configure, to ensure the gradient is always set up correctly
    private func setupGradientLayer() {
        gradientLayer.frame = bounds
        gradientLayer.colors = [UIColor.clear.cgColor, UIColor.black.withAlphaComponent(0.8).cgColor]
        gradientLayer.locations = [0.5, 1.0]
        characterImage.layer.insertSublayer(gradientLayer, at: 0)
    }

    func setupCharacterInfo() {
        
        characterName.text = character?.name ?? ""
        
        var imageUrl = ""
        imageUrl = character?.thumbnail?.path ?? ""
        imageUrl.append(".")
        imageUrl.append(character?.thumbnail?.ext ?? "")
        
        // Cancel any ongoing download task
        imageDownloadTask?.cancel()
        
        // Use UIImageView extension to set character image based on imageUrl created above
        imageDownloadTask = characterImage.downloadFromServer(link: imageUrl) { error in
            if let error = error {
                print("Error downloading image: \(error.localizedDescription)")
                // Handle the error, e.g., set a placeholder image
            }
        }
    }
    
}

