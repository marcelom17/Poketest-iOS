//
//  MainViewController.swift
//  Poketest
//
//  Created by Marcelo Macedo on 12/08/2022.
//

import UIKit
import SDWebImage

class MainViewController: UIViewController {

    @IBOutlet weak var pokemonImage: UIImageView!
    @IBOutlet weak var pokemonNameLabel: UILabel!
    
    
    var pokemonManager = PokemonManager()
    var pokemonList : [Pokemon]?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        pokemonManager.delegate = self
        
        //pokemonManager.fetchPokemon(name: "bulbasaur")
        
        pokemonManager.fetchListPokemons(start: 0)
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
        print(pokemon.sprites?.frontDefault)
        DispatchQueue.main.async {
            self.pokemonList?.append(pokemon)
            
          /*  self.pokemonNameLabel.text = pokemon.name
            if let url = pokemon.sprites?.frontDefault{
                self.pokemonImage.sd_setImage(with: URL(string: url), placeholderImage: UIImage(named: "placeholder.png"))
            } */
        }
        
    }
    
    func didFailWithError(error: Error) {
        print(error)
        //need to define what to do when error getting pokemon
        
    }
}
