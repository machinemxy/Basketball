//
//  Player.swift
//  Basketball
//
//  Created by 马学渊 on 2018/03/21.
//  Copyright © 2018年 Ma Xueyuan. All rights reserved.
//

import Foundation
import Realm
import RealmSwift

class Player: Object, Codable {
	@objc dynamic var name = ""
	@objc dynamic var PositioningBase = 0
	@objc dynamic var speedBase = 0
	@objc dynamic var strengthBase = 0
	@objc dynamic var offenseBase = 0
	@objc dynamic var defenceBess = 0
	@objc dynamic var playMakingBase = 0
	@objc dynamic var stealBase = 0
	@objc dynamic var reboundBase = 0
	@objc dynamic var role = 0
	@objc dynamic var willShoot = false
	@objc dynamic var willBreakthrough = false
	@objc dynamic var willInsideScoring = false
}
