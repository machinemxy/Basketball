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
	@IBOutlet weak var progress: UIProgressView!
	@IBOutlet weak var swtWon: UISwitch!
	
	var tournament: Tournament!
	var match: Match!
	var oppoTeam: OppoTeam!
	
	
    override func viewDidLoad() {
        super.viewDidLoad()

		//get oppoTeam
		let realm = try! Realm()
		oppoTeam = realm.object(ofType: OppoTeam.self, forPrimaryKey: match.id)!
    }

	@IBAction func changeProgress(_ sender: Any) {
		progress.setProgress(1.0, animated: true)
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
}
