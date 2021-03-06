//
//  AfterMatchViewController.swift
//  Basketball
//
//  Created by 马学渊 on 2018/05/05.
//  Copyright © 2018年 Ma Xueyuan. All rights reserved.
//

import UIKit
import Realm
import RealmSwift
import HandySwift

class AfterMatchViewController: UIViewController {
	var isWon: Bool!
	var match: Match!
	var oppoTeam: OppoTeam!
	
	@IBOutlet weak var lblInfo: UILabel!
	@IBOutlet var lblNames: [UILabel]!
	@IBOutlet var expBars: [UIProgressView]!
	@IBOutlet var lblLvBefores: [UILabel]!
	@IBOutlet var lblLvArrows: [UILabel]!
	@IBOutlet var lblLvAfters: [UILabel]!
	@IBOutlet var lblOverallBefores: [UILabel]!
	@IBOutlet var lblOverallArrows: [UILabel]!
	@IBOutlet var lblOverallAfters: [UILabel]!
	
	
	override func viewDidLoad() {
        super.viewDidLoad()
		
		let realm = try! Realm()
		try! realm.write {
			//get new trait
			getNewTrait(realm: realm)
			
			//get new player
			//not done yet
			
			//unlock new matches
			unlockNewMatch(realm: realm)
			
			//develop players
			developPlayers(realm: realm)
		}
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

	// MARK: private
	private func getNewTrait(realm: Realm) {
		//if lose, won't get
		if !isWon {
			return
		}
		
		//if not first time, won't get
		if match.cleared {
			return
		}
		
		//if no bonus trait, won't get
		if match.awardTrait == "" {
			return
		}
		
		//get the trait
		guard let trait = realm.object(ofType: Trait.self, forPrimaryKey: match.awardTrait) else {
			return
		}
		trait.owned = true
		UserDefaults.standard.set(true, forKey: DefaultKey.TRAIT_CHANGED)
	}
	
	private func unlockNewMatch(realm: Realm) {
		//if already cleared, return
		if match.cleared {
			return
		}
		
		//set match cleared
		match.cleared = true
		
		//set the next matches and tournaments available
		let firstMatchId = match.id + 1
		let lastMatchId = match.nextMatchId
		for i in firstMatchId ... lastMatchId {
			if let tempMatch = realm.object(ofType: Match.self, forPrimaryKey: i) {
				tempMatch.available = true
				if tempMatch.tournamentId != match.tournamentId {
					if let tempTournament = realm.object(ofType: Tournament.self, forPrimaryKey: tempMatch.tournamentId) {
						tempTournament.available = true
					}
				}
			}
		}
	}
	
	private func developPlayers(realm: Realm) {
		//default exp power
		var basePower = 5
		if isWon {
			basePower += 1
		}
		
		//the stronger oppo team is, the more exp gained
		basePower += oppoTeam.lv
		
		//get the players plays the game
		let players = realm.objects(Player.self).filter("pos > 0").sorted(byKeyPath: "pos", ascending: false)
		
		//set the UI before level change
		setUIBefore(players: players)
		
		for player:Player in players {
			//the stronger player is, the less exp gained
			var power = basePower - player.lv
			if power < 0 {
				power = 0
			} else if power > 60 {
				power = 60
			}
			
			//calculate the exp gained
			let decimalExp = pow(2, power)
			var exp = Int(truncating: NSDecimalNumber(decimal: decimalExp))
			
			//fill the exp gained to player
			var lvUp = 0
			while exp > 0 {
				if player.exp + exp < 100 {
					player.exp += exp
					exp = 0
				} else {
					exp -= (100 - player.exp)
					player.exp = 0
					lvUp += 1
					exp /= 2
				}
			}
			
			//execute the lv up
			if lvUp > 0 {
				player.lv += lvUp
				player.itl += Int(randomBelow: player.itlBase * 2 + 1) ?? 0 * lvUp
				player.spd += Int(randomBelow: player.spdBase * 2 + 1) ?? 0 * lvUp
				player.str += Int(randomBelow: player.strBase * 2 + 1) ?? 0 * lvUp
				player.off += Int(randomBelow: player.offBase * 2 + 1) ?? 0 * lvUp
				player.def += Int(randomBelow: player.defBase * 2 + 1) ?? 0 * lvUp
				player.reb += Int(randomBelow: player.rebBase * 2 + 1) ?? 0 * lvUp
				player.plm += Int(randomBelow: player.plmBase * 2 + 1) ?? 0 * lvUp
				player.stl += Int(randomBelow: player.stlBase * 2 + 1) ?? 0 * lvUp
			}
		}
		
		//set ui after lv change
		setUIAfter(players: players)
		
		//set players changed
		UserDefaults.standard.set(true, forKey: DefaultKey.PLAYER_CHANGED)
	}
	
	private func setUIBefore(players: Results<Player>) {
		for i in 0...4 {
			lblNames[i].text = players[i].name
			lblLvBefores[i].text = "\(players[i].lv)"
			lblOverallBefores[i].text = "\(players[i].overall)"
		}
	}
	
	private func setUIAfter(players: Results<Player>) {
		for i in 0...4 {
			expBars[i].progress = Float(players[i].exp) / 100.0
			lblLvAfters[i].text = "\(players[i].lv)"
			lblOverallAfters[i].text = "\(players[i].overall)"
			if lblLvAfters[i].text == lblLvBefores[i].text {
				lblLvAfters[i].textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
				lblLvArrows[i].textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
			}
			if lblOverallAfters[i].text == lblOverallBefores[i].text {
				lblOverallAfters[i].textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
				lblOverallArrows[i].textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
			}
		}
	}
}
