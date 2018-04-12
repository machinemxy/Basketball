//
//  MatchTableViewController.swift
//  Basketball
//
//  Created by 马学渊 on 2018/03/18.
//  Copyright © 2018年 Ma Xueyuan. All rights reserved.
//

import UIKit

class MatchTableViewController: UITableViewController {
	var allTornaments = [Tornament]()
	var tornaments = [Tornament]()

    override func viewDidLoad() {
        super.viewDidLoad()
		
		allTornaments = JsonHelper.parse(jsonFileName: "Tornaments")
		setAvailableTornaments()
    }
	
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return tornaments.count
    }
	
	override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
		return tornaments[section].name
	}

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return tornaments[section].matches.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "matchCell", for: indexPath)

        // Configure the cell...
		cell.textLabel?.text = tornaments[indexPath.section].matches[indexPath.row].name
		cell.detailTextLabel?.text = tornaments[indexPath.section].matches[indexPath.row].localizedSubtitle

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
	
	private func fetchAllTornaments() {
		let jsonDecoder = JSONDecoder()
		if let tornamentsFile = Bundle.main.path(forResource: "Tornaments", ofType: "json") {
			let data = try! Data(contentsOf: URL(fileURLWithPath: tornamentsFile))
			allTornaments = try! jsonDecoder.decode([Tornament].self, from: data)
		}
	}
	
	private func setAvailableTornaments() {
		let maxTornamentId = UserDefaults.standard.integer(forKey: DefaultKey.TORNAMENT)
		let maxMatchId = UserDefaults.standard.integer(forKey: DefaultKey.MATCH)
		
		tornaments = [Tornament]()
		for i in 0...maxTornamentId {
			tornaments.append(allTornaments[i])
			if i == maxTornamentId {
				tornaments[i].matches = [Match]()
				for match in allTornaments[i].matches {
					if match.id <= maxMatchId {
						tornaments[i].matches.append(match)
					} else {
						break
					}
				}
			}
		}
	}
}
