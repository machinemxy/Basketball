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
	@IBOutlet weak var lblInfo: UILabel!
	
	@IBAction func changeRole(_ sender: Any) {
		showRoleActionSheet()
	}
	
	@IBAction func btnPosClicked(_ sender: Any) {
		lblInfo.text = NSLocalizedString("Player's position awareness. Affect the offense and defence of shooting.", comment: "")
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
		let roleActionSheet = UIAlertController(title: NSLocalizedString("Please choose", comment: ""), message: "", preferredStyle: .actionSheet)
		
		let cAction = UIAlertAction(title: "C", style: .default) { (_) in
			self.performRoleChanging(role: 5)
		}
		roleActionSheet.addAction(cAction)
		
		let pfAction = UIAlertAction(title: "PF", style: .default) { (_) in
			self.performRoleChanging(role: 4)
		}
		roleActionSheet.addAction(pfAction)
		
		let sfAction = UIAlertAction(title: "SF", style: .default) { (_) in
			self.performRoleChanging(role: 3)
		}
		roleActionSheet.addAction(sfAction)
		
		let sgAction = UIAlertAction(title: "SG", style: .default) { (_) in
			self.performRoleChanging(role: 2)
		}
		roleActionSheet.addAction(sgAction)
		
		let pgAction = UIAlertAction(title: "PG", style: .default) { (_) in
			self.performRoleChanging(role: 1)
		}
		roleActionSheet.addAction(pgAction)
		
		let noneAction = UIAlertAction(title: "None", style: .default) { (_) in
			self.performRoleChanging(role: 0)
		}
		roleActionSheet.addAction(noneAction)
		
		let cancelAction = UIAlertAction(title: NSLocalizedString("Cancel", comment: ""), style: .cancel, handler: nil)
		roleActionSheet.addAction(cancelAction)
		
		self.present(roleActionSheet, animated: true, completion: nil)
	}
	
	private func performRoleChanging(role: Int) {
		let realm = try! Realm()
		try! realm.write {
			//change the role of current player in that role to none
			if role != 0 {
				if let currentRolePlayer = realm.objects(Player.self).filter("role = \(role)").first {
					currentRolePlayer.role = 0
				}
			}
			
			//assign the player to play in that role
			player.role = role
		}
		
		//refresh the role
		btnCurrentRole.setTitle("\(player.roleName)", for: .normal)
	}
}
