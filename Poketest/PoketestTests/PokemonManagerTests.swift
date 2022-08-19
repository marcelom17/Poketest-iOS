//
//  PoketestTests.swift
//  PoketestTests
//
//  Created by Marcelo Macedo on 12/08/2022.
//

import XCTest
@testable import Poketest

class PokemonManagerTests: XCTestCase {
    var pokemonManager : MockPokemonManager!
    var queue : DispatchQueue!
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        try super.setUpWithError()
        pokemonManager = MockPokemonManager()
        queue = DispatchQueue.main
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        pokemonManager = nil
        queue = nil
        try super.tearDownWithError()
    }

    func testListFetch() throws {
        let startVal = 0
        let sizeList = 10
        let url = "\(Const.baseURL)/pokemon?offset=\(startVal)&limit=\(sizeList)"
        
        
        pokemonManager.performListRequest(with: url, queue: queue) { result in
            switch result{
            case .failure(let error):
                XCTFail("Error getting list: \(error)")
                
            case .success(let list):
                XCTAssertEqual(list.results.count, sizeList)
            }
        }
    }
    
    func testListFetch20() throws {
        let startVal = 0
        let sizeList = 0
        let url = "\(Const.baseURL)/pokemon?offset=\(startVal)&limit=\(sizeList)"
        
        pokemonManager.performListRequest(with: url, queue: queue) { result in
            switch result{
            case .failure(let error):
                XCTFail("Error getting list: \(error)")
                
            case .success(let list):
                XCTAssertEqual(list.results.count, 20) //no size -> default 20
            }
        }
    }

    func testFetchPokemonDetails() throws{
        let id = 6
        let url = "\(Const.baseURL)/pokemon/\(id)"
        let localPokemon = pokemonManager.loadLocalJson(filename: "pokemon6")
        XCTAssertNotNil(localPokemon)
        
        pokemonManager.performDetailsRequest(with: url, queue: queue) { result in
            switch result{
                case .failure(let error):
                    XCTFail("Error getting list: \(error)")
                    
                case .success(let pokemon):
                    XCTAssertEqual(pokemon, localPokemon)
            }
        }
    }
    
    func testFetchPokemonDetailsError() throws{
        let id = 7
        let url = "\(Const.baseURL)/pokemon/\(id)"
        let localPokemon = pokemonManager.loadLocalJson(filename: "pokemon6")
        XCTAssertNotNil(localPokemon)
        
        pokemonManager.performDetailsRequest(with: url, queue: queue) { result in
            switch result{
                case .failure(let error):
                    XCTFail("Error getting list: \(error)")
                    
                case .success(let pokemon):
                    XCTAssertNotEqual(pokemon, localPokemon)
            }
        }
    }
    
}
