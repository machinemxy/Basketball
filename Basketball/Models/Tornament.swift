//
//  Tornament.swift
//  Basketball
//
//  Created by 马学渊 on 2018/03/18.
//  Copyright © 2018年 Ma Xueyuan. All rights reserved.
//

import Foundation

struct Tornament: Codable {
	var id = 0
	var name = ""
	var matches = [Match]()
}
