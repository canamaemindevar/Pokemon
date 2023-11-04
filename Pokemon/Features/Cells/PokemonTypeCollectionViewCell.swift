//
//  PokemonTypeCollectionViewCell.swift
//  Pokemon
//
//  Created by Emincan Antalyalı on 4.11.2023.
//

import UIKit

class PokemonTypeCollectionViewCell: UICollectionViewCell {

    static let identifier = "PokemonTypeCollectionViewCell"

    let typeNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .italicSystemFont(ofSize: 10)
        label.textAlignment = .center
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure() {
        contentView.addSubview(typeNameLabel)
        self.typeNameLabel.frame = bounds
    }
    
}
