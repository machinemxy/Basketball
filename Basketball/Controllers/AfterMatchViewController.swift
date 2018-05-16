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

class AfterMatchViewController: UIViewController {
	var isWon: Bool!
	var match: Match!
	var oppoTeam: OppoTeam!
	
	@IBOutlet weak var lblInfo: UILabel!
	@IBOutlet var lblNames: [UILabel]!

	
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
		var power = 5
		if isWon {
			power = 6
		}
		
		//the stronger oppo team is, the more exp gained
		power += oppoTeam.lv
		
		let players = realm.objects(Player.self).filter("pos > 0")
		for player:Player in players {
			//the stronger player is, the less exp gained
			power -= player.lv
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
			
		}
		
		//set players changed
		UserDefaults.standard.set(true, forKey: DefaultKey.PLAYER_CHANGED)
	}
}
