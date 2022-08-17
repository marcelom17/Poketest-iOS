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
    @IBOutlet weak var pokemonXPLabel: UILabel!
    @IBOutlet weak var pokemonHPLabel: UILabel!
    @IBOutlet weak var pokemonType1Label: UILabel!
    @IBOutlet weak var pokemonType2Label: UILabel!
    @IBOutlet weak var pokemonHeightLabel: UILabel!
    @IBOutlet weak var pokemonWeightLabel: UILabel!
    @IBOutlet weak var pokemonRandomMoveValueLabel: UILabel!
    @IBOutlet weak var pokemonAbilitiesValueLabel: UILabel!
    
    @IBOutlet weak var pokemonAttackValueLabel: UILabel!
    @IBOutlet weak var pokemonDefenseValueLabel: UILabel!
    @IBOutlet weak var pokemonSpecialAttackValueLabel: UILabel!
    @IBOutlet weak var pokemonSpecialDefenseValueLabel: UILabel!
    @IBOutlet weak var pokemonSpeedValueLabel: UILabel!
    
    
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
        if let safePokemon = pokemon{
            if let pokeImgURL = safePokemon.sprites?.other?.officialArtwork?.frontDefault{
                pokemonImage.sd_setImage(with: URL(string: pokeImgURL), placeholderImage: UIImage(named: "placeholder.png"))
            } else if let defaultURL = safePokemon.sprites?.frontDefault{
                pokemonImage.sd_setImage(with: URL(string: defaultURL), placeholderImage: UIImage(named: "placeholder.png"))
            }
            //        stats
            if let pokeHp = safePokemon.stats?.filter({$0.stat?.name == "hp"}) {
                pokemonHPLabel.text = "\(pokeHp[0].baseStat ?? 0) HP"
            }
            if let pokeAttack = safePokemon.stats?.filter({$0.stat?.name == "attack"}) {
                pokemonAttackValueLabel.text = pokeAttack[0].baseStat?.description
            }
            if let pokeDefense = safePokemon.stats?.filter({$0.stat?.name == "defense"}) {
                pokemonDefenseValueLabel.text = pokeDefense[0].baseStat?.description
            }
            if let pokeSpecAttack = safePokemon.stats?.filter({$0.stat?.name == "special-attack"}) {
                pokemonSpecialAttackValueLabel.text = pokeSpecAttack[0].baseStat?.description
            }
            if let pokeSpecDefense = safePokemon.stats?.filter({$0.stat?.name == "special-defense"}) {
                pokemonSpecialDefenseValueLabel.text = pokeSpecDefense[0].baseStat?.description
            }
            if let pokeSpecDefense = safePokemon.stats?.filter({$0.stat?.name == "speed"}) {
                pokemonSpeedValueLabel.text = pokeSpecDefense[0].baseStat?.description
            }
            pokemonXPLabel.text = "\(safePokemon.baseExperience ?? 0) XP"
            //type
            pokemonType1Label.text = safePokemon.types[0]?.type?.name?.capitalizingFirstLetter()
            if safePokemon.types.count > 1{
                pokemonType2Label.text = safePokemon.types[1]?.type?.name?.capitalizingFirstLetter()
            } else {
                pokemonType2Label.isHidden = true
            }
            //size
            pokemonHeightLabel.text = "\(String(safePokemon.height!).addingComa()) m"
            pokemonWeightLabel.text = "\(String(safePokemon.weight!).addingComa()) kg"
            //Abilities
            pokemonAbilitiesValueLabel.text = safePokemon.abilities[0]?.ability?.name?.capitalizingFirstLetter()
            //Random Move
            if let randomMove = safePokemon.moves?.randomElement(){
                pokemonRandomMoveValueLabel.text = randomMove.move?.name?.capitalizingFirstLetter()
            }

        }
    }
    
}


/* --- Notes ---
 weight -> hectograms
 height -> decimetres
 
 */
