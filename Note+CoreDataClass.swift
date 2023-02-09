//
//  Note+CoreDataClass.swift
//  Notey
//
//  Created by Daniil Aleshchenko on 09.02.2023.
//
//

import Foundation
import CoreData

@objc(Note)
public class Note: NSManagedObject {
	
	// The first sentence in the text becomes title
	var title: String {
		return text.trimmingCharacters(in: .whitespacesAndNewlines).components(separatedBy: .newlines).first ?? ""
	}
	
	// The second sentence in the text becomes description
	var desc: String {
		var allText =  text.trimmingCharacters(in: .whitespacesAndNewlines).components(separatedBy: .newlines)
		allText.removeFirst()
		return "\(updateTime.format()) \(allText.first ?? "No Extra Text")"
	}

}
