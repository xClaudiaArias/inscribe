//
//  User+CoreDataProperties.swift
//  inscribe
//
//  Created by Claudia Arias on 11/30/22.
//
//

import Foundation
import CoreData


extension User {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<User> {
        return NSFetchRequest<User>(entityName: "User")
    }

    @NSManaged public var desc: String?
    @NSManaged public var email: String?
    @NSManaged public var firstName: String?
    @NSManaged public var image: Data?
    @NSManaged public var lastName: String?
    @NSManaged public var password: String?
    @NSManaged public var username: String?
    @NSManaged public var myimages: MyImages?
    @NSManaged public var note: Note?
    @NSManaged public var reminder: Reminder?

}

extension User : Identifiable {

}
