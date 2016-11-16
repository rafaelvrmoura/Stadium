//
//  StadiumUITests.swift
//  StadiumUITests
//
//  Created by Rafael Moura on 16/11/16.
//  Copyright © 2016 BEPiD. All rights reserved.
//

import XCTest
@testable import Stadium

class StadiumUITests: XCTestCase {
        
    override func setUp() {
        super.setUp()
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    
    func testPickingAshsTeam() {
        
        let app = XCUIApplication()
        let tablesQuery = app.tables
        
        tablesQuery.cells.containing(.staticText, identifier:"Ash").staticTexts["0 Pokemons"].tap()
        
        tablesQuery.staticTexts["Venusaur"].tap()
        tablesQuery.staticTexts["Squirtle"].tap()
        app.navigationBars["Pokemons"].buttons["Done"].tap()
        
        let element = tablesQuery.cells.containing(.staticText, identifier:"Ash").staticTexts["2 Pokemons"]
        XCTAssertTrue(element.exists, "Expected 2 Pokemons on Ash's team")
    }
    
    func testNumericalOrder() {
        
        let app = XCUIApplication()
        app.tables.cells.containing(.staticText, identifier:"Ash").staticTexts["0 Pokemons"].tap()
        
        let tablesQuery = app.tables
        
        let sortedPokemons = TreinerManager.shared.pokemons.sorted { (pokemon1, pokemon2) -> Bool in
            return pokemon1.number < pokemon2.number
        }
        
        for (index, pokemon) in sortedPokemons.enumerated() {
            
            let isCorrectOrder = tablesQuery.cells.element(boundBy: UInt(index)).staticTexts["# \(pokemon.number)"].exists
            XCTAssertTrue(isCorrectOrder, "Pokemon \(pokemon.name) is out of order")
        }
        
        app.navigationBars["Pokemons"].buttons["Done"].tap()
    }
    
    func testStartBattle() {
        
        let app = XCUIApplication()
        let tablesQuery = app.tables
        tablesQuery.cells.containing(.staticText, identifier:"Ash").staticTexts["0 Pokemons"].tap()
        tablesQuery.staticTexts["Venusaur"].tap()
        tablesQuery.staticTexts["Blastoise"].tap()
        
        app.navigationBars["Pokemons"].buttons["Done"].tap()
        
        tablesQuery.cells.containing(.staticText, identifier:"Gary").staticTexts["0 Pokemons"].tap()
        tablesQuery.staticTexts["Charizard"].tap()
        tablesQuery.staticTexts["Abra"].tap()
        tablesQuery.staticTexts["Slowbro"].tap()
        
        app.navigationBars["Pokemons"].buttons["Done"].tap()
        
        app.navigationBars["Treiners"].buttons["Start Battle"].tap()
        
        let alertDisplayed = app.alerts["Fail"].staticTexts["Treiners have different numbers of pokemons"].exists
        XCTAssert(alertDisplayed, "Should display alert with: \ntitle: Fail \nmessage: Treiners have different numbers of pokemons")
        
        app.alerts["Fail"].buttons["Ok"].tap()
    }
}
