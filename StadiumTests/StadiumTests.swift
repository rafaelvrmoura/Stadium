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
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testTeamsAreInitiated() {
        let ash = TreinerManager.shared.ash
        let gary = TreinerManager.shared.gary
        
        XCTAssertNotNil(ash, "Ash should not be nil")
        XCTAssertNotNil(gary, "Gary Valor should not be nil")
    }
    
    func testAddPokemonToTeam() {
        var gary = TreinerManager.shared.gary
        let previousCount = gary.pokemons.count
        
        // Adding a new Pokemon to Team Mystic
        try! gary.addPokemon("Abra")
        XCTAssertEqual(gary.pokemons.count, previousCount + 1, "Treiner should have one more Pokemon")
    }
    
    func testRemovingPokemon() {
        var ash = TreinerManager.shared.ash
        let previousCount = ash.pokemons.count
        
        // Removing one Pokemon from Team Valor
        ash.removePokemon("Muk")
        
        XCTAssertEqual(ash.pokemons.count, previousCount - 1, "Treiner should have one less Pokemon")
    }
    
    func testMaxNumberOfPokemon() {
        var gary = TreinerManager.shared.gary
        
        // Adding more Pokemon to Team Instinct
        try! gary.addPokemon("Jolteon")
        try! gary.addPokemon("Persian")
        
        XCTAssertThrowsError(try gary.addPokemon("Raticate"), "A Treiner can't have more than five Pokemon")
    }
    
    func testStartBattle() {
        let ash = TreinerManager.shared.ash
        let gary = TreinerManager.shared.gary
        
        XCTAssertTrue(TreinerManager.shared.startBattle(treiner: ash, otherTreiner: gary), "Battle should start only with the same number of pokemons")
    }
}
