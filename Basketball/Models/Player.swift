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
	@objc dynamic var playMaking = 0
	@objc dynamic var steal = 0
	@objc dynamic var rebound = 0

	var overall: Int {
		get {
			return pos + spd + str + off + def + playMaking + steal + rebound
		}
	}

	func autoSetAbilities() {
		let multiplier = lv + 9
		pos = posBase * multiplier
		spd = spdBase * multiplier
		str = strBase * multiplier
		off = offBase * multiplier
		def = defBase * multiplier
		playMaking = playMakingBase * multiplier
		steal = stealBase * multiplier
		rebound = reboundBase * multiplier
	}
}
