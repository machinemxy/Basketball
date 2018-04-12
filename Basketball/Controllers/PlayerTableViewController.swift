//
//  PlayerTableViewController.swift
//  Basketball
//
//  Created by 马学渊 on 2018/03/21.
//  Copyright © 2018年 Ma Xueyuan. All rights reserved.
//

import UIKit
import Realm
import RealmSwift

class PlayerTableViewController: UITableViewController {
	var myPlayers: Results<Player>?

    override func viewDidLoad() {
        super.viewDidLoad()
		
		fetchMyPlayers()
    }

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		if let numberOfRows = myPlayers?.count {
			return numberOfRows
		} else {
			return 0
		}
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "playerCell", for: indexPath)

		if let myPlayer = myPlayers?[indexPath.row] {
			cell.textLabel?.text = myPlayer.name
			let detail = "LV: \(myPlayer.lv)  Overall: \(myPlayer.overall)"
			cell.detailTextLabel?.text = detail
			if myPlayer.pos > 0 {
				cell.imageView?.image = UIImage(named: myPlayer.posName)
			} else {
				cell.imageView?.image = nil
			}
		}

        return cell
    }

	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		super.prepare(for: segue, sender: sender)
		
		if segue.identifier == "showPlayerDetail" {
			let indexPath = tableView.indexPathForSelectedRow!
			let selectedPlayer = myPlayers![indexPath.row]
			let playerDetailViewController = segue.destination as! PlayerDetialViewController
			playerDetailViewController.player = selectedPlayer
		}
	}
	
	@IBAction func unwindToPlayerTableView(segue: UIStoryboardSegue) {
		fetchMyPlayers()
		tableView.reloadData()
	}
	
	private func fetchMyPlayers() {
		let playerSortor = [SortDescriptor(keyPath: "pos", ascending: false),
							SortDescriptor(keyPath: "lv", ascending: false)]
		
		let realm = try! Realm()
		myPlayers = realm.objects(Player.self).sorted(by: playerSortor)
	}
}
