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

    }
	
	override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(animated)
		
		let playerSortor = [SortDescriptor(keyPath: "role", ascending: false),
							SortDescriptor(keyPath: "lv", ascending: false)]
		
		let realm = try! Realm()
		myPlayers = realm.objects(Player.self).sorted(by: playerSortor)
		tableView.reloadData()
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
			cell.textLabel?.text = myPlayer.localizedName
			let detail = NSLocalizedString("LV: ", comment: "") + "\(myPlayer.lv)" + NSLocalizedString("  Overall: ", comment: "") + "\(myPlayer.overall)"
			cell.detailTextLabel?.text = detail
			if myPlayer.role > 0 {
				cell.imageView?.image = UIImage(named: myPlayer.roleName)
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
		
	}
	
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */	
}
