//
//  PokemonListViewModelTests.swift
//  PoketestTests
//
//  Created by Marcelo Macedo on 19/08/2022.
//

import XCTest
@testable import Poketest

class PokemonListViewModelTests: XCTestCase {
    
    private var pokemonManager : TypePokemonManager!
    var viewModel : TypePokemonListViewModel!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        self.pokemonManager = MockPokemonManager()
        self.viewModel = MockPokemonListViewModel()
    }

    override func tearDownWithError() throws {
        pokemonManager = nil
        viewModel = nil
        try super.tearDownWithError()
    }

    func testURL() throws {
        let startVal = 0
        let sizeList = 20
        let testURL = "\(Const.baseURL)/pokemon?offset=\(startVal)&limit=\(sizeList)"
        let funcURL = viewModel.createURLFetchList(start: startVal, size: sizeList)
        XCTAssertEqual(funcURL, testURL)
    }
    
    //Need to redo viewmodel function approach to be easy to do tests

}
