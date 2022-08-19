//
//  MockPokemonManager.swift
//  PoketestTests
//
//  Created by Marcelo Macedo on 19/08/2022.
//

import Foundation
@testable import Poketest

class MockPokemonManager: TypePokemonManager {
    func performListRequest(with urlString: String, queue: DispatchQueue, completionBlock: @escaping (Result<PokemonList, Error>) -> Void){
        if let url = URL(string: urlString){
            let task = URLSession(configuration: .default).dataTask(with: url) { data, response, error in
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
            task.resume()
        }
    }
    
    func performDetailsRequest(with urlString: String, queue: DispatchQueue, completionBlock: @escaping (Result<Pokemon, Error>) -> Void){
        if let url = URL(string: urlString){ 
            let task = URLSession(configuration: .default).dataTask(with: url) { data, response, error in
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
            task.resume()
        }
    }
}
