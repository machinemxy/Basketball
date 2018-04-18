//
//  TraitSetTableViewController.swift
//  Basketball
//
//  Created by 马学渊 on 2018/04/16.
//  Copyright © 2018年 Ma Xueyuan. All rights reserved.
//

import UIKit
import Realm
import RealmSwift

class TraitSetTableViewController: UITableViewController, PlayerTableViewCellProtocal {
	var trait: Trait!
	var players: Results<Player>!
	
	@IBOutlet weak var imgTrait: UIImageView!
	
    override func viewDidLoad() {
        super.viewDidLoad()
		imgTrait.image = trait.icon
		fetchAvaliablePlayers()
    }

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return players.count
    }

	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "playerCell", for: indexPath) as! PlayerTableViewCell
		let player = players[indexPath.row]
		cell.setup(with: player)
		cell.delegate = self
		return cell
	}
	
	//Delegation
	override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		var slot1 = NSLocalizedString("Slot 1", comment: "")
		if players[indexPath.row].trait1id != "" {
			slot1 += NSLocalizedString("(Overwrite)", comment: "")
		}
		
		var slot2 = NSLocalizedString("Slot 2", comment: "")
		if players[indexPath.row].trait2id != "" {
			slot2 += NSLocalizedString("(Overwrite)", comment: "")
		}
		
		let traitActionSheetController = UIAlertController(title: NSLocalizedString("Please choose slot", comment: ""), message: nil, preferredStyle: .actionSheet)
		
		let firstSlotAction = UIAlertAction(title: slot1, style: .default) { (_) in
			self.updateTraite(index: indexPath.row, traitOrder: .first)
			self.performSegue(withIdentifier: "unwindToTraitSegue", sender: nil)
		}
		traitActionSheetController.addAction(firstSlotAction)
		
		let secondSlotAction = UIAlertAction(title: slot2, style: .default) { (_) in
			self.updateTraite(index: indexPath.row, traitOrder: .second)
			self.performSegue(withIdentifier: "unwindToTraitSegue", sender: nil)
		}
		traitActionSheetController.addAction(secondSlotAction)
		
		let cancelAction = UIAlertAction(title: NSLocalizedString("Cancel", comment: ""), style: .cancel, handler: nil)
		traitActionSheetController.addAction(cancelAction)
		
		//iPad crash avoid
		traitActionSheetController.popoverPresentationController?.sourceView = view
		traitActionSheetController.popoverPresentationController?.sourceRect = (tableView.cellForRow(at: indexPath)?.frame)!
		
		self.present(traitActionSheetController, animated: true, completion: nil)
	}
	
	override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		return 44.0
	}
	
	func showTraitAlert(traitAlertController: UIAlertController) {
		self.present(traitAlertController, animated: true, completion: nil)
	}
	
	//private funcs
	private func fetchAvaliablePlayers() {
		let playerSortor = [SortDescriptor(keyPath: "pos", ascending: false),
							SortDescriptor(keyPath: "lv", ascending: false)]
		
		let realm = try! Realm()
		players = realm.objects(Player.self)
			.filter("trait1id != %@", trait.identifier)
			.filter("trait2id != %@", trait.identifier)
			.sorted(by: playerSortor)
	}
	
	private func updateTraite(index: Int, traitOrder: TraitOrder) {
		let player = players[index]
		
		let realm = try! Realm()
		try! realm.write {
			//remove the trait
			trait.owned = false
			
			//set the trait to player
			switch traitOrder {
			case .first:
				player.trait1id = trait.identifier
			default:
				player.trait2id = trait.identifier
			}
		}
		
		//set the player changed flag on
		UserDefaults.standard.set(true, forKey: DefaultKey.PLAYER_CHANGED)
	}
}
