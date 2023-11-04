//
//  PokeCell.swift
//  Pokemon
//
//  Created by Emincan Antalyalı on 3.11.2023.
//

import SDWebImage
import UIKit

class PokeCell: UICollectionViewCell {

    private enum ViewMetrics {
        static let pokeCellFontSize: CGFloat = 16.0
        static let directionalMargins = NSDirectionalEdgeInsets(top: 8.0, leading: 8.0, bottom: 8.0, trailing: 8.0)
    }

    static let reuseID = "FollowerCell"
    let avatarImageView = GFAvatarImageView(frame: .zero)
    let pokeNameLabel   = pokeTitleLabel(textAlignment: .center, fontSize: 16)


    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func set(follower: Pokemon) {
        pokeNameLabel.text = follower.name
        if let url = follower.url {
            if let id = ImageManager.extractNumberFromURL(url) {
                let imageUrl = ImageManager.createPokemonImageURL(number: id)
                avatarImageView.sd_setImage(with: URL(string: imageUrl))
            }
        }
    }

    private func configure() {
        addSubview(avatarImageView)
        addSubview(pokeNameLabel)


        contentView.directionalLayoutMargins = ViewMetrics.directionalMargins

        NSLayoutConstraint.activate([
            avatarImageView.topAnchor.constraint(equalTo: contentView.layoutMarginsGuide.topAnchor),
            avatarImageView.leadingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leadingAnchor),
            avatarImageView.trailingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.trailingAnchor),
            avatarImageView.heightAnchor.constraint(equalTo: avatarImageView.widthAnchor),

            pokeNameLabel.topAnchor.constraint(greaterThanOrEqualToSystemSpacingBelow: avatarImageView.bottomAnchor, multiplier: 1.0),
            pokeNameLabel.leadingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leadingAnchor),
            pokeNameLabel.trailingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.trailingAnchor),
            pokeNameLabel.bottomAnchor.constraint(equalTo: contentView.layoutMarginsGuide.bottomAnchor),
        ])
    }

//    func extractNumberFromURL(_ urlString: String) -> Int? {
//        guard let url = URL(string: urlString) else {
//            return nil
//        }
//
//        if let lastPathComponent = url.lastPathComponent.components(separatedBy: "/").last {
//            let components = lastPathComponent.components(separatedBy: CharacterSet.decimalDigits.inverted)
//            if let number = components.compactMap({ Int($0) }).first {
//                return number
//            }
//        }
//        return nil
//    }
//
//    func createPokemonImageURL(number: Int) -> String {
//        let paddedNumber = String(format: "%03d", number)
//        let urlString = "https://assets.pokemon.com/assets/cms2/img/pokedex/full/\(paddedNumber).png"
//        return urlString
//    }

}
