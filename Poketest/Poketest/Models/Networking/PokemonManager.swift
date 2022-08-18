//
//  PokemonManager\.swift
//  Poketest
//
//  Created by Marcelo Macedo on 13/08/2022.
//

import Foundation

protocol PokemonManagerDelegate{
    func didUpdatePokemon(_ pokemonManager: PokemonManager, pokemon: Pokemon)
    func didFailWithError(error: Error)
    func didFetchList(pokemonList: PokemonList, startPosition: Int)
}

final class PokemonManager {
    var delegate: PokemonManagerDelegate?
    let paginationSize = 20
    var startPaginationValue = 0
    var isFetchInProgress = false
    
    //TODO - Add loading when fetching data
    
    func fetchListPokemons(){
        let urlString = "\(Const.baseURL)/pokemon?offset=\(startPaginationValue)&limit=\(paginationSize)"
        print(urlString)
        guard !isFetchInProgress else{
            print("already fetching list")
            return
        }
        isFetchInProgress = true

        performRequest(with: urlString, isDetails: false)

    }
    
    //function to be called when searching
    func fetchPokemon(name: String){
        let urlString = "\(Const.baseURL)/pokemon/\(name)"
        print(urlString)
        performRequest(with: urlString)
    }
    
    
    func performRequest(with urlString: String, isDetails: Bool = true){
        
        if let url = URL(string: urlString){ //1
            let session = URLSession(configuration: .default) //2
            let task = session.dataTask(with: url) { data, response, error in //3 using clousers
                if error != nil{
                    self.isFetchInProgress = false
                    self.delegate?.didFailWithError(error: error!)
                    return
                }
                
                if let safeData = data{
                    if isDetails{
                        if let pokemon = self.parsePokemonDetails(safeData){
                            self.delegate?.didUpdatePokemon(self, pokemon: pokemon)
                        }
                    } else {
                        if let pokemonList = self.parsePokemonList(safeData){
                            self.isFetchInProgress = false
                            self.delegate?.didFetchList(pokemonList: pokemonList, startPosition: pokemonList.count > self.startPaginationValue ? self.startPaginationValue + self.paginationSize : -1)
                            
                        }
                    }
                }
            }
            task.resume() //4
        }
    }
    
    
    func parsePokemonDetails(_ pokemon: Data) -> Pokemon?{
        let decoder = JSONDecoder()
        do{
            let decodedData = try decoder.decode(Pokemon.self, from: pokemon)
            
            return decodedData
            
        } catch {
            self.delegate?.didFailWithError(error: error)
            return nil
        }
    }
    
    func parsePokemonList(_ list: Data) -> PokemonList?{
        let decoder = JSONDecoder()
        do{
            let decodedData = try decoder.decode(PokemonList.self, from: list)
            print("Count: \(decodedData.count)")
            
            return decodedData
            
        } catch {
            self.delegate?.didFailWithError(error: error)
            return nil
        }
    }
    
    
}
