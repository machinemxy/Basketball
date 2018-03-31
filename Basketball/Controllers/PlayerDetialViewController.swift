//
//  PlayerDetialViewController.swift
//  Basketball
//
//  Created by 马学渊 on 2018/03/25.
//  Copyright © 2018年 Ma Xueyuan. All rights reserved.
//

import UIKit
import Realm
import RealmSwift

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
	@IBOutlet weak var swShoot: UISwitch!
	@IBOutlet weak var swBreak: UISwitch!
	@IBOutlet weak var swInside: UISwitch!
	@IBOutlet weak var btnCurrentRole: UIButton!
	
	@IBAction func changeRole(_ sender: Any) {
		//working...
	}
	
    override func viewDidLoad() {
        super.viewDidLoad()

        setView()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //update player
		let realm = try! Realm()
		try! realm.write {
			player.willShoot = swShoot.isOn
			player.willBreakthrough = swBreak.isOn
			player.willInsideScoring = swInside.isOn
		}
    }
	
	private func setView() {
		if player.portrait != "" {
			imgPortrait.image = UIImage(named: player.portrait)
		}
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
		btnCurrentRole.setTitle(player.roleName, for: .normal)
		swShoot.isOn = player.willShoot
		swBreak.isOn = player.willBreakthrough
		swInside.isOn = player.willInsideScoring
	}
	
	private func showRoleActionSheet() {
		let roleActionSheet = UIAlertController(title: "", message: "", preferredStyle: .actionSheet)
		
	}
	
	func showSimpleDialog(title: String) {
		let alertController = UIAlertController(title: title, message: "", preferredStyle: .alert)
		let alertAction = UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: .default, handler: nil)
		alertController.addAction(alertAction)
		self.present(alertController, animated: true, completion: nil)
	}
}
