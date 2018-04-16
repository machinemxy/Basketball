//
//  TraitTableViewController.swift
//  Basketball
//
//  Created by 马学渊 on 2018/04/14.
//  Copyright © 2018年 Ma Xueyuan. All rights reserved.
//

import UIKit
import Realm
import RealmSwift

class TraitTableViewController: UITableViewController {
	var myTraits: Results<Trait>!
	
    override func viewDidLoad() {
        super.viewDidLoad()

		fetchMyTraits()
    }

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return myTraits.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "traitCell", for: indexPath)

        // Configure the cell...
		let myTrait = myTraits[indexPath.row]
		cell.textLabel?.text = myTrait.name
		cell.detailTextLabel?.text = myTrait.info
		cell.imageView?.image = myTrait.icon
        return cell
	}

    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if segue.identifier == "traitSetSegue" {
			let indexPath = tableView.indexPathForSelectedRow!
			let selectedTrait = myTraits[indexPath.row]
			let traitSetTableViewController = segue.destination as! TraitSetTableViewController
			traitSetTableViewController.trait = selectedTrait
		}
    }
	
	@IBAction func unwindToTraitTableView(segue: UIStoryboardSegue) {
		fetchMyTraits()
		tableView.reloadData()
	}
	
	//private funcs
	private func fetchMyTraits() {
		let realm = try! Realm()
		myTraits = realm.objects(Trait.self).filter("owned == true")
	}
}
