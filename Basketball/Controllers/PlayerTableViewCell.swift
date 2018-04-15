//
//  PlayerTableViewCell.swift
//  Basketball
//
//  Created by 马学渊 on 2018/04/15.
//  Copyright © 2018年 Ma Xueyuan. All rights reserved.
//

import UIKit

class PlayerTableViewCell: UITableViewCell {
	var player: Player!
	
	@IBOutlet weak var imgPosition: UIImageView!
	@IBOutlet weak var lblName: UILabel!
	@IBOutlet weak var lblDetail: UILabel!
	@IBOutlet weak var btnTrait1: UIButton!
	@IBOutlet weak var btnTrait2: UIButton!
	@IBAction func trait1Pressed(_ sender: Any) {
		print("not done yet")
	}
	@IBAction func trait2Pressed(_ sender: Any) {
		print("not done yet")
	}
	
	func setup(with player: Player) {
		self.player = player
		if player.pos > 0 {
			imgPosition.image = UIImage(named: player.posName)
		} else {
			imgPosition.image = UIImage(named: "blank")
		}
		lblName.text = player.name
		lblDetail.text = "LV: \(player.lv)  Overall: \(player.overall)"
		btnTrait1.setImage(player.getTraitIcon(traitOrder: .first), for: .normal)
		btnTrait2.setImage(player.getTraitIcon(traitOrder: .second), for: .normal)
	}
}
