//
//  Tornament.swift
//  Basketball
//
//  Created by 马学渊 on 2018/03/18.
//  Copyright © 2018年 Ma Xueyuan. All rights reserved.
//

import Foundation
import Realm
import RealmSwift

class Tournament: Object, Codable {
	@objc dynamic var id = 0
	@objc dynamic var nameEn = ""
	@objc dynamic var nameJa = ""
	@objc dynamic var nameZh = ""
	@objc dynamic var available = false
	@objc dynamic var myTeamEn = ""
	@objc dynamic var myTeamJa = ""
	@objc dynamic var myTeamZh = ""
	
	override static func primaryKey() -> String? {
		return "id"
	}
	
	var name: String {
		let language = Language.getCurrentLanguage()
		
		switch language {
		case .ja:
			return nameJa
		case .zh:
			return nameZh
		default:
			return nameEn
		}
	}
	
	var myTeam: String {
		let language = Language.getCurrentLanguage()
		
		switch language {
		case .ja:
			return myTeamJa
		case .zh:
			return myTeamZh
		default:
			return myTeamEn
		}
	}
}
