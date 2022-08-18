//
//  PokemonManager\.swift
//  Poketest
//
//  Created by Marcelo Macedo on 13/08/2022.
//

import Foundation

final class PokemonManager {
    
    //TODO - Add loading when fetching data
    
    func performListRequest(with urlString: String, completionBlock: @escaping (Result<PokemonList, Error>) -> Void){
        
        if let url = URL(string: urlString){ //1
            let session = URLSession(configuration: .default) //2
            let task = session.dataTask(with: url) { data, response, error in //3 using clousers
                if error != nil{
                    completionBlock(.failure(error!))
                    return
                }
                
                if let safeData = data{
                    do{
                        completionBlock(.success(try JSONDecoder().decode(PokemonList.self, from: safeData)))
                    } catch{
                        completionBlock(.failure(error))
                    }
                }
            }
            task.resume() //4
        }
    }
    
    func performDetailsRequest(with urlString: String, completionBlock: @escaping (Result<Pokemon, Error>) -> Void){
        
        if let url = URL(string: urlString){ //1
            let session = URLSession(configuration: .default) //2
            let task = session.dataTask(with: url) { data, response, error in //3 using clousers
                if error != nil{
                    completionBlock(.failure(error!))
                    return
                }
                
                if let safeData = data{
                    do{
                        completionBlock(.success(try JSONDecoder().decode(Pokemon.self, from: safeData)))
                    } catch{
                        completionBlock(.failure(error))
                    }
                }
            }
            task.resume() //4
        }
    }
    
}
