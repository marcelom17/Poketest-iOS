//
//  Extensions.swift
//  Poketest
//
//  Created by Marcelo Macedo on 15/08/2022.
//

import Foundation

//For status bar color

//To Capitalize first letter of name 
extension String {
    func capitalizingFirstLetter() -> String {
        return prefix(1).capitalized + dropFirst()
    }

    mutating func capitalizeFirstLetter() {
        self = self.capitalizingFirstLetter()
    }
}
