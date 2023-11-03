//
//  StatsTableViewCell.swift
//  Pokemon
//
//  Created by Emincan Antalyalı on 3.11.2023.
//

import UIKit

final class StatsTableViewCell: UITableViewCell {

    static let identifier = "StatsTableViewCell"
    var stat: Stat? {
        didSet {
            statNameLabel.text = stat?.stat?.name
            if let statBar = stat?.baseStat {
                progressView.setProgress(Float((statBar) / 10) , animated: false)
            }
        }
    }

    private let statNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private var progressView: UIProgressView = {
        let progress = UIProgressView()
        progress.translatesAutoresizingMaskIntoConstraints = false
        progress.setProgress(0.4, animated: false)
        progress.tintColor = .orange
        return progress
    }()

    private let hStackview: UIStackView = {
        let sView = UIStackView()
        sView.translatesAutoresizingMaskIntoConstraints = false
        sView.axis = .horizontal
        sView.distribution = .fillProportionally
        return sView
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func prepareForReuse() {
        stat = nil
    }

    private func setupView() {
        contentView.addSubview(hStackview)
        hStackview.addArrangedSubview(statNameLabel)
        hStackview.addArrangedSubview(progressView)
        self.hStackview.frame = bounds
    }
}
