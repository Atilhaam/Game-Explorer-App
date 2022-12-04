//
//  GameCollectionViewCell.swift
//  Submission Dicoding Expert
//
//  Created by Ilham Wibowo on 23/10/22.
//

import Foundation
import UIKit

class GameCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "GameCollectionViewCell"
    
    let coverImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleToFill
        image.layer.cornerRadius = 5
        image.clipsToBounds = true
        return image
    }()
    
    let gameTitle: UILabel = {
        let title = UILabel()
        title.textColor = .white
        title.textAlignment = .center
        title.numberOfLines = 2
        return title
    }()
    
    let releaseDateContent: UILabel = {
        let releaseDate = UILabel()
        releaseDate.textColor = .white
        releaseDate.textAlignment = .center
        return releaseDate
    }()
    
    let ratingContent: UILabel = {
        let score = UILabel()
        score.textColor = .white
        score.textAlignment = .center
        return score
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .black
        layer.cornerRadius = 5
        configureConstraint()
        clipsToBounds = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureConstraint() {
        addSubview(coverImage)
        addSubview(gameTitle)
        addSubview(releaseDateContent)
        addSubview(ratingContent)
        coverImage.translatesAutoresizingMaskIntoConstraints = false
        gameTitle.translatesAutoresizingMaskIntoConstraints = false
        releaseDateContent.translatesAutoresizingMaskIntoConstraints = false
        ratingContent.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            coverImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            coverImage.heightAnchor.constraint(equalToConstant: contentView.frame.size.height-100),
            coverImage.widthAnchor.constraint(equalToConstant: contentView.frame.size.width-10),
            coverImage.centerXAnchor.constraint(equalTo: centerXAnchor),
            gameTitle.topAnchor.constraint(equalTo: coverImage.bottomAnchor),
            gameTitle.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            gameTitle.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            releaseDateContent.topAnchor.constraint(equalTo: gameTitle.bottomAnchor),
            releaseDateContent.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            releaseDateContent.trailingAnchor.constraint(equalTo: trailingAnchor),
            ratingContent.topAnchor.constraint(equalTo: releaseDateContent.bottomAnchor),
            ratingContent.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            ratingContent.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            ratingContent.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        
        ])
    }
}

