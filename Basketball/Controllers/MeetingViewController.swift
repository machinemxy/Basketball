//
//  MeetingViewController.swift
//  Basketball
//
//  Created by 马学渊 on 2018/04/23.
//  Copyright © 2018年 Ma Xueyuan. All rights reserved.
//

import UIKit

class MeetingViewController: UIViewController {
	@IBOutlet weak var imgPortrait: UIImageView!
	@IBOutlet weak var lblSpeech: UILabel!
	
	var meeting: Meeting!

    override func viewDidLoad() {
        super.viewDidLoad()

        imgPortrait.image = UIImage(named: meeting.portrait)
		lblSpeech.text = meeting.speech
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
