//
//  MainPageViewModel.swift
//  Pokemon
//
//  Created by Emincan Antalyalı on 3.11.2023.
//

import Foundation

protocol MainPageViewModelInterface {
    func viewDidLoad()
}

final class MainPageViewModel: MainPageViewModelInterface {
    
    private weak var view: MainPageViewInterface?
    var manager: (PokemonsFethable & PokemonQueryable)
    var poke: [Pokemon] = []

    init(view: MainPageViewInterface, manager: (PokemonsFethable & PokemonQueryable)) {
        self.view = view
        self.manager = manager
    }
    func viewDidLoad() {
        view?.prepare()
    }

    func fetchPokemons() {
        manager.fetchPokemons { response in
            switch response {
                case .success(let success):
                    if let results = success.results {
                        self.poke = results
                    }
                    self.view?.updateData()
                case .failure(let failure):
                    print(failure)
            }
        }
    }

    func queryPokemon(pokemonName: String) {
        manager.queryPokemon(pokemonName) { response in
            switch response {
                case .success(let success):
                    self.view?.updateData(on: .init(name: success.name, url: success.name))
                case .failure(let failure):
                    print(failure)
            }
        }
    }

   
}
