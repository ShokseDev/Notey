//
//  CoreDataManager.swift
//  Notey
//
//  Created by Daniil Aleshchenko on 07.02.2023.
//

import Foundation
import CoreData

class CoreDataManager {
	
	let container: NSPersistentContainer
	var viewContext: NSManagedObjectContext {
		return container.viewContext
	}
	
	// Create a singleton
	static let shared = CoreDataManager(model: K.modelName)
	
	init(model: String) {
		container = NSPersistentContainer(name: K.modelName)
	}
	
	func createNote() -> Note {
		let note = Note(context: viewContext)
		// Recreate note values because it is unwrapped in model
		note.id = UUID()
		note.text = ""
		note.updateTime = Date()
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
		let sortDescriptor = NSSortDescriptor(keyPath: \Note.updateTime, ascending: false)
		request.sortDescriptors = [sortDescriptor]
		return (try? viewContext.fetch(request)) ?? []
	}
	
	func delete(note: Note) {
		viewContext.delete(note)
		save()
	}
	
}
