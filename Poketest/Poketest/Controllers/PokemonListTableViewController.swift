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
        //navBar.setStatusBar(backgroundColor: UIColor(named: Const.Colors.navigationRed)!) //don't use with landscape on
        navigationItem.titleView = UIImageView(image: UIImage(named: Const.Images.titleIcon))
        
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
        cell.pokemonNameLabel.text = pokemon.name?.capitalizingFirstLetter() //need to Capitalize first letter
        cell.pokemonIDLabel.text = String(format: "%04d", pokemon.id)
        if let url = pokemon.sprites?.frontDefault{
            cell.pokemonImage.sd_setImage(with: URL(string: url), placeholderImage: UIImage(named: "Pokeball"))
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: Const.detailsSegue, sender: self)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! PokemonDetailsViewController
        if let indexPath = tableView.indexPathForSelectedRow{
            destinationVC.pokemon = pokemonList[indexPath.row]
        }
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
    func didFetchList(pokemonList: PokemonList, startPosition: Int) {
        pokemonManager.isFetchInProgress = false
        pokemonManager.startPaginationValue = startPosition
        for poke in pokemonList.results {
            if let url = poke?.url{
                pokemonManager.performRequest(with: url)
            }
        }
    }
    
    func didFetchNextPokemons(startPosition: Int) {
        pokemonManager.startPaginationValue = startPosition
    }
    
    func didUpdatePokemon(_ pokemonManager: PokemonManager, pokemon: Pokemon) {
        print(pokemon.name)
        print(pokemon.sprites?.frontDefault)
        DispatchQueue.main.async {
            self.pokemonList.append(pokemon)
            self.pokemonList = self.pokemonList.sorted(by: { $0.id < $1.id })
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
    //search list or fetch from api?
}


//MARK: - Change Status Bar Color
extension UINavigationController {
    
    func setStatusBar(backgroundColor: UIColor) { //don't use when app can be in landscape, the subView will be on top on tha navigationController
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
