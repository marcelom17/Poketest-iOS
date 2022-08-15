//
//  MainViewController.swift
//  Poketest
//
//  Created by Marcelo Macedo on 12/08/2022.
//

import UIKit
import SDWebImage

class PokemonDetailsViewController: UIViewController {
    
    @IBOutlet weak var pokemonImage: UIImageView!
    @IBOutlet weak var pokemonNameLabel: UILabel!
    
    var pokemon: Pokemon?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        guard let navBar = navigationController else {
            fatalError("Navigation controller does not exist.")
        }
        navBar.setStatusBar(backgroundColor: UIColor(named: Const.Colors.navigationRed)!) //use the type color
        if let pokeName = pokemon?.name?.capitalizingFirstLetter(){
            self.title = pokeName
        }
        
    }
    
    func loadData(){
        if let pokeImgURL = pokemon?.sprites?.other?.officialArtwork?.frontDefault{
            pokemonImage.sd_setImage(with: URL(string: pokeImgURL), placeholderImage: UIImage(named: "placeholder.png"))
        } else if let defaultURL = pokemon?.sprites?.frontDefault{
            pokemonImage.sd_setImage(with: URL(string: defaultURL), placeholderImage: UIImage(named: "placeholder.png"))
        }
        pokemonNameLabel.text = pokemon?.name?.capitalizingFirstLetter()
    }
    
}


