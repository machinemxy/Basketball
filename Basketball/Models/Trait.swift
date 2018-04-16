//
//  Trait.swift
//  Basketball
//
//  Created by 马学渊 on 2018/04/12.
//  Copyright © 2018年 Ma Xueyuan. All rights reserved.
//

import UIKit
import Realm
import RealmSwift

class Trait: Object, Codable {
	@objc dynamic var identifier = ""
	@objc dynamic var nameEn = ""
	@objc dynamic var nameJa = ""
	@objc dynamic var nameZh = ""
	@objc dynamic var infoEn = ""
	@objc dynamic var infoJa = ""
	@objc dynamic var infoZh = ""
	@objc dynamic var owned = false
	
	override static func primaryKey() -> String? {
		return "identifier"
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
	
	var info: String {
		guard let language = NSLocale.current.languageCode else {
			return infoEn
		}
		
		switch language {
		case "ja":
			return infoJa
		case "zh":
			return infoZh
		default:
			return infoEn
		}
	}
	
	var icon: UIImage {
		return UIImage(named: identifier)!
	}
	
	func createTraitAlertController() -> UIAlertController {
		let traitAlertControlelr = UIAlertController(title: name, message: info, preferredStyle: .alert)
		let action = UIAlertAction(title: NSLocalizedString("Close", comment: ""), style: .default, handler: nil)
		traitAlertControlelr.addAction(action)
		return traitAlertControlelr
	}
}
