//
//  SingleNoteViewController.swift
//  Notey
//
//  Created by Daniil Aleshchenko on 04.02.2023.
//

import UIKit

class SingleNoteViewController: UIViewController {
	
	var note = Note()
	
	@IBOutlet weak var textView: UITextView!
	@IBOutlet weak var doneButton: UIBarButtonItem!
	
    override func viewDidLoad() {
        super.viewDidLoad()
		
		// Keyboard State Observers
		NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
		
		NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
	
	// If the keyboard appears, then the button is available
	@objc func keyboardWillShow(_ notification: NSNotification) {
		doneButton.isEnabled = true
	}
	
	// If the keyboard is gone, then the button is not available
	@objc func keyboardWillHide(_ notification: NSNotification) {
		doneButton.isEnabled = false
	}
	
	
	// Disabling the keyboard when the done button is clicked
	@IBAction func doneButtonPressed(_ sender: UIBarButtonItem) {
		self.view.endEditing(true)
	}
}

extension SingleNoteViewController: UITextViewDelegate {
	func textViewDidEndEditing(_ textView: UITextView) {
		
	}
}
