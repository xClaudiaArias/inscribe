//
//  Note+CoreDataProperties.swift
//  inscribe
//
//  Created by Claudia Arias on 12/4/22.
//
//

import Foundation
import CoreData


extension Note {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Note> {
        return NSFetchRequest<Note>(entityName: "Note")
    }

    @NSManaged public var date: String?
    @NSManaged public var note: String?
    @NSManaged public var title: String?
    @NSManaged public var user: User?

}

extension Note : Identifiable {

}
