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
	@IBOutlet weak var updateTimeLabel: UILabel!
	@IBOutlet weak var textViewBottomConstraint: NSLayoutConstraint!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		updateTimeLabel.text = note.updateTime.format()
		textView.text = note.text
		
		// Keyboard State Observers
		NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
		
		NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
	}
	
	//	override func viewWillAppear(_ animated: Bool) {
	//		super.viewWillAppear(animated)
	//		textView.becomeFirstResponder()
	//	}
	
	override func viewWillDisappear(_ animated: Bool) {
		super.viewWillDisappear(animated)
		
		if self.isMovingFromParent {
			if textView.text.isEmpty == true {
				// Delete note when the back button is pressed && textView is empty
				delegate.deleteNote(id: note.id)
				CoreDataManager.shared.delete(note: note)
			} else {
				// Saving note when the back button is pressed && textView is not empty
				note.text = textView.text
				note.updateTime = Date()
				CoreDataManager.shared.save()
				delegate.updateNote()
			}
			
		}
	}
	
	
	@objc func keyboardWillShow(_ notification: NSNotification) {
		// If the keyboard appears, then the done button is available
		doneButton.isEnabled = true
		// If the keyboard appears, then the textview bottom contraint is changed
		if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
			let keyboardHeight = keyboardFrame.cgRectValue.height
 			textViewBottomConstraint.constant = -keyboardHeight + 40
		}
	}
	
	
	@objc func keyboardWillHide(_ notification: NSNotification) {
		// If the keyboard is gone, then the done button is not available
		doneButton.isEnabled = false
		// If the keyboard appears, then the textview bottom contraint is return to default
		textViewBottomConstraint.constant = 0
	}
	
	
	@IBAction func doneButtonPressed(_ sender: UIBarButtonItem) {
		// Disabling the keyboard when the done button is clicked
		self.view.endEditing(true)
		// If text has changed, save time to timestamp
		if textView.text != note.text {
			updateTimeLabel.text = Date().format()
		}
	}
}

