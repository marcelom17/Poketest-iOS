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
}

struct PokemonManager {
    let baseURL = "https://pokeapi.co/api/v2/"
    var delegate: PokemonManagerDelegate?
    let paginationSize = 20
    
    
    func fetchListPokemons(start: Int = 0){
        let urlString = "\(baseURL)/pokemon?offset=\(start)&limit=\(paginationSize)"
        print(urlString)
        
        performRequest(with: urlString, isDetails: false)

    }
    
    //function to be called when searching
    func fetchPokemon(name: String){
        let urlString = "\(baseURL)/pokemon/\(name)"
        print(urlString)
        
        performRequest(with: urlString)
    }
    
    
    func performRequest(with urlString: String, isDetails: Bool = true){
        // 1. Create URL
        // 2. Create URLSession
        // 3. Give the session a task
        // 4. Start the Task
        
        if let url = URL(string: urlString){ //1
            let session = URLSession(configuration: .default) //2
            let task = session.dataTask(with: url) { data, response, error in //3 using clousers
                if error != nil{
                    self.delegate?.didFailWithError(error: error!)
                    return
                }
                
                if let safeData = data{
                    if isDetails{
                        if let pokemon = parsePokemonDetails(safeData){
                            self.delegate?.didUpdatePokemon(self, pokemon: pokemon)
                        }
                    } else {
                        if let pokemonList = parsePokemonList(safeData){
                            for poke in pokemonList.results {
                                if let url = poke?.url{
                                    performRequest(with: url)
                                }
                            }
                        }
                    }
                }
            }
            //  let task = session.dataTask(with: url, completionHandler: handleData(data:response:error:)) //3
            task.resume() //4
        }
    }
    
    
    func parsePokemonDetails(_ pokemon: Data) -> Pokemon?{
        let decoder = JSONDecoder()
        do{
            let decodedData = try decoder.decode(Pokemon.self, from: pokemon)
            print("Name: \(decodedData.name)")
            
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
