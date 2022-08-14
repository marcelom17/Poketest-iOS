//
//  PokemonsList.swift
//  Poketest
//
//  Created by Marcelo Macedo on 14/08/2022.
//

import Foundation

struct PokemonList : Codable {
    let count : Int
    let next : String?
    let previous : String?
    let results : [Results?]

}

struct Results : Codable {
    let name : String
    let url : String
}
