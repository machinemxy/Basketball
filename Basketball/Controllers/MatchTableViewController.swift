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
	var selectedMatchId: Int!
	var selectedMatch: Match!
	var selectedTournament: Tournament!

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
		let tournamentId = tournaments[indexPath.section].id
		let currentMatch = matches.filter("tournamentId == %@", tournamentId)[indexPath.row]
		selectedMatchId = currentMatch.id
		performSegue(withIdentifier: "meetingSegue", sender: nil)
	}

	override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		if isMyTeamValidate() {
			//segue to versusSegue
			selectedTournament = tournaments[indexPath.section]
			let tournamentId = selectedTournament.id
			selectedMatch = matches.filter("tournamentId == %@", tournamentId)[indexPath.row]
			performSegue(withIdentifier: "versusSegue", sender: nil)
		} else {
			//alert
			let alertController = UIAlertController(title: NSLocalizedString("To join the match, each position need one player.", comment: ""), message: "", preferredStyle: .alert)
			let alertAction = UIAlertAction(title: NSLocalizedString("Close", comment: ""), style: .default, handler: nil)
			alertController.addAction(alertAction)
			self.present(alertController, animated: true, completion: nil)
		}
	}

    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if segue.identifier == "meetingSegue" {
			let meetingViewController = segue.destination as! MeetingViewController
			meetingViewController.matchId = selectedMatchId
		} else if segue.identifier == "versusSegue" {
			let versusViewController = segue.destination as! VersusViewController
			versusViewController.tournament = selectedTournament
			versusViewController.match = selectedMatch
		}
    }

	@IBAction func unwindToMatchTableView(segue: UIStoryboardSegue) {
		
	}
	
	@IBAction func unwindToMatchTableViewWithReload(segue: UIStoryboardSegue) {
		fetchMatches()
		tableView.reloadData()
	}
	
	//private
	private func fetchMatches() {
		let realm = try! Realm()
		tournaments = realm.objects(Tournament.self).filter("available == true")
		matches = realm.objects(Match.self).filter("available == true")
	}
	
	private func isMyTeamValidate() -> Bool {
		let realm = try! Realm()
		let players = realm.objects(Player.self)
		//check each position, there should be one player play that position
		for i in 1...5 {
			if players.filter("pos == %@", i).count != 1 {
				return false
			}
		}
		return true
	}
}
