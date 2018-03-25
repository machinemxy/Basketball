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
	let realm = try! Realm()
	var myPlayers: Results<Player>?

    override func viewDidLoad() {
        super.viewDidLoad()

		if realm.objects(Player.self).count == 0 {
			generateDefaultPlayers()
		}
    }
	
	override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(animated)
		
		myPlayers = realm.objects(Player.self)
		tableView.reloadData()
	}

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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

		if let tempMyPlayers = self.myPlayers {
			let tempMyPlayer = tempMyPlayers[indexPath.row]
			cell.textLabel?.text = tempMyPlayer.name
			let detail = NSLocalizedString("LV: ", comment: "") + "\(tempMyPlayer.lv)" + NSLocalizedString("  Overall: ", comment: "") + "\(tempMyPlayer.overall)"
			cell.detailTextLabel?.text = detail
		}

        return cell
    }

	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		super.prepare(for: segue, sender: sender)
		
		if segue.identifier == "showPlayerDetail" {
			//do something
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
	private func generateDefaultPlayers() {
		let generatedPlayers: [Player] = JsonHelper.parse(jsonFileName: "DefaultPlayers")
		
		for generatedPlayer in generatedPlayers {
			generatedPlayer.exp = 50
			generatedPlayer.isMyPlayer = true
			generatedPlayer.autoSetAbilities()
		}
		
		try! realm.write {
			realm.add(generatedPlayers)
		}
	}
}
