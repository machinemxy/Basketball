//
//  MatchTableViewController.swift
//  Basketball
//
//  Created by 马学渊 on 2018/03/18.
//  Copyright © 2018年 Ma Xueyuan. All rights reserved.
//

import UIKit
import Realm
import RealmSwift

class MatchTableViewController: UITableViewController {
	var tournaments: Results<Tournament>!
	var matches: Results<Match>!

    override func viewDidLoad() {
        super.viewDidLoad()
		
		fetchMatches()
    }
	
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return tournaments.count
    }
	
	override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
		return tournaments[section].name
	}

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        let tournamentId = tournaments[section].id
		return matches.filter("tournamentId == %@", tournamentId).count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "matchCell", for: indexPath)

		let tournamentId = tournaments[indexPath.section].id
		let currentMatch = matches.filter("tournamentId == %@", tournamentId)[indexPath.row]
		
		cell.textLabel?.text = "VS " + currentMatch.oppoTeam
		cell.detailTextLabel?.text = currentMatch.roundName

        return cell
    }
	
	// MARK: - Table view delegate
	override func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
		print("chicken")
	}

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
	
	//private
	private func fetchMatches() {
		let realm = try! Realm()
		tournaments = realm.objects(Tournament.self).filter("available == true")
		matches = realm.objects(Match.self).filter("available == true")
	}
}
