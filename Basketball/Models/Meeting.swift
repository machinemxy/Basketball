//
//  Meeting.swift
//  Basketball
//
//  Created by 马学渊 on 2018/04/23.
//  Copyright © 2018年 Ma Xueyuan. All rights reserved.
//

import Foundation
import Realm
import RealmSwift

class Meeting: Object, Codable {
	@objc dynamic var matchId = 0
	@objc dynamic var portrait = ""
	@objc dynamic var speechEn = ""
	@objc dynamic var speechJa = ""
	@objc dynamic var speechZh = ""
	
	override static func primaryKey() -> String? {
		return "matchId"
	}
	
	var speech: String {
		let language = Language.getCurrentLanguage()
		
		switch language {
		case .ja:
			return speechJa
		case .zh:
			return speechZh
		default:
			return speechEn
		}
	}
}
