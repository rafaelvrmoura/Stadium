//
//  TeamsViewController.swift
//  Stadium
//
//  Created by Rafael Moura on 16/11/16.
//  Copyright © 2016 BEPiD. All rights reserved.
//

import UIKit

class TreinersViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return TreinerManager.shared.allTreiners.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TreinerCell", for: indexPath) as! TreinerCell
        
        let treiner = TreinerManager.shared.allTreiners[indexPath.row]
        let numberOfPokemons = treiner.pokemons.count
        
        
        cell.treinerNameLabel.text = treiner.name
        cell.pokemonsCountLabel.text = numberOfPokemons == 1 ? "1 Pokemon" : "\(numberOfPokemons) Pokemons"
        cell.treinerPicture.image = UIImage(named: treiner.name)
        
        return cell
    }
    
    // MARK: - Table view delegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        performSegue(withIdentifier: "DraftProkemons", sender: nil)
        
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "DraftProkemons" {
            
            let pokemonsController = segue.destination as! PokemonsViewController
            
        }
        
    }
}
