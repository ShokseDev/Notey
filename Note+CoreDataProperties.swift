//
//  Note+CoreDataProperties.swift
//  Notey
//
//  Created by Daniil Aleshchenko on 07.02.2023.
//
//

import Foundation
import CoreData


extension Note {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Note> {
        return NSFetchRequest<Note>(entityName: "Note")
    }

    @NSManaged public var id: UUID!
    @NSManaged public var text: String!
    @NSManaged public var timeStamp: Date!

}

extension Note : Identifiable {

}
