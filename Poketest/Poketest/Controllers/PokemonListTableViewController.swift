//
//  PokemonListTableViewController.swift
//  Poketest
//
//  Created by Marcelo Macedo on 14/08/2022.
//

import UIKit
import ChameleonFramework

class PokemonListTableViewController: UITableViewController {
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    var pokemonManager = PokemonManager()
    var pokemonList = [Pokemon]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pokemonManager.delegate = self
        tableView.prefetchDataSource = self
        pokemonManager.fetchListPokemons()
        searchBar.delegate = self
        
        tableView.register(UINib(nibName: Const.cellNibName, bundle: nil), forCellReuseIdentifier: Const.cellIdentifier)
        
        //maybe use this for favorites?
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    override func viewWillAppear(_ animated: Bool) {
        guard let navBar = navigationController else {
            fatalError("Navigation controller does not exist.")
        }
        navBar.setStatusBar(backgroundColor: UIColor(named: Const.Colors.navigationRed)!)
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        //maybe separate by generations?
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return pokemonList.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Const.cellIdentifier, for: indexPath) as! PokemonListTableViewCell
        
        // Configure the cell...
        let pokemon = pokemonList[indexPath.row]
        cell.pokemonNameLabel.text = pokemon.name //need to Capitalize first letter
        cell.pokemonIDLabel.text = String(format: "%04d", pokemon.id)
        if let url = pokemon.sprites?.frontDefault{
            cell.pokemonImage.sd_setImage(with: URL(string: url), placeholderImage: UIImage(named: "placeholder.png"))
        }
        
        
        return cell
    }
    
    
    /*
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    /*
     // Override to support editing the table view.
     override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
     if editingStyle == .delete {
     // Delete the row from the data source
     tableView.deleteRows(at: [indexPath], with: .fade)
     } else if editingStyle == .insert {
     // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
     }
     }
     */
    
    /*
     // Override to support rearranging the table view.
     override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
     
     }
     */
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    
    
}


//MARK: - TableVie DataSource Prefetching
extension PokemonListTableViewController: UITableViewDataSourcePrefetching{
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        if indexPaths[0].row >= pokemonList.count - 5{
            if(pokemonManager.startPaginationValue != -1){
                pokemonManager.fetchListPokemons()
            }
        }
    }
    
    
}

//MARK: - Pokemon Manager Delegate
extension PokemonListTableViewController : PokemonManagerDelegate{
    func didFetchNextPokemons(startPosition: Int) {
        pokemonManager.startPaginationValue = startPosition
    }
    
    func didUpdatePokemon(_ pokemonManager: PokemonManager, pokemon: Pokemon) {
        print(pokemon.name)
        print(pokemon.sprites?.frontDefault)
        DispatchQueue.main.async {
            self.pokemonList.append(pokemon)
            self.pokemonList = self.pokemonList.sorted(by: { $0.id < $1.id })
            /*do{
             
             } catch {
             print("Error sortinng array: \(error)")
             }*/
            self.tableView.reloadData()
        }
        
    }
    
    func didFailWithError(error: Error) {
        print(error)
        //need to define what to do when error getting pokemon
        
    }
}


//MARK: - SearchBar Delegate
extension PokemonListTableViewController : UISearchBarDelegate{
    
}


//MARK: - Change Status Bar Color
extension UINavigationController {
    
    func setStatusBar(backgroundColor: UIColor) {
        let statusBarFrame: CGRect
        if #available(iOS 13.0, *) {
            statusBarFrame = view.window?.windowScene?.statusBarManager?.statusBarFrame ?? CGRect.zero
        } else {
            statusBarFrame = UIApplication.shared.statusBarFrame
        }
        let statusBarView = UIView(frame: statusBarFrame)
        statusBarView.backgroundColor = backgroundColor
        view.addSubview(statusBarView)
    }
    
}
