//
//  Match.swift
//  Basketball
//
//  Created by 马学渊 on 2018/03/18.
//  Copyright © 2018年 Ma Xueyuan. All rights reserved.
//

import Foundation
import Realm
import RealmSwift

class Match: Object, Codable {
	@objc dynamic var id = 0
	@objc dynamic var tournamentId = 0
	@objc dynamic var round = 0
	@objc dynamic var oppoTeamEn = ""
	@objc dynamic var oppoTeamJa = ""
	@objc dynamic var oppoTeamZh = ""
	@objc dynamic var available = false
	@objc dynamic var awardTrait = ""
	@objc dynamic var nextMatchId = 0
	@objc dynamic var spNo = 0
	@objc dynamic var cleared = false
	
	override static func primaryKey() -> String? {
		return "id"
	}
	
	var roundName: String {
		switch round {
		case 99:
			return NSLocalizedString("Final", comment: "")
		case 98:
			return NSLocalizedString("Semifinal", comment: "")
		default:
			let rawRoundName = NSLocalizedString("Match #", comment: "")
			return rawRoundName.replacingOccurrences(of: "#", with: "\(round)")
		}
	}
	
	var oppoTeam: String {
		let language = Language.getCurrentLanguage()
		
		switch language {
		case .ja:
			return oppoTeamJa
		case .zh:
			return oppoTeamZh
		default:
			return oppoTeamEn
		}
	}
	
	
}
