//
//  Constants.swift
//  Poketest
//
//  Created by Marcelo Macedo on 14/08/2022.
//

import Foundation

struct Const {
    static let cellIdentifier = "ReusableCell"
    static let cellNibName = "PokemonListTableViewCell"
    static let detailsSegue = "pokeDetailsSegue"
    
    //Network
    static let baseURL = "https://pokeapi.co/api/v2/"
    
    struct Images{
        static let titleIcon = "TitleImage"
    }
    
    struct Colors{
        static let navigationRed = "BaseRedColor"
    }
    
}
