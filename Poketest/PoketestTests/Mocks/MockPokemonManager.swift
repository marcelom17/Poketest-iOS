//
//  MockPokemonManager.swift
//  PoketestTests
//
//  Created by Marcelo Macedo on 19/08/2022.
//

import Foundation
@testable import Poketest

class MockPokemonManager: TypePokemonManager {
    func performListRequest(with urlString: String, queue: DispatchQueue, completionBlock: @escaping (Result<PokemonList, Error>) -> Void) {
        
    }
    
    func performDetailsRequest(with urlString: String, queue: DispatchQueue, completionBlock: @escaping (Result<Pokemon, Error>) -> Void) {
        
    }
    
}
