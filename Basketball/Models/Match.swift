//
//  Match.swift
//  Basketball
//
//  Created by 马学渊 on 2018/03/18.
//  Copyright © 2018年 Ma Xueyuan. All rights reserved.
//

import Foundation

struct Match: Codable {
	var id: Int
	var nameEn: String
	var nameJa: String
	var nameZh: String
	var subtitle: String
	
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
	
	var localizedSubtitle: String {
		return NSLocalizedString(subtitle, comment: "")
	}
}
