//
//  OppoTeamTableViewController.swift
//  Basketball
//
//  Created by 马学渊 on 2018/04/24.
//  Copyright © 2018年 Ma Xueyuan. All rights reserved.
//

import UIKit
import Realm
import RealmSwift

class OppoTeamTableViewController: UITableViewController, PlayerTableViewCellProtocal {

	var matchId: Int!
	var players: [Player]!
	
    override func viewDidLoad() {
        super.viewDidLoad()

        let realm = try! Realm()
		let oppoTeam = realm.object(ofType: OppoTeam.self, forPrimaryKey: matchId)!
		players = oppoTeam.generatePlayers()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return players.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "playerCell", for: indexPath) as! PlayerTableViewCell
		let player = players[indexPath.row]
		cell.setup(with: player)
		cell.delegate = self
		return cell
    }

	
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if segue.identifier == "oppoPlayerDetailSegue" {
			let indexPath = tableView.indexPathForSelectedRow!
			let selectedPlayer = players[indexPath.row]
			let targetController = segue.destination as! PlayerDetialViewController
			targetController.player = selectedPlayer
			targetController.readOnly = true
		}
    }
	
	@IBAction func unwindToOppoTeamTableView(segue: UIStoryboardSegue) {
		
	}
	
	//Delegation
	func showTraitAlert(traitAlertController: UIAlertController) {
		self.present(traitAlertController, animated: true, completion: nil)
	}
	
	override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		return 44.0
	}
}
