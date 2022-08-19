//
//  MockPokemonListViewModel.swift
//  PoketestTests
//
//  Created by Marcelo Macedo on 19/08/2022.
//

import Foundation
@testable import Poketest

class MockPokemonListViewModel: TypePokemonListViewModel {
    
    private var pokemonsList: [Pokemon] = []
    private let paginationSize = 20
    private var startPaginationValue = 0
    private var isFetchInProgress = false
    
    func fetchListPokemons(startValue: Int, paginationSize: Int) {
        
    }
    
    func fetchPokemon(urlString: String) {
        
    }
    
    
}
