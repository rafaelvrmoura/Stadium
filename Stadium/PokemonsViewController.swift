//
//  PokemonsViewController.swift
//  Stadium
//
//  Created by Rafael Moura on 16/11/16.
//  Copyright © 2016 BEPiD. All rights reserved.
//

import UIKit

class PokemonsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    weak var treiner: Trainer?
    
    var pokemons = [Pokemon]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        pokemons.append(contentsOf: TreinerManager.shared.pokemons)
        
        pokemons.sort { (pokemon1, pokemon2) -> Bool in
            return pokemon1.number < pokemon2.number
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        guard let treiner = treiner else {
            return
        }
        
        for selectedPokemon in treiner.pokemons {
            
            if let pokemonIndex = pokemons.index(of: selectedPokemon) {
                let indexPath = IndexPath(row: pokemonIndex, section: 0)
                
                tableView.selectRow(at: indexPath, animated: false, scrollPosition: .none)
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return pokemons.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PokemonCell", for: indexPath) as! PokemonCell

        let pokemon = pokemons[indexPath.row]
        
        cell.pokemonNameLabel.text = pokemon.name
        cell.pokemonNumberLabel.text = "# \(pokemon.number)"
        cell.pokemonPicture.image = UIImage(named: pokemon.name)
        
        return cell
    }
    
    fileprivate func dismiss() {
        self.dismiss(animated: true, completion: nil)
    }
    
    fileprivate func showAlert() {
        
        let alert = UIAlertController(title: "Fail", message: "You can't have more than five pokemons", preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
        
        alert.addAction(okAction)
        
        self.present(alert, animated: true, completion: nil)
    }
    
    // MARK: - Table view delegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let pokemon = pokemons[indexPath.row]
        
        do {
            try treiner?.addPokemon(pokemon)
        } catch {
            tableView.deselectRow(at: indexPath, animated: true)
            showAlert()
        }
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        let pokemon = pokemons[indexPath.row]
        treiner?.removePokemon(pokemon)
    }
    
    // MARK: - Actions

    @IBAction func done(_ sender: UIBarButtonItem) {
        
        dismiss()
    }
}
