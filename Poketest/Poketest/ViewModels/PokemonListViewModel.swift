//
//  PokemonListViewModel.swift
//  Poketest
//
//  Created by Marcelo Macedo on 15/08/2022.
//

import Foundation

protocol PokemonListViewModelDelegate{
    func didUpdatePokemons()
    func didFailWithError(error: Error)
}

class PokemonListViewModel{
    private var delegate: PokemonListViewModelDelegate?
    
    private var pokemonsList: [Pokemon] = []
    private let paginationSize = 20
    private var startPaginationValue = 0
    private var isFetchInProgress = false
 
    let pokemonManager: PokemonManager
    
    init(pokemonManager: PokemonManager, delegate: PokemonListViewModelDelegate){
        self.pokemonManager = pokemonManager
        self.delegate = delegate
    }
    
    func fetchListPokemons(){
        guard !isFetchInProgress else{
            print("already fetching list")
            return
        }
        guard startPaginationValue > -1  else{
            print("No more items to fetch")
            return
        }

        let urlString = "\(Const.baseURL)/pokemon?offset=\(startPaginationValue)&limit=\(paginationSize)"
        print(urlString)

        isFetchInProgress = true

        pokemonManager.performListRequest(with: urlString){ result in
            switch result{
            case .failure(let error):
                DispatchQueue.main.async {
                    self.isFetchInProgress = false
                    self.delegate?.didFailWithError(error: error)
                }
                
            case .success(let pokemonList):
                DispatchQueue.main.async {
                    self.isFetchInProgress = false
                    self.startPaginationValue = pokemonList.next != nil ? self.startPaginationValue + self.paginationSize : -1
                    for poke in pokemonList.results {
                        if let url = poke?.url{
                            self.fetchPokemon(urlString: url)
                        }
                    }
                }
            }
        }

    }
    
    //function to be called when searching - maybe search & go to details without updating list?
    func fetchPokemon(name: String){
        let urlString = "\(Const.baseURL)/pokemon/\(name)"
        print(urlString)
        fetchPokemon(urlString: urlString)
    }
    
    
    private func fetchPokemon(urlString: String){

        pokemonManager.performDetailsRequest(with: urlString) { result in
            switch result{
            case .failure(let error):
                DispatchQueue.main.async {
                    self.isFetchInProgress = false
                    self.delegate?.didFailWithError(error: error)
                }
                
            case .success(let pokemon):
                DispatchQueue.main.async {
                    self.isFetchInProgress = false
                    print("Name: \(pokemon.name ?? "-")")
                    print("Image url: \(pokemon.sprites?.frontDefault ?? "-")")
                    self.pokemonsList.append(pokemon)
                    if self.pokemonsList.count == self.startPaginationValue{ //only should call when all pokemons downloaded. Should be done by list probably
                        self.sortPokemonListbyID()
                        self.delegate?.didUpdatePokemons()
                    }
                }
            }
        }
    }
    
    func getPokemonList() -> [Pokemon] {
        return pokemonsList
    }
    
    private func sortPokemonListbyID(){
        pokemonsList = pokemonsList.sorted(by: { $0.id < $1.id })
    }
    
    func getIndexPathToFetch() -> IndexPath {
        return IndexPath(row: pokemonsList.count-5, section: 0)
    }
    
}


