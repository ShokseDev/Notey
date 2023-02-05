//
//  SingleNoteViewController.swift
//  Notey
//
//  Created by Daniil Aleshchenko on 04.02.2023.
//

import UIKit

class SingleNoteViewController: UIViewController {
	
	var note: Note!
	var delegate: NoteListDelegate!
	
	@IBOutlet weak var textView: UITextView!
	@IBOutlet weak var doneButton: UIBarButtonItem!
	@IBOutlet weak var timeStampLabel: UILabel!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		timeStampLabel.text = note.timeStamp.format()
		textView.text = note.text
		
		// Keyboard State Observers
		NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
		
		NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
	}
	
	override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(animated)
		// Immediate appearance of the keyboard after loading the screen
		textView.becomeFirstResponder()
	}
	
	override func viewWillDisappear(_ animated: Bool) {
		super.viewWillDisappear(animated)

		if self.isMovingFromParent {
			if textView.text.isEmpty == true {
				// Delete note when the back button is pressed && textView is empty
				delegate.deleteNote(id: note.id)
			} else {
				// Saving note when the back button is pressed && textView is not empty
				note.text = textView.text
				note.timeStamp = Date()
				delegate.updateNote()
			}
			
		}
	}
	
	
	@objc func keyboardWillShow(_ notification: NSNotification) {
		// If the keyboard appears, then the done button is available
		doneButton.isEnabled = true
	}
	
	
	@objc func keyboardWillHide(_ notification: NSNotification) {
		// If the keyboard is gone, then the done button is not available
		doneButton.isEnabled = false
	}
	
	
	@IBAction func doneButtonPressed(_ sender: UIBarButtonItem) {
		// Disabling the keyboard when the done button is clicked
		self.view.endEditing(true)
	}
}

