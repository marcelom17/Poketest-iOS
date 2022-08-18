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
    
    private var viewModel : PokemonListViewModel!
    var pokemonManager = PokemonManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = PokemonListViewModel.init(pokemonManager: pokemonManager, delegate: self)
        tableView.prefetchDataSource = self
        viewModel.fetchListPokemons()
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
        navBar.navigationItem.titleView = UIImageView(image: UIImage(named: Const.Images.titleIcon))
        
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        //maybe separate by generations?
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return viewModel.getPokemonList().count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Const.cellIdentifier, for: indexPath) as! PokemonListTableViewCell
        
        // Configure the cell...
        let pokemon = viewModel.getPokemonList()[indexPath.row]
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
            destinationVC.pokemon = viewModel.getPokemonList()[indexPath.row]
        }
    }
}


//MARK: - TableVie DataSource Prefetching
extension PokemonListTableViewController: UITableViewDataSourcePrefetching{
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
    /*    if indexPaths[0].row >= pokemonList.count - 5{
            if(viewModel.startPaginationValue != -1){
                pokemonManager.fetchListPokemons()
            }
        } */
    }
    
}


//MARK: - Pokemon Manager Delegate
extension PokemonListTableViewController : PokemonListViewModelDelegate{
    
    func didUpdatePokemon() { //only should be called when
        DispatchQueue.main.async {
         //   self.getPokemonList() = self.getPokemonList().sorted(by: { $0.id < $1.id })
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
