//
//  MatchViewController.swift
//  Basketball
//
//  Created by 马学渊 on 2018/05/05.
//  Copyright © 2018年 Ma Xueyuan. All rights reserved.
//

import UIKit
import Realm
import RealmSwift

class MatchViewController: UIViewController {
	@IBOutlet weak var swtWon: UISwitch!
	@IBOutlet weak var lblMyTeamName: UILabel!
	@IBOutlet weak var lblScore: UILabel!
	@IBOutlet weak var lblOppoTeamName: UILabel!
	@IBOutlet var lblMyPlayerNames: [UILabel]!
	@IBOutlet var lblOppoPlayerNames: [UILabel]!
	@IBOutlet var lblMyScores: [UILabel]!
	@IBOutlet var lblOppoScores: [UILabel]!
	@IBOutlet var lblLogs: [UILabel]!
	
	var tournament: Tournament!
	var match: Match!
	var oppoTeam: OppoTeam!
	var timer: Timer!
	//debug
	var score = 0
	
    override func viewDidLoad() {
        super.viewDidLoad()

		//get oppoTeam
		let realm = try! Realm()
		oppoTeam = realm.object(ofType: OppoTeam.self, forPrimaryKey: match.id)!
		
		//update ui at begining
		updateUIAtBegining()
		
		//set timer
		timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true, block: { (_) in
			self.procedure()
		})
    }
	
	func procedure() {
		score += 1
		lblScore.text = "\(score)"
		if score == 10 {
			timer.invalidate()
		}
	}

    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if segue.identifier == "afterMatchSegue" {
			let target = segue.destination as! AfterMatchViewController
			target.isWon = swtWon.isOn
			target.match = match
			target.oppoTeam = oppoTeam
		}
    }
	
	// MARK: private
	private func updateUIAtBegining() {
		
	}
}
