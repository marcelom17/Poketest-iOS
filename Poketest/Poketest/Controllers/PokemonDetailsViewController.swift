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
    @IBOutlet weak var pokemonDescriptionLabel: UILabel!
    @IBOutlet weak var pokemonXPLabel: UILabel!
    @IBOutlet weak var pokemonHPLabel: UILabel!
    @IBOutlet weak var pokemonType1Label: UILabel!
    @IBOutlet weak var pokemonType2Label: UILabel!
    @IBOutlet weak var pokemonHeightLabel: UILabel!
    @IBOutlet weak var pokemonWeightLabel: UILabel!
    
    
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
        pokemonDescriptionLabel.text = pokemon?.name?.capitalizingFirstLetter()
    }
    
}


/* --- Notes ---
 weight -> hectograms
 height -> decimetres
 
 */
