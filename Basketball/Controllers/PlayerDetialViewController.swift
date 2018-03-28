//
//  PlayerDetialViewController.swift
//  Basketball
//
//  Created by 马学渊 on 2018/03/25.
//  Copyright © 2018年 Ma Xueyuan. All rights reserved.
//

import UIKit

class PlayerDetialViewController: UIViewController {
	var player = Player()
	
	@IBOutlet weak var lblName: UILabel!
	@IBOutlet weak var lblLV: UILabel!
	@IBOutlet weak var lblEXP: UILabel!
	@IBOutlet weak var lblPos: UILabel!
	@IBOutlet weak var lblSpd: UILabel!
	@IBOutlet weak var lblStr: UILabel!
	@IBOutlet weak var lblOff: UILabel!
	@IBOutlet weak var lblDef: UILabel!
	@IBOutlet weak var lblPlm: UILabel!
	@IBOutlet weak var lblStl: UILabel!
	@IBOutlet weak var lblReb: UILabel!
	@IBOutlet weak var imgPortrait: UIImageView!
	
    override func viewDidLoad() {
        super.viewDidLoad()

        setView()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
	
	private func setView() {
		lblName.text = player.localizedName
		lblLV.text = NSLocalizedString("LV: ", comment: "") + "\(player.lv)"
		lblEXP.text = NSLocalizedString("EXP: ", comment: "") + "\(player.exp)/100"
		lblPos.text = "\(player.pos)"
		lblSpd.text = "\(player.spd)"
		lblStr.text = "\(player.str)"
		lblOff.text = "\(player.off)"
		lblDef.text = "\(player.def)"
		lblPlm.text = "\(player.plm)"
		lblStl.text = "\(player.stl)"
		lblReb.text = "\(player.reb)"
		if player.portrait != "" {
			imgPortrait.image = UIImage(named: player.portrait)
		}
	}
}
