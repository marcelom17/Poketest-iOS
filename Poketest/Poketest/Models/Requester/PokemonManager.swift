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
    
    //function to be called
    func fetchPokemon(name: String){
        let urlString = "\(baseURL)/pokemon/\(name)"
        print(urlString)
        
        performRequest(with: urlString)
    }
    
    
    func fetchListPokemons(name: String){
        let urlString = "\(baseURL)/pokemon/\(name)"
        print(urlString)
        
        performRequest(with: urlString)
    }
    
    func performRequest(with urlString: String){
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
                    if let pokemon = parseJSON(safeData){
                        self.delegate?.didUpdatePokemon(self, pokemon: pokemon)
                    }
                }
            }
            //  let task = session.dataTask(with: url, completionHandler: handleData(data:response:error:)) //3
            task.resume() //4
        }
    }
    
    
    func parseJSON(_ pokemon: Data) -> Pokemon?{
        let decoder = JSONDecoder()
        do{
            let decodedData = try decoder.decode(Pokemon.self, from: pokemon)
            print("Name: \(decodedData.name)")
         //   let id = decodedData.weather[0].id
         //   let temp = decodedData.main.temp
            let name = decodedData.name
            
            return decodedData
            
        } catch {
            self.delegate?.didFailWithError(error: error)
            return nil
        }
    }
    
    
}
