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

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tableView.reloadData()
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
        
        performSegue(withIdentifier: "DraftProkemons", sender: indexPath)
        
    }
    
    fileprivate func showAlert() {
        
        let alert = UIAlertController(title: "Fail", message: "Treiners have different numbers of pokemons", preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
        
        alert.addAction(okAction)
        
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func startBattle(_ sender: UIBarButtonItem) {
    
        let ash = TreinerManager.shared.ash
        let gary = TreinerManager.shared.gary
        
        let isStarted = TreinerManager.shared.startBattle(treiner: ash, otherTreiner: gary)
        
        if !isStarted {
            showAlert()
        }
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "DraftProkemons" {
            
            let selectedIndex = sender as! IndexPath
            
            let pokemonsController = segue.destination as! PokemonsViewController
            pokemonsController.treiner = TreinerManager.shared.allTreiners[selectedIndex.row]
        }
        
    }
}
