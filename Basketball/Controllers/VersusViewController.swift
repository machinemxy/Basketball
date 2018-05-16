//
//  VersusViewController.swift
//  Basketball
//
//  Created by 马学渊 on 2018/05/05.
//  Copyright © 2018年 Ma Xueyuan. All rights reserved.
//

import UIKit

class VersusViewController: UIViewController {

	@IBOutlet weak var lblMyTeam: UILabel!
	@IBOutlet weak var lblOppoTeam: UILabel!
	var tournament: Tournament!
	var match: Match!
	
	override func viewDidLoad() {
        super.viewDidLoad()

        lblMyTeam.text = tournament.myTeam
		lblOppoTeam.text = match.oppoTeam
    }

    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if segue.identifier == "matchSegue" {
			let target = segue.destination as! MatchViewController
			target.match = match
			target.tournament = tournament
		}
    }

}
