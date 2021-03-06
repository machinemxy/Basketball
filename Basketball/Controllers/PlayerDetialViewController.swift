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
	var player: Player!
	var readOnly = false
	
	@IBOutlet weak var lblName: UILabel!
	@IBOutlet weak var lblLV: UILabel!
	@IBOutlet weak var lblEXP: UILabel!
	@IBOutlet weak var lblItl: UILabel!
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
	@IBOutlet weak var btnCurrentPos: UIButton!
	@IBOutlet weak var lblInfo: UILabel!
	@IBOutlet weak var btnTrait1: UIButton!
	@IBOutlet weak var btnTrait2: UIButton!
	
	@IBAction func changePos(_ sender: UIButton) {
		showPosActionSheet(sender)
	}
	
	@IBAction func itlPressed(_ sender: Any) {
		lblInfo.text = NSLocalizedString("ITL intro", comment: "")
	}
	
	@IBAction func spdPressed(_ sender: Any) {
		lblInfo.text = NSLocalizedString("SPD intro", comment: "")
	}
	
	@IBAction func strPressed(_ sender: Any) {
		lblInfo.text = NSLocalizedString("STR intro", comment: "")
	}
	
	@IBAction func offPressed(_ sender: Any) {
		lblInfo.text = NSLocalizedString("OFF intro", comment: "")
	}
	
	@IBAction func defPressed(_ sender: Any) {
		lblInfo.text = NSLocalizedString("DEF intro", comment: "")
	}
	
	@IBAction func plmPressed(_ sender: Any) {
		lblInfo.text = NSLocalizedString("PLM intro", comment: "")
	}
	
	@IBAction func stlPressed(_ sender: Any) {
		lblInfo.text = NSLocalizedString("STL intro", comment: "")
	}
	
	@IBAction func rebPressed(_ sender: Any) {
		lblInfo.text = NSLocalizedString("REB intro", comment: "")
	}
	
	@IBAction func posPressed(_ sender: Any) {
		lblInfo.text = NSLocalizedString("POS intro", comment: "")
	}
	
	@IBAction func traitsPressed(_ sender: Any) {
		lblInfo.text = NSLocalizedString("Traits intro", comment: "")
	}
	
	@IBAction func tendencyPressed(_ sender: Any) {
		lblInfo.text = NSLocalizedString("Tendency intro", comment: "")
	}
	
	@IBAction func trait1Pressed(_ sender: Any) {
		if let trait = player.getTrait(traitOrder: .first) {
			lblInfo.text = trait.info
		}
	}
	
	@IBAction func trait2Pressed(_ sender: Any) {
		if let trait = player.getTrait(traitOrder: .second) {
			lblInfo.text = trait.info
		}
	}
	
	
	override func viewDidLoad() {
        super.viewDidLoad()
		
        setView()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if readOnly {
			return
		}
		
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
		lblName.text = player.name
		lblLV.text = "LV: \(player.lv)"
		lblEXP.text = "EXP: \(player.exp)/100"
		lblItl.text = "\(player.itl)"
		lblSpd.text = "\(player.spd)"
		lblStr.text = "\(player.str)"
		lblOff.text = "\(player.off)"
		lblDef.text = "\(player.def)"
		lblPlm.text = "\(player.plm)"
		lblStl.text = "\(player.stl)"
		lblReb.text = "\(player.reb)"
		btnCurrentPos.setTitle(player.posName, for: .normal)
		swShoot.isOn = player.willShoot
		swBreak.isOn = player.willBreakthrough
		swInside.isOn = player.willInsideScoring
		btnTrait1.setImage(player.getTraitIcon(traitOrder: .first), for: .normal)
		btnTrait2.setImage(player.getTraitIcon(traitOrder: .second), for: .normal)
		
		if readOnly {
			btnCurrentPos.isEnabled = false
			swShoot.isEnabled = false
			swBreak.isEnabled = false
			swInside.isEnabled = false
		}
	}
	
	private func showPosActionSheet(_ sender: UIButton) {
		let posActionSheet = UIAlertController(title: NSLocalizedString("Please choose", comment: ""), message: nil, preferredStyle: .actionSheet)
		
		let cAction = UIAlertAction(title: "C", style: .default) { (_) in
			self.performPosChanging(pos: 5)
		}
		posActionSheet.addAction(cAction)
		
		let pfAction = UIAlertAction(title: "PF", style: .default) { (_) in
			self.performPosChanging(pos: 4)
		}
		posActionSheet.addAction(pfAction)
		
		let sfAction = UIAlertAction(title: "SF", style: .default) { (_) in
			self.performPosChanging(pos: 3)
		}
		posActionSheet.addAction(sfAction)
		
		let sgAction = UIAlertAction(title: "SG", style: .default) { (_) in
			self.performPosChanging(pos: 2)
		}
		posActionSheet.addAction(sgAction)
		
		let pgAction = UIAlertAction(title: "PG", style: .default) { (_) in
			self.performPosChanging(pos: 1)
		}
		posActionSheet.addAction(pgAction)
		
		let noneAction = UIAlertAction(title: "-", style: .default) { (_) in
			self.performPosChanging(pos: 0)
		}
		posActionSheet.addAction(noneAction)
		
		let cancelAction = UIAlertAction(title: NSLocalizedString("Cancel", comment: ""), style: .cancel, handler: nil)
		posActionSheet.addAction(cancelAction)
		//iPad crash avoid
		posActionSheet.popoverPresentationController?.sourceView = view
		posActionSheet.popoverPresentationController?.sourceRect = sender.frame
		
		self.present(posActionSheet, animated: true, completion: nil)
	}
	
	private func performPosChanging(pos: Int) {
		let realm = try! Realm()
		try! realm.write {
			//change the position of current player in that position to none
			if pos != 0 {
				if let currentPosPlayer = realm.objects(Player.self).filter("pos = \(pos)").first {
					currentPosPlayer.pos = 0
				}
			}
			
			//assign the player to play in that position
			player.pos = pos
		}
		
		//refresh the pisition
		btnCurrentPos.setTitle("\(player.posName)", for: .normal)
	}
}
