//
//  TraitSetTableViewController.swift
//  Basketball
//
//  Created by 马学渊 on 2018/04/16.
//  Copyright © 2018年 Ma Xueyuan. All rights reserved.
//

import UIKit
import Realm
import RealmSwift

class TraitSetTableViewController: UITableViewController, PlayerTableViewCellProtocal {
	var trait: Trait!
	var players: Results<Player>!
	
    override func viewDidLoad() {
        super.viewDidLoad()
		fetchAvaliablePlayers()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return players.count
    }

	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "playerCell", for: indexPath) as! PlayerTableViewCell
		let player = players[indexPath.row]
		cell.setup(with: player)
		cell.delegate = self
		return cell
	}
	
	//Delegation
	override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		
	}
	
	func showTraitAlert(traitAlertController: UIAlertController) {
		self.present(traitAlertController, animated: true, completion: nil)
	}
	
	
	
	// MARK: - Navigation
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		// Get the new view controller using segue.destinationViewController.
		// Pass the selected object to the new view controller.
	}
	
	//private funcs
	private func fetchAvaliablePlayers() {
		let playerSortor = [SortDescriptor(keyPath: "pos", ascending: false),
							SortDescriptor(keyPath: "lv", ascending: false)]
		
		let realm = try! Realm()
		players = realm.objects(Player.self).sorted(by: playerSortor)
	}
}
