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
			
			//player development
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
}
