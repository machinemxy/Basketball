//
//  Player.swift
//  Basketball
//
//  Created by 马学渊 on 2018/03/22.
//  Copyright © 2018年 Ma Xueyuan. All rights reserved.
//

import UIKit
import Realm
import RealmSwift

class Player: Object {
	@objc dynamic var id = 0
	@objc dynamic var nameEn = ""
	@objc dynamic var nameJa = ""
	@objc dynamic var nameZh = ""
	@objc dynamic var portrait = ""
	@objc dynamic var itlBase = 0
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
	@objc dynamic var itl = 0
	@objc dynamic var spd = 0
	@objc dynamic var str = 0
	@objc dynamic var off = 0
	@objc dynamic var def = 0
	@objc dynamic var plm = 0
	@objc dynamic var stl = 0
	@objc dynamic var reb = 0
	@objc dynamic var pos = 0
	@objc dynamic var trait1id = ""
	@objc dynamic var trait2id = ""
	
	override static func primaryKey() -> String? {
		return "id"
	}
	
	override static func indexedProperties() -> [String] {
		return ["pos"]
	}
	
	static func generate(baseOn base: PlayerBase) -> Player {
		let player = Player()
		player.id = base.id
		player.nameEn = base.nameEn
		player.nameJa = base.nameJa
		player.nameZh = base.nameZh
		player.portrait = base.portrait
		player.itlBase = base.itlBase
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
		player.trait1id = base.trait1id
		
		player.autoSetAbilities()
		
		return player
	}
	
	var overall: Int {
		return itl + spd + str + off + def + plm + stl + reb
	}
	
	var name: String {
		guard let language = NSLocale.current.languageCode else {
			return nameEn
		}
		
		switch language {
		case "ja":
			return nameJa
		case "zh":
			return nameZh
		default:
			return nameEn
		}
	}
	
	var posName: String {
		switch self.pos {
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
			return "-"
		}
	}

	private func autoSetAbilities() {
		let multiplier = lv + 9
		itl = itlBase * multiplier
		spd = spdBase * multiplier
		str = strBase * multiplier
		off = offBase * multiplier
		def = defBase * multiplier
		plm = plmBase * multiplier
		stl = stlBase * multiplier
		reb = rebBase * multiplier
	}
	
	func getTrait(traitOrder: TraitOrder) -> Trait? {
		let traitId = traitOrder == .first ? self.trait1id : self.trait2id
		
		if traitId == "" {
			return nil
		}
		
		let realm = try! Realm()
		return realm.object(ofType: Trait.self, forPrimaryKey: traitId)
	}
	
	func getTraitIcon(traitOrder: TraitOrder) -> UIImage? {
		let traitId = traitOrder == .first ? self.trait1id : self.trait2id
		let imgName = traitId == "" ? "blank" : traitId
		return UIImage(named: imgName)
	}
}
