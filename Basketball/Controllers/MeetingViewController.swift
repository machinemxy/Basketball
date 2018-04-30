//
//  MeetingViewController.swift
//  Basketball
//
//  Created by 马学渊 on 2018/04/23.
//  Copyright © 2018年 Ma Xueyuan. All rights reserved.
//

import UIKit
import Realm
import RealmSwift

class MeetingViewController: UIViewController {
	@IBOutlet weak var imgPortrait: UIImageView!
	@IBOutlet weak var lblSpeech: UILabel!
	
	var matchId: Int!

    override func viewDidLoad() {
        super.viewDidLoad()

		let realm = try! Realm()
		if let meeting = realm.object(ofType: Meeting.self, forPrimaryKey: matchId) {
        	imgPortrait.image = UIImage(named: meeting.portrait)
			lblSpeech.text = meeting.speech
		}
    }
	
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if segue.identifier == "oppoTeamSegue" {
			let targetController = segue.destination as! OppoTeamTableViewController
			targetController.matchId = matchId
		}
    }

	@IBAction func unwindToMeeting(segue: UIStoryboardSegue) {
		
	}

}
