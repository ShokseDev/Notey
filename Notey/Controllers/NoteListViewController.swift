//
//  NoteListViewController.swift
//  Notey
//
//  Created by Daniil Aleshchenko on 04.02.2023.
//

import UIKit

protocol NoteListDelegate {
	func updateNote()
	func deleteNote(id: UUID)
}

class NoteListViewController: UITableViewController {
	
	var notesArray: [Note] = []
	
	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view.
		notesArray = CoreDataManager.shared.fetch()
	}
	
	
	//MARK: - Segue Methods
	// Segue method when click on add button
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if segue.identifier == K.addSegue {
			// Create a new note
			let note = CoreDataManager.shared.createNote()
			let destinationVC = segue.destination as! SingleNoteViewController
			// Immediate appearance of the keyboard
			destinationVC.becomeFirstResponder()
			destinationVC.note = note
			destinationVC.delegate = self
			notesArray.insert(note, at: 0)
		}
	}
	
	//MARK: - TableViewDataSource Methods
	
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
	
	//MARK: - TableViewDelegate Methods
	
	override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		
		let destinationVC = storyboard?.instantiateViewController(identifier: K.noteController) as! SingleNoteViewController
		destinationVC.note = notesArray[indexPath.row]
		destinationVC.delegate = self
		navigationController?.pushViewController(destinationVC, animated: true)
		
		// Removing the permanent selection of a cell
		tableView.deselectRow(at: indexPath, animated: true)
	}
	
}

//MARK: - NoteListDelegate Methods
extension NoteListViewController: NoteListDelegate {
	
	func updateNote() {
		tableView.reloadData()
	}
	
	func deleteNote(id: UUID) {
		let row = Int(notesArray.firstIndex(where: { $0.id == id }) ?? 0)
		let indexPath = IndexPath(row: row, section: 0)
		notesArray.remove(at: indexPath.row)
		tableView.reloadData()
	}
	
}
