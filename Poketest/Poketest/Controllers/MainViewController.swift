//
//  MainViewController.swift
//  Poketest
//
//  Created by Marcelo Macedo on 12/08/2022.
//

import UIKit

class MainViewController: UIViewController {

    var pokemonManager = PokemonManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        pokemonManager.delegate = self
        
        pokemonManager.fetchPokemon(name: "bulbasaur")
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

//MARK: - Pokemon Manager Delegate
extension MainViewController : PokemonManagerDelegate{
    func didUpdatePokemon(_ pokemonManager: PokemonManager, pokemon: Pokemon) {
        print(pokemon.name)
    }
    
    func didFailWithError(error: Error) {
        print(error)
        //need to define what to do when error getting pokemon
        
    }
}
