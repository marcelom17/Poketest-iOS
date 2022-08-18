//
//  PokemonListViewModel.swift
//  Poketest
//
//  Created by Marcelo Macedo on 15/08/2022.
//

import Foundation

protocol PokemonListViewModelDelegate{
    func didUpdatePokemon(_ pokemonManager: PokemonManager, pokemon: Pokemon)
    func didFailWithError(error: Error)
    func didFetchList(pokemonList: PokemonList, startPosition: Int)
}

final class PokemonListViewModel{
    private var delegate: PokemonListViewModelDelegate?
    
    private var pokemonsList: [PokemonList] = []
    private let paginationSize = 20
    private var startPaginationValue = 0
    private var isFetchInProgress = false
 
    let pokemonManager: PokemonManager
    
    init(pokemonManager: PokemonManager, delegate: PokemonListViewModelDelegate){
        self.pokemonManager = pokemonManager
        self.delegate = delegate
    }
    
    func fetchListPokemons(){
        let urlString = "\(Const.baseURL)/pokemon?offset=\(startPaginationValue)&limit=\(paginationSize)"
        print(urlString)
        
        pokemonManager.performRequest(with: urlString, isDetails: false)
    }
    
    //function to be called when searching
    func fetchPokemon(name: String){
        let urlString = "\(Const.baseURL)/pokemon/\(name)"
        print(urlString)
        
        pokemonManager.performRequest(with: urlString)
    }
    
    
}
