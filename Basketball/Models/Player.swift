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

class Player: PlayerBase {
	@objc dynamic var exp = 0
	@objc dynamic var isMyPlayer = false
	@objc dynamic var pos = 0
	@objc dynamic var spd = 0
	@objc dynamic var str = 0
	@objc dynamic var off = 0
	@objc dynamic var def = 0
	@objc dynamic var plm = 0
	@objc dynamic var stl = 0
	@objc dynamic var reb = 0

	var overall: Int {
		get {
			return pos + spd + str + off + def + plm + stl + reb
		}
	}
	
	var localizedName: String {
		get {
			return NSLocalizedString(self.name, comment: "")
		}
	}

	func autoSetAbilities() {
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
