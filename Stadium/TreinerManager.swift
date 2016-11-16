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

class Trainer {
    let name: String
    var pokemons: [Pokemon]
    
    init(name: String, pokemons: [Pokemon]) {
        self.name = name
        self.pokemons = pokemons
    }
    
    func addPokemon(_ pokemon: Pokemon) throws {
        if pokemons.count == 5 {
            throw PokemonError.maximumNumberOfPokemonExceeded
        }
        
        pokemons.append(pokemon)
    }
    
    func removePokemon(_ pokemon: Pokemon) {
        let index = pokemons.index(of: pokemon)
        
        if let i = index {
            pokemons.remove(at: i)
        }
    }
}

class Pokemon: Equatable {
    let name: String
    let number: String
    
    init(name: String, number: String) {
        self.name = name
        self.number = number
    }
    
    static func ==(lhs: Pokemon, rhs: Pokemon) -> Bool {
        return lhs.name == rhs.name && lhs.number == rhs.number
    }
}

class TreinerManager {
    
    static let shared = TreinerManager()
    
    // Ash
    var ash: Trainer
    
    // Gary
    var gary: Trainer
    
    // All Teams
    var allTreiners: [Trainer] {
        return [ash, gary]
    }
    
    fileprivate init() {
        self.ash = Trainer(name: "Ash", pokemons: [])
        self.gary = Trainer(name: "Gary", pokemons: [])
    }
    
    /// Returns all Pokemon from the local JSON
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
