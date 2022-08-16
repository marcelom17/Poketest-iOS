//
//  Pokemon.swift
//  Poketest
//
//  Created by Marcelo Macedo on 13/08/2022.
//

import Foundation

// This file was generated from JSON Schema using codebeautify, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let pokemon = try Pokemon(json)


struct Pokemon : Codable{
    let abilities: [Ability?]
    let baseExperience: Int?
    let forms: [Species?]
    let gameIndices: [GameIndex?]
    let height: Int?
 //   let heldItems: [Any?]
    let id: Int
    let isDefault: Bool
    let locationAreaEncounters: String?
    let moves: [Move]?
    let name: String?
    let order: Int?
  //  let pastTypes: [Any?]
    let species: Species?
    let sprites: Sprites?
    let stats: [Stat]?
    let types: [TypeElement?]
    let weight: Int?
    
    enum CodingKeys: String, CodingKey {
        case baseExperience = "base_experience"
        case gameIndices = "game_indices"
        case isDefault = "is_default"
        case locationAreaEncounters = "location_area_encounters"
        
        case abilities = "abilities"
        case forms = "forms"
        case height = "height"
      //  case held_items = "held_items"
        case id = "id"
        case moves = "moves"
        case name = "name"
        case order = "order"
     //   case past_types = "past_types"
        case species = "species"
        case sprites = "sprites"
        case stats = "stats"
        case types = "types"
        case weight = "weight"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
            baseExperience = try values.decodeIfPresent(Int.self, forKey: .baseExperience)
            gameIndices = try values.decodeIfPresent([GameIndex?].self, forKey: .gameIndices)!
            isDefault = try values.decodeIfPresent(Bool.self, forKey: .isDefault)!
            locationAreaEncounters = try values.decodeIfPresent(String.self, forKey: .locationAreaEncounters)
            abilities = try values.decodeIfPresent([Ability?].self, forKey: .abilities)!
            forms = try values.decodeIfPresent([Species?].self, forKey: .forms)!
            height = try values.decodeIfPresent(Int.self, forKey: .height)
            id = try values.decodeIfPresent(Int.self, forKey: .id)!
            moves = try values.decodeIfPresent([Move].self, forKey: .moves)
            name = try values.decodeIfPresent(String.self, forKey: .name)
            order = try values.decodeIfPresent(Int.self, forKey: .order)
            //past_types = try values.decodeIfPresent([String].self, forKey: .past_types)
            species = try values.decodeIfPresent(Species.self, forKey: .species)
            sprites = try values.decodeIfPresent(Sprites.self, forKey: .sprites)
            stats = try values.decodeIfPresent([Stat].self, forKey: .stats)
            types = try values.decodeIfPresent([TypeElement?].self, forKey: .types)!
            weight = try values.decodeIfPresent(Int.self, forKey: .weight)
    }
}

// MARK: - Ability
struct Ability : Codable {
    let ability: Species?
    let isHidden: Bool?
    let slot: Int?
}

// MARK: - Species
struct Species : Codable{
    let name: String?
    let url: String?
}

// MARK: - GameIndex
struct GameIndex : Codable {
    let gameIndex: Int?
    let version: Species?
}

// MARK: - Move
struct Move : Codable {
    let move: Species?
    let versionGroupDetails: [VersionGroupDetail]?
}

// MARK: - VersionGroupDetail
struct VersionGroupDetail : Codable {
    let levelLearnedAt: Int?
    let moveLearnMethod, versionGroup: Species?
}

// MARK: - Sprites
struct Sprites : Codable {
    let backDefault: String?
    let backFemale: String?
    let backShiny: String?
    let backShinyFemale: String?
    let frontDefault: String?
    let frontFemale: String?
    let frontShiny: String?
    let frontShinyFemale: String?
    let other: Other?
    
    enum CodingKeys: String, CodingKey {
        case backDefault = "back_default"
        case backFemale = "back_female"
        case backShiny = "back_shiny"
        case backShinyFemale = "back_shiny_female"
        case frontDefault = "front_default"
        case frontFemale = "front_female"
        case frontShiny = "front_shiny"
        case frontShinyFemale = "front_shiny_female"
        case other
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        backDefault = try values.decodeIfPresent(String.self, forKey: .backDefault)
        backFemale = try values.decodeIfPresent(String.self, forKey: .backFemale)
        backShiny = try values.decodeIfPresent(String.self, forKey: .backShiny)
        backShinyFemale = try values.decodeIfPresent(String.self, forKey: .backShinyFemale)
        frontDefault = try values.decodeIfPresent(String.self, forKey: .frontDefault)
        frontFemale = try values.decodeIfPresent(String.self, forKey: .frontFemale)
        frontShiny = try values.decodeIfPresent(String.self, forKey: .frontShiny)
        frontShinyFemale = try values.decodeIfPresent(String.self, forKey: .frontShinyFemale)
        other = try values.decodeIfPresent(Other.self, forKey: .other)
    }
}

// MARK: - Other
struct Other : Codable {
    let officialArtwork: OfficialArtwork?
    
    enum CodingKeys: String, CodingKey {
        case officialArtwork = "official-artwork"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        officialArtwork = try values.decodeIfPresent(OfficialArtwork.self, forKey: .officialArtwork)
    }
}


// MARK: - OfficialArtwork
struct OfficialArtwork : Codable {
    let frontDefault: String?
    
    enum CodingKeys: String, CodingKey {
        case frontDefault = "front_default"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        frontDefault = try values.decodeIfPresent(String.self, forKey: .frontDefault)
    }
}



// MARK: - Stat
struct Stat : Codable {
    let baseStat, effort: Int?
    let stat: Species?
    
    enum CodingKeys: String, CodingKey {
        case baseStat = "base_stat"
        case effort
        case stat
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        baseStat = try values.decodeIfPresent(Int.self, forKey: .baseStat)
        effort = try values.decodeIfPresent(Int.self, forKey: .effort)
        stat = try values.decodeIfPresent(Species.self, forKey: .stat)
    }
    
}

// MARK: - TypeElement
struct TypeElement : Codable {
    let slot: Int?
    let type: Species?
}
