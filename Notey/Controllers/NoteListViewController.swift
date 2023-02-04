//
//  NoteListViewController.swift
//  Notey
//
//  Created by Daniil Aleshchenko on 04.02.2023.
//

import UIKit

class NoteListViewController: UITableViewController {
	
	var itemArray = ["1", "2", "3"]

	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view.
	}

	//MARK: - TableView DataSource Methods
	
	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return itemArray.count
	}
	
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: K.cell, for: indexPath)
				let item = itemArray[indexPath.row]
				
				// Cell content configuration
				var content = cell.defaultContentConfiguration()
				content.text = item
				cell.contentConfiguration = content

				return cell
	}
	
	//MARK: - TableView Delegate Methods
	
	override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		
		// Removing the permanent selection of a cell
		tableView.deselectRow(at: indexPath, animated: true)
	}
}

