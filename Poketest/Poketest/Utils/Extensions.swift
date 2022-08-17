//
//  Extensions.swift
//  Poketest
//
//  Created by Marcelo Macedo on 15/08/2022.
//

import Foundation

//To Capitalize first letter of name 
extension String {
    func capitalizingFirstLetter() -> String {
        return prefix(1).capitalized + dropFirst()
    }

    mutating func capitalizeFirstLetter() {
        self = self.capitalizingFirstLetter()
    }
    
    func addingComa() -> String {
        let prefix = dropLast().isEmpty ? "0" : dropLast()

        return prefix + "," + suffix(1)
    }

    mutating func addComaToValue() {
        self = self.addingComa()
    }
}
