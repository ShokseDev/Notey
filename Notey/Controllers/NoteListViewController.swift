//
//  NoteListViewController.swift
//  Notey
//
//  Created by Daniil Aleshchenko on 04.02.2023.
//

import UIKit

class NoteListViewController: UITableViewController {
	
	var notesArray: [Note] = []
	
	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view.
		
	}
	
	// Function to create a new note
	func createNote() {
		let note = Note()
		note.text = "Jopa"
		notesArray.insert(note, at: 0)
	}
	
	//MARK: - Segue Methods
	// Segue method when click on add button
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if segue.identifier == K.addSegue {
			createNote()
			tableView.reloadData()
		}
	}
	
	//MARK: - TableView DataSource Methods
	
	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return notesArray.count
	}
	
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: K.cell, for: indexPath)
		let item = notesArray[indexPath.row]
		
		// Cell content configuration
		var content = cell.defaultContentConfiguration()
		content.text = item.title
		content.secondaryText = item.desc
		cell.contentConfiguration = content
		
		return cell
	}
	
	override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
		if editingStyle == .delete {
			notesArray.remove(at: indexPath.row)
			tableView.deleteRows(at: [indexPath], with: .fade)
		}
	}
	
	override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
		return true
	}
	
	//MARK: - TableView Delegate Methods
	
	override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		
		let controller = storyboard?.instantiateViewController(identifier: K.noteController) as! SingleNoteViewController
		controller.note = notesArray[indexPath.row]
		navigationController?.pushViewController(controller, animated: true)
		
		// Removing the permanent selection of a cell
		tableView.deselectRow(at: indexPath, animated: true)
	}
	
}

