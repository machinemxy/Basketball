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
		
		if currentDBVersion != newestDBVersion {
			initDB()
			
			generateDefaultPlayers()
			
			UserDefaults.standard.set(newestDBVersion, forKey: DefaultKey.DB_VERSION)
		}
	}
	
	private func initDB() {
		//get playerBases from json file
		let playerBases: [PlayerBase] = JsonHelper.parse(jsonFileName: "PlayerBase")
		//get traits from json file
		let traits: [Trait] = JsonHelper.parse(jsonFileName: "Traits")
		
		let realm = try! Realm()
		try! realm.write {
			//delete old playerBases and insert new playerBases
			let oldPlayerBases = realm.objects(PlayerBase.self)
			realm.delete(oldPlayerBases)
			realm.add(playerBases)
			
			//delete old traits and insert new traits
			let oldTraits = realm.objects(Trait.self)
			realm.delete(oldTraits)
			realm.add(traits)
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
			
			//set the initial exp and position
			player.exp = 50
			if i <= 5 {
				player.pos = i
			}
			players.append(player)
		}
		
		try! realm.write {
			realm.add(players)
		}
	}
}

