//
//  TreinerManager.swift
//  Stadium
//
//  Created by Lourenço Marinho on 16/11/16.
//  Copyright © 2016 BEPiD. All rights reserved.
//

import Foundation

enum PokemonError: Error {
    case maximumNumberOfPokemonExceeded
}

struct Trainer {
    let name: String
    var pokemons: [String]
    
    mutating func addPokemon(_ pokemon: String) throws {
        if pokemons.count == 5 {
            throw PokemonError.maximumNumberOfPokemonExceeded
        }
        
        pokemons.append(pokemon)
    }
    
    mutating func removePokemon(_ pokemon: String) {
        let index = pokemons.index(of: pokemon)
        
        if let i = index {
            pokemons.remove(at: i)
        }
    }
}

struct Pokemon {
    let name: String
    let number: String
}

class TreinerManager {
    
    static let shared = TreinerManager()
    
    // Ash
    var ash = Trainer(name: "Ash", pokemons: ["Moltres", "Muk", "Kadabra"])
    
    // Gary
    var gary = Trainer(name: "Gary", pokemons: ["", "", ""])
    
    // All Teams
    var allTreiners: [Trainer] {
        return [ash, gary]
    }
    
    // Returns all Pokemon from the local JSON
    var pokemons: [Pokemon] {
        guard let path = Bundle.main.path(forResource: "PokemonsInfo", ofType: "json") else { fatalError("Can't find Pokemon JSON resource.") }
        
        let data = try! Data(contentsOf: URL(fileURLWithPath: path))
        let json = try! JSONSerialization.jsonObject(with: data, options: .mutableContainers) as! [[String : Any]]
        
        let pokemons = json.map { (object) -> Pokemon in
            let name = object["name"] as! String
            let number = object["number"] as! String
            
            return Pokemon(name: name, number: number)
        }
        
        return pokemons
    }
    
    func startBattle(treiner: Trainer, otherTreiner: Trainer) -> Bool {
        return (treiner.pokemons.count == otherTreiner.pokemons.count)
    }
    
}
