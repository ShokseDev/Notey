//
//  CoreDataManager.swift
//  Notey
//
//  Created by Daniil Aleshchenko on 07.02.2023.
//

import Foundation
import CoreData

class CoreDataManager {
	
	// Create a singleton
	static let shared = CoreDataManager(model: K.modelName)
	
	let container: NSPersistentContainer
	var viewContext: NSManagedObjectContext {
		return container.viewContext
	}
	
	func createNote() -> Note {
		let note = Note(context: viewContext)
		// Recreate note values because it is unwrapped in model
		note.id = UUID()
		note.text = ""
		note.timeStamp = Date()
		save()
		return note
	}
	
	func save() {
		if viewContext.hasChanges {
			do {
				try viewContext.save()
			} catch {
				print("An error ocurred while saving: \(error.localizedDescription)")
			}
		}
	}
	
	// Add a completion handler for some extra configuration
	func load(completion: (() -> Void)? = nil) {
		container.loadPersistentStores { description, error in
			guard error == nil else {
				fatalError("An error ocurred while loading: \(error!.localizedDescription)")
			}
			completion?()
		}
	}
	
	func fetch() -> [Note] {
		let request: NSFetchRequest<Note> = Note.fetchRequest()
		// Sorting notes by timestamp
		let sortDescriptor = NSSortDescriptor(keyPath: \Note.timeStamp, ascending: false)
		request.sortDescriptors = [sortDescriptor]
		return (try? viewContext.fetch(request)) ?? []
	}
	
	init(model: String) {
		container = NSPersistentContainer(name: K.modelName)
	}
}
