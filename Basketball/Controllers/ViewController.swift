//
//  ViewController.swift
//  Basketball
//
//  Created by 马学渊 on 2018/03/18.
//  Copyright © 2018年 Ma Xueyuan. All rights reserved.
//

import UIKit
import Realm
import RealmSwift

class ViewController: UIViewController {

	override func viewDidLoad() {
		super.viewDidLoad()
		
		let currentDBVersion = UserDefaults.standard.integer(forKey: DefaultKey.DB_VERSION)
		
		//current DB Version is 1, if is smaller than this version,
		//we need to init the DB
		let newestDBVersion = 1
		
		//debug mode, each time init DB
		//if currentDBVersion != newestDBVersion {
			initDB()
			
			generateDefaultPlayers()
			
			UserDefaults.standard.set(newestDBVersion, forKey: DefaultKey.DB_VERSION)
		//}
	}
	
	// MARK: - Navigation
	@IBAction func unwindToTitle(segue: UIStoryboardSegue) {
		
	}
	
	private func initDB() {
		let playerBases: [PlayerBase] = JsonHelper.parse(jsonFileName: "PlayerBase")
		let traits: [Trait] = JsonHelper.parse(jsonFileName: "Traits")
		let tournaments: [Tournament] = JsonHelper.parse(jsonFileName: "Tournaments")
		let matches: [Match] = JsonHelper.parse(jsonFileName: "Matches")
		let meetings: [Meeting] = JsonHelper.parse(jsonFileName: "Meetings")
		let oppoTeams: [OppoTeam] = JsonHelper.parse(jsonFileName: "OppoTeam")
		
		let realm = try! Realm()
		try! realm.write {
			realm.deleteAll()
			realm.add(playerBases)
			realm.add(traits)
			realm.add(tournaments)
			realm.add(matches)
			realm.add(meetings)
			realm.add(oppoTeams)
		}
	}
	
	private func generateDefaultPlayers() {
		let realm = try! Realm()
		
		//only be executed when the first time user launched the app
		let playerCount = realm.objects(Player.self).count
		if playerCount > 0 {
			return
		}
		
		//generate
		var players = [Player]()
		
		//generate 6 members
		for i in 1...6 {
			guard let playerBase = realm.object(ofType: PlayerBase.self, forPrimaryKey: i) else {
				continue
			}
			let player = Player.generate(baseOn: playerBase)
			
			//set the initial exp, position and abilities
			player.exp = 50
			player.pos = player.posBase
			player.autoSetAbilities()
			
			players.append(player)
		}
		
		try! realm.write {
			realm.add(players)
		}
	}
}

