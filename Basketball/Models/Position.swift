//
//  Position.swift
//  Basketball
//
//  Created by 马学渊 on 2018/06/04.
//  Copyright © 2018年 Ma Xueyuan. All rights reserved.
//

import Foundation

class Position {
	var player: Player
	var offChance = 20
	var rebMultiplier: Int
	var plmMultiplier: Int
	var stlMultiplier: Int
	var itlRt: Int
	var spdRt: Int
	var strRt: Int
	var offRt: Int
	var defRt: Int
	var plmRt: Int
	var stlRt: Int
	var rebRt: Int
	
	init(player: Player) {
		self.player = player
		
		//set real time abilities
		itlRt = player.itl
		spdRt = player.spd
		strRt = player.str
		offRt = player.off
		defRt = player.def
		plmRt = player.plm
		stlRt = player.stl
		rebRt = player.reb
		
		//set the multiplier depends on the position
		rebMultiplier = player.pos
		plmMultiplier = 6 - player.pos
		stlMultiplier = 6 - player.pos
	}
}
