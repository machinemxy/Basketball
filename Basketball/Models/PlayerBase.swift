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

class PlayerBase: Object, Codable {
	@objc dynamic var name = ""
	@objc dynamic var portrait = ""
	@objc dynamic var lv = 1
	@objc dynamic var posBase = 0
	@objc dynamic var spdBase = 0
	@objc dynamic var strBase = 0
	@objc dynamic var offBase = 0
	@objc dynamic var defBase = 0
	@objc dynamic var plmBase = 0
	@objc dynamic var stlBase = 0
	@objc dynamic var rebBase = 0
	@objc dynamic var role = 0
	@objc dynamic var willShoot = false
	@objc dynamic var willBreakthrough = false
	@objc dynamic var willInsideScoring = false
	@objc dynamic var traits = ""
}
