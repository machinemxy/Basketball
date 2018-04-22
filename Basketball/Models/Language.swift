//
//  Language.swift
//  Basketball
//
//  Created by 马学渊 on 2018/04/21.
//  Copyright © 2018年 Ma Xueyuan. All rights reserved.
//

import Foundation

enum Language {
	case en
	case ja
	case zh
	
	static func getCurrentLanguage() -> Language {
		guard let language = NSLocale.current.languageCode else {
			return .en
		}
		
		switch language {
		case "ja":
			return .ja
		case "zh":
			return .zh
		default:
			return .en
		}
	}
}
