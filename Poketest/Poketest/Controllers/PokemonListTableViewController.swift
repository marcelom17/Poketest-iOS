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
        viewModel.fetchListPokemons(startValue: viewModel.getStartPaginationValue(), paginationSize: viewModel.getPaginationSize())
        //searchBar.delegate = self
        
        tableView.register(UINib(nibName: Const.cellNibName, bundle: nil), forCellReuseIdentifier: Const.cellIdentifier)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationItem.titleView = UIImageView(image: UIImage(named: Const.Images.titleIcon))
        navigationController?.setStatusBarStyle(.default)
        //used for status bar with same color as navigation bar
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = UIColor(named: Const.Colors.navigationRed)
        appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
              
        self.navigationController?.navigationBar.scrollEdgeAppearance = appearance
        self.navigationController?.navigationBar.standardAppearance = appearance
    }
    
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        //maybe separate by generations?
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.getPokemonList().count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Const.cellIdentifier, for: indexPath) as! PokemonListTableViewCell
        
        let pokemon = viewModel.getPokemonList()[indexPath.row]
        cell.pokemonNameLabel.text = pokemon.name?.capitalizingFirstLetter() //need to Capitalize first letter
        cell.pokemonIDLabel.text = String(format: "%04d", pokemon.id) //count is bigger than 1000
        if let url = pokemon.sprites?.frontDefault{
            cell.pokemonImage.sd_setImage(with: URL(string: url))
        }
        
        return cell
    }
    
    
    //MARK: - Table view delegate methods
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
        if indexPaths[0].row >= viewModel.getIndexPathToFetch().row{
            viewModel.fetchListPokemons(startValue: viewModel.getStartPaginationValue(), paginationSize: viewModel.getPaginationSize())
        }
    }
}


//MARK: - Pokemon Manager Delegate
extension PokemonListTableViewController : PokemonListViewModelDelegate{
    func didUpdatePokemons() {
        DispatchQueue.main.async {
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

