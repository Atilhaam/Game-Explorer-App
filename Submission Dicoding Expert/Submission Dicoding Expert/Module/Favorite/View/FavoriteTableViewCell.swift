//
//  FavoriteTableViewCell.swift
//  Submission Dicoding Expert
//
//  Created by Ilham Wibowo on 05/11/22.
//

import UIKit

class FavoriteTableViewCell: UITableViewCell {

    static let identifier = "FavoriteTableViewCell"
    
    let imagePoster: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleToFill
        image.layer.cornerRadius = 5
        image.clipsToBounds = true
        return image
    }()
    
    let gameTitle: UILabel = {
        let title = UILabel()
        title.numberOfLines = 2
        title.textAlignment = .left
        return title
    }()
    
    let releaseDateContent : UILabel = {
        let releaseDate = UILabel()
        releaseDate.textAlignment = .left
        return releaseDate
    }()
    
    let ratingContent: UILabel = {
        let score = UILabel()
        score.textAlignment = .left
        return score
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureConstraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureConstraint() {
        addSubview(imagePoster)
        addSubview(gameTitle)
        addSubview(releaseDateContent)
        addSubview(ratingContent)
        imagePoster.translatesAutoresizingMaskIntoConstraints = false
        gameTitle.translatesAutoresizingMaskIntoConstraints = false
        releaseDateContent.translatesAutoresizingMaskIntoConstraints = false
        ratingContent.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            imagePoster.heightAnchor.constraint(equalToConstant: 125),
            imagePoster.widthAnchor.constraint(equalToConstant: 125),
            imagePoster.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            imagePoster.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            gameTitle.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            gameTitle.leadingAnchor.constraint(equalTo: imagePoster.trailingAnchor, constant: 16),
            gameTitle.trailingAnchor.constraint(equalTo: trailingAnchor),
            releaseDateContent.topAnchor.constraint(equalTo: gameTitle.bottomAnchor, constant: 4),
            releaseDateContent.leadingAnchor.constraint(equalTo: imagePoster.trailingAnchor, constant: 16),
            releaseDateContent.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            ratingContent.topAnchor.constraint(equalTo: releaseDateContent.bottomAnchor, constant: 4),
            ratingContent.leadingAnchor.constraint(equalTo: imagePoster.trailingAnchor, constant: 16),
            ratingContent.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
        ])
    }

}
