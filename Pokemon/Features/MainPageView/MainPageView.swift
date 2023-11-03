//
//  MainPageView.swift
//  Pokemon
//
//  Created by Emincan Antalyalı on 3.11.2023.
//

import UIKit

protocol MainPageViewInterface: AnyObject {
    func prepare()
    func updateData()
    func updateData(on pokemons : Pokemon)
}

private enum ViewMetrics {
    static let bgColor = UIColor.systemBackground

    static let collectionViewBackgroundColor = UIColor.systemBackground
    static let collectionViewEdgeInsets = UIEdgeInsets(top: 12.0, left: 12.0, bottom: 12.0, right: 12.0)
    static let collectionViewMinimumItemSpacing: CGFloat = 10.0
    static let collectionViewExtraVerticalSpace: CGFloat = 30.0
}
enum Section {
    case main
}

final class MainPageView: UIViewController {
    
    private lazy var viewModel = MainPageViewModel(view: self, manager: NetworkManager())

    //MARK: - Components
    var collectionView: UICollectionView!

    var filteredPokemons: [Pokemon] = []
    var dataSource: UICollectionViewDiffableDataSource<Section, Pokemon>!


    //MARK: - Life Cycle

    override func viewDidLoad() {
        viewModel.viewDidLoad()
        super.viewDidLoad()

    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
}

//MARK: - MainPageViewViewInterface

extension MainPageView: MainPageViewInterface {

    func prepare() {
        viewModel.fetchPokemons()
        configureViewController()
        configureCollectionView()
        configureDataSource()
        configureSearchController()
    }
    func configureViewController() {
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    func configureCollectionView() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: UIHelper.createThreeColumnFlowLayout(in: view))
        view.addSubview(collectionView)
        collectionView.backgroundColor = .systemBackground
        collectionView.register(PokeCell.self, forCellWithReuseIdentifier: PokeCell.reuseID)

    }
    func configureDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Section, Pokemon>(collectionView: collectionView, cellProvider: { (collectionView, indexPath, follower) -> UICollectionViewCell? in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PokeCell.reuseID, for: indexPath) as! PokeCell
            cell.set(follower: follower)
            return cell
        })
    }

    func updateData() {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Pokemon>()
        snapshot.appendSections([.main])
        snapshot.appendItems(viewModel.poke)
        DispatchQueue.main.async { self.dataSource.apply(snapshot, animatingDifferences: true) }
    }
    func updateData(on pokemons : Pokemon) {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Pokemon>()
        snapshot.appendSections([.main])
        snapshot.appendItems(viewModel.poke)
        DispatchQueue.main.async { self.dataSource.apply(snapshot, animatingDifferences: true) }
    }

    func configureSearchController() {
        let searchController                                    = UISearchController()
        searchController.searchResultsUpdater                   = self
        searchController.searchBar.placeholder                  = "Search for a username"
        navigationItem.searchController                         = searchController
    }
}
extension MainPageView: UISearchResultsUpdating{

    func updateSearchResults(for searchController: UISearchController) {

        guard let filter = searchController.searchBar.text, !filter.isEmpty else {
            filteredPokemons = viewModel.poke
            if let poke = filteredPokemons.first{
                updateData(on: poke)
            }

            return
        }

        filteredPokemons = viewModel.poke.filter { (pokemon) in
            if let name = pokemon.name?.lowercased() {
                return name.contains(filter.lowercased())
            }
            return false
        }


        if let poke = filteredPokemons.first{
            updateData(on: poke)
        }

    }
}
