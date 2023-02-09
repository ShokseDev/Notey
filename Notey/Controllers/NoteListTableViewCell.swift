//
//  NoteListTableViewCell.swift
//  Notey
//
//  Created by Daniil Aleshchenko on 08.02.2023.
//

import UIKit

class NoteListTableViewCell: UITableViewCell {

	@IBOutlet weak var titleLabel: UILabel!
	@IBOutlet weak var descriptionLabel: UILabel!
	
	func setupNote(_ note: Note) {
		titleLabel.text = note.title
		descriptionLabel.text = note.desc
	}
}
