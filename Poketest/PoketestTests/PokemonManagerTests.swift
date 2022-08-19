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
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
        let startVal = 0
        let sizeList = 20
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
    
    func testListFetchError() throws {

        let startVal = 0
        let sizeList = 0
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

}
