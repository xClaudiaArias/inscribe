//
//  Reminder+CoreDataProperties.swift
//  inscribe
//
//  Created by Claudia Arias on 11/30/22.
//
//

import Foundation
import CoreData


extension Reminder {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Reminder> {
        return NSFetchRequest<Reminder>(entityName: "Reminder")
    }

    @NSManaged public var attribute: String?
    @NSManaged public var date: String?
    @NSManaged public var title: String?
    @NSManaged public var user: User?

}

extension Reminder : Identifiable {

}
