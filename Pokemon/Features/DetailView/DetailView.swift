//
//  DetailView.swift
//  Pokemon
//
//  Created by Emincan Antalyalı on 3.11.2023.
//

import UIKit

protocol DetailViewInterface: AnyObject {
    func prepare()
}

final class DetailView: UIViewController {
    
    private lazy var viewModel = DetailViewModel(view: self,manager: NetworkManager())

    //MARK: - Components
    private let contentView : UIView = {
        let contentView = UIView()
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.backgroundColor = .white
        contentView.layer.cornerRadius = 10
        return contentView
    }()

    private let pokeName : UILabel = {
        let pokeName = UILabel()
        pokeName.translatesAutoresizingMaskIntoConstraints = false
        pokeName.text = "Bulbasour"
        pokeName.textColor = .white
        pokeName.font = UIFont.boldSystemFont(ofSize: 22)
        return pokeName
    }()

    private let pokeImage : UIImageView = {
        let pokeImage = UIImageView()
        pokeImage.translatesAutoresizingMaskIntoConstraints = false
        pokeImage.image = UIImage(named: "bulbasour")
        return pokeImage
    }()

    private let aboutLabel : UILabel = {
        let aboutLabel = UILabel()
        aboutLabel.translatesAutoresizingMaskIntoConstraints = false
        aboutLabel.textColor = UIColor(named: "bulbasourColor")
        aboutLabel.text = "About"
        aboutLabel.font = UIFont.boldSystemFont(ofSize: 18)
        aboutLabel.textAlignment = .center
        return aboutLabel
    }()

    private let weightLabel : UILabel = {
        let weightLabel = UILabel()
        weightLabel.translatesAutoresizingMaskIntoConstraints = false
        weightLabel.text = "6.9 kg"
        weightLabel.font = UIFont.boldSystemFont(ofSize: 13)
        return weightLabel
    }()

    private let heightLabel : UILabel = {
        let heightLabel = UILabel()
        heightLabel.translatesAutoresizingMaskIntoConstraints = false
        heightLabel.text = "0.7 m"
        heightLabel.font = UIFont.boldSystemFont(ofSize: 13)
        return heightLabel
    }()

    private let movesLabel : UILabel = {
        let movesLabel = UILabel()
        movesLabel.translatesAutoresizingMaskIntoConstraints = false
        movesLabel.text = "Chlorophyll Overgrow"
        movesLabel.font = UIFont.boldSystemFont(ofSize: 13)
        movesLabel.numberOfLines = 2
        return movesLabel
    }()

    private let weightLabelText : UILabel = {
        let weightLabelText = UILabel()
        weightLabelText.translatesAutoresizingMaskIntoConstraints = false
        weightLabelText.text = "Weight"
        weightLabelText.textColor = .gray
        //        weightLabelText.textAlignment = .center
        weightLabelText.font = UIFont.boldSystemFont(ofSize: 11)
        return weightLabelText
    }()

    private let heightLabelText : UILabel = {
        let heightLabelText = UILabel()
        heightLabelText.translatesAutoresizingMaskIntoConstraints = false
        heightLabelText.text = "Height"
        heightLabelText.textColor = .gray
        //        heightLabelText.textAlignment = .center
        heightLabelText.font = UIFont.boldSystemFont(ofSize: 11)
        return heightLabelText
    }()

    private let movesLabelText : UILabel = {
        let movesLabelText = UILabel()
        movesLabelText.translatesAutoresizingMaskIntoConstraints = false
        movesLabelText.text = "Moves"
        movesLabelText.textColor = .gray
        //        movesLabelText.textAlignment = .center
        movesLabelText.font = UIFont.boldSystemFont(ofSize: 11)
        return movesLabelText
    }()

    private let descriptionLabel : UILabel = {
        let descriptionLabel = UILabel()
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.text = "There is a plant seed on its back right from the day this Pokémon is born. The seed slowly grows larger."
        //        descriptionLabel.textAlignment = .center
        descriptionLabel.font = UIFont(name: "Poppins", size: 13)
        descriptionLabel.numberOfLines = 0
        return descriptionLabel
    }()

    private let tableView: UITableView = {
        let tableView = UITableView(frame: .zero,style: .grouped)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .systemBackground
        tableView.separatorColor = .systemGray
        tableView.register(StatsTableViewCell.self, forCellReuseIdentifier: StatsTableViewCell.identifier)
        tableView.layer.cornerRadius = 0

        return tableView
    }()
    //MARK: - Life Cycle

    override func viewDidLoad() {
        viewModel.viewDidLoad()
        super.viewDidLoad()
    }
    
}

//MARK: - DetailViewViewInterface

extension DetailView: DetailViewInterface { 

  func prepare() {

      view.backgroundColor = UIColor(named: "bulbasourColor")
      tableView.dataSource = self
      view.addSubview(contentView)
      view.addSubview(pokeName)
      view.addSubview(pokeImage)
      view.addSubview(aboutLabel)
      view.addSubview(weightLabel)
      view.addSubview(heightLabel)
      view.addSubview(movesLabel)
      view.addSubview(weightLabelText)
      view.addSubview(heightLabelText)
      view.addSubview(movesLabelText)
      view.addSubview(descriptionLabel)
      view.addSubview(tableView)

      NSLayoutConstraint.activate([
        pokeName.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
        pokeName.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
        pokeName.widthAnchor.constraint(equalToConstant: 200),

        pokeImage.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
        pokeImage.topAnchor.constraint(equalTo: pokeName.bottomAnchor, constant: 80),
        pokeImage.bottomAnchor.constraint(equalTo: pokeImage.bottomAnchor),
        pokeImage.widthAnchor.constraint(equalToConstant: 200),
        pokeImage.heightAnchor.constraint(equalToConstant: 200),

        aboutLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
        aboutLabel.topAnchor.constraint(equalTo: pokeImage.bottomAnchor, constant: 70),
        aboutLabel.widthAnchor.constraint(equalToConstant: 100),

        weightLabel.topAnchor.constraint(equalTo: aboutLabel.bottomAnchor, constant: 30),
        weightLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 50),
        weightLabel.widthAnchor.constraint(equalToConstant: 100),

        heightLabel.topAnchor.constraint(equalTo: aboutLabel.bottomAnchor, constant: 30),
        heightLabel.leadingAnchor.constraint(equalTo: weightLabel.trailingAnchor, constant: 30),
        heightLabel.widthAnchor.constraint(equalToConstant: 100),

        movesLabel.topAnchor.constraint(equalTo: aboutLabel.bottomAnchor, constant: 30),
        movesLabel.leadingAnchor.constraint(equalTo: heightLabel.trailingAnchor, constant: 25),
        movesLabel.widthAnchor.constraint(equalToConstant: 100),

        weightLabelText.topAnchor.constraint(equalTo: weightLabel.bottomAnchor, constant: 30),
        weightLabelText.centerXAnchor.constraint(equalTo: weightLabel.centerXAnchor),
        weightLabelText.widthAnchor.constraint(equalToConstant: 100),

        heightLabelText.topAnchor.constraint(equalTo: heightLabel.bottomAnchor, constant: 30),
        heightLabelText.centerXAnchor.constraint(equalTo: heightLabel.centerXAnchor),
        heightLabelText.widthAnchor.constraint(equalToConstant: 100),

        movesLabelText.centerXAnchor.constraint(equalTo: movesLabel.centerXAnchor),
        movesLabelText.widthAnchor.constraint(equalToConstant: 100),
        movesLabelText.bottomAnchor.constraint(equalTo: heightLabelText.bottomAnchor),

        descriptionLabel.topAnchor.constraint(equalTo: weightLabelText.bottomAnchor, constant: 20),
        descriptionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 50),
        descriptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -25),

        contentView.topAnchor.constraint(equalTo: view.topAnchor, constant: 300),
        contentView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
        contentView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
        contentView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),

        tableView.topAnchor.constraint(equalTo: movesLabelText.bottomAnchor,constant: 20),
        tableView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
        contentView.trailingAnchor.constraint(equalTo: tableView.trailingAnchor),
        view.bottomAnchor.constraint(equalTo: tableView.bottomAnchor)
      ])
  }

}

extension DetailView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        10
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: StatsTableViewCell.identifier, for: indexPath)  as? StatsTableViewCell else {
            return UITableViewCell()
        }
        cell.stat = Stat(baseStat: 1, effort: 1, stat: Species(name: "EMincan", url: "sfsad"))
        return cell
    }


}
