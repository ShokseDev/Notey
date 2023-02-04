//
//  Note.swift
//  Notey
//
//  Created by Daniil Aleshchenko on 04.02.2023.
//

import Foundation

class Note {
	var text: String! 
	
	// The first sentence in the text becomes title
	var title: String {
		return text.trimmingCharacters(in: .whitespacesAndNewlines).components(separatedBy: .newlines).first ?? ""
	}
	
	// The second sentence in the text becomes description
	var desc: String {
		var allText =  text.trimmingCharacters(in: .whitespacesAndNewlines).components(separatedBy: .newlines)
		allText.removeFirst()
		return allText.first ?? "No extra text"
	}
	
}
