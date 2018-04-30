//
//  OppoTeam.swift
//  Basketball
//
//  Created by 马学渊 on 2018/04/24.
//  Copyright © 2018年 Ma Xueyuan. All rights reserved.
//

import Foundation
import Realm
import RealmSwift

class OppoTeam: Object, Codable {
	@objc dynamic var matchId = 0
	@objc dynamic var lv = 0
	@objc dynamic var cId = 0
	@objc dynamic var pfId = 0
	@objc dynamic var sfId = 0
	@objc dynamic var sgId = 0
	@objc dynamic var pgId = 0
	@objc dynamic var cTrait = ""
	@objc dynamic var pfTrait = ""
	@objc dynamic var sfTrait = ""
	@objc dynamic var sgTrait = ""
	@objc dynamic var pgTrait = ""
	
	override static func primaryKey() -> String? {
		return "matchId"
	}
	
	func generatePlayers() -> [Player] {
		let realm = try! Realm()
		var players = [Player]()
		players.append(generatePlayer(realm: realm, pos: 5, playerId: cId, addTrait: cTrait))
		players.append(generatePlayer(realm: realm, pos: 4, playerId: pfId, addTrait: pfTrait))
		players.append(generatePlayer(realm: realm, pos: 3, playerId: sfId, addTrait: sfTrait))
		players.append(generatePlayer(realm: realm, pos: 2, playerId: sgId, addTrait: sgTrait))
		players.append(generatePlayer(realm: realm, pos: 1, playerId: pgId, addTrait: pgTrait))
		
		return players
	}
	
	private func generatePlayer(realm: Realm, pos: Int, playerId: Int, addTrait: String) -> Player {
		let playerBase = realm.object(ofType: PlayerBase.self, forPrimaryKey: playerId)!
		let player = Player.generate(baseOn: playerBase)
		player.lv = lv
		player.pos = pos
		player.trait2id = addTrait
		player.autoSetAbilities()
		
		return player
	}
}
