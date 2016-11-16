//
//  StadiumTests.swift
//  StadiumTests
//
//  Created by Lourenço Marinho on 16/11/16.
//  Copyright © 2016 BEPiD. All rights reserved.
//

import XCTest
@testable import Stadium

class StadiumTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        let ash = TreinerManager.shared.ash
        let gary = TreinerManager.shared.gary
        let pokemons = TreinerManager.shared.pokemons
        
        ash.pokemons = [pokemons[0], pokemons[1], pokemons[2]]
        gary.pokemons = [pokemons[3], pokemons[4], pokemons[5]]
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testTeamsAreInitiated() {
        let ash = TreinerManager.shared.ash
        let gary = TreinerManager.shared.gary
        
        XCTAssertEqual(ash.pokemons.count, 3, "Ash`s team should have 3 Pokemon")
        XCTAssertEqual(gary.pokemons.count, 3, "Gary`s team should have 3 Pokemon")
    }
    
    func testAddPokemonToTeam() {
        let gary = TreinerManager.shared.gary
        let pokemons = TreinerManager.shared.pokemons
        let previousCount = gary.pokemons.count
        
        // Adding a new Pokemon to Gary
        try! gary.addPokemon(pokemons[9])
        XCTAssertEqual(gary.pokemons.count, previousCount + 1, "Treiner should have one more Pokemon")
    }
    
    func testRemovingPokemon() {
        let ash = TreinerManager.shared.ash
        let venusaur = ash.pokemons[1]
        let previousCount = ash.pokemons.count
        
        // Removing one Pokemon from Ash
        ash.removePokemon(venusaur)
        
        XCTAssertEqual(ash.pokemons.count, previousCount - 1, "Treiner should have one less Pokemon")
    }
    
    func testMaxNumberOfPokemon() {
        let gary = TreinerManager.shared.gary
        let pokemons = TreinerManager.shared.pokemons
        
        // Adding more Pokemon to Gary
        try! gary.addPokemon(pokemons[7])
        try! gary.addPokemon(pokemons[10])        
        
        XCTAssertThrowsError(try gary.addPokemon(pokemons[8]), "A Treiner can't have more than five Pokemon")
    }
    
    func testStartBattleShouldSucceed() {
        let ash = TreinerManager.shared.ash
        let gary = TreinerManager.shared.gary
        
        XCTAssertTrue(TreinerManager.shared.startBattle(treiner: ash, otherTreiner: gary), "Battle should start only with the same number of pokemons")
    }
}
