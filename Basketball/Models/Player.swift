//
//  Player.swift
//  Basketball
//
//  Created by 马学渊 on 2018/03/22.
//  Copyright © 2018年 Ma Xueyuan. All rights reserved.
//

import Foundation
import Realm
import RealmSwift

class Player: Object {
	@objc dynamic var id = 0
	@objc dynamic var name = ""
	@objc dynamic var portrait = ""
	@objc dynamic var posBase = 0
	@objc dynamic var spdBase = 0
	@objc dynamic var strBase = 0
	@objc dynamic var offBase = 0
	@objc dynamic var defBase = 0
	@objc dynamic var plmBase = 0
	@objc dynamic var stlBase = 0
	@objc dynamic var rebBase = 0
	@objc dynamic var willShoot = false
	@objc dynamic var willBreakthrough = false
	@objc dynamic var willInsideScoring = false
	@objc dynamic var lv = 1
	@objc dynamic var exp = 0
	@objc dynamic var pos = 0
	@objc dynamic var spd = 0
	@objc dynamic var str = 0
	@objc dynamic var off = 0
	@objc dynamic var def = 0
	@objc dynamic var plm = 0
	@objc dynamic var stl = 0
	@objc dynamic var reb = 0
	@objc dynamic var role = 0
	
	override static func primaryKey() -> String? {
		return "id"
	}
	
	override static func indexedProperties() -> [String] {
		return ["role"]
	}
	
	static func generate(baseOn base: PlayerBase) -> Player {
		let player = Player()
		player.id = base.id
		player.name = base.name
		player.portrait = base.portrait
		player.posBase = base.posBase
		player.spdBase = base.spdBase
		player.strBase = base.strBase
		player.offBase = base.offBase
		player.defBase = base.defBase
		player.plmBase = base.plmBase
		player.stlBase = base.stlBase
		player.rebBase = base.rebBase
		player.willShoot = base.willShoot
		player.willBreakthrough = base.willBreakthrough
		player.willInsideScoring = base.willInsideScoring
		
		player.autoSetAbilities()
		
		return player
	}
	
	var overall: Int {
		return pos + spd + str + off + def + plm + stl + reb
	}
	
	var localizedName: String {
		return NSLocalizedString(self.name, comment: "")
	}
	
	var roleName: String {
		switch self.role {
		case 1:
			return "PG"
		case 2:
			return "SG"
		case 3:
			return "SF"
		case 4:
			return "PF"
		case 5:
			return "C"
		default:
			return "None"
		}
	}

	private func autoSetAbilities() {
		let multiplier = lv + 9
		pos = posBase * multiplier
		spd = spdBase * multiplier
		str = strBase * multiplier
		off = offBase * multiplier
		def = defBase * multiplier
		plm = plmBase * multiplier
		stl = stlBase * multiplier
		reb = rebBase * multiplier
	}
}
