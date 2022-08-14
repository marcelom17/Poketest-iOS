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
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        guard let navBar = navigationController else {
            fatalError("Navigation controller does not exist.")
        }
        navBar.setStatusBar(backgroundColor: UIColor(named: Const.Colors.navigationRed)!)
        
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


