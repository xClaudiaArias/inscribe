//
//  User+CoreDataProperties.swift
//  inscribe
//
//  Created by Claudia Arias on 12/4/22.
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
    @NSManaged public var myimages: NSOrderedSet?
    @NSManaged public var note: NSOrderedSet?
    @NSManaged public var reminder: NSOrderedSet?

}

// MARK: Generated accessors for myimages
extension User {

    @objc(insertObject:inMyimagesAtIndex:)
    @NSManaged public func insertIntoMyimages(_ value: MyImages, at idx: Int)

    @objc(removeObjectFromMyimagesAtIndex:)
    @NSManaged public func removeFromMyimages(at idx: Int)

    @objc(insertMyimages:atIndexes:)
    @NSManaged public func insertIntoMyimages(_ values: [MyImages], at indexes: NSIndexSet)

    @objc(removeMyimagesAtIndexes:)
    @NSManaged public func removeFromMyimages(at indexes: NSIndexSet)

    @objc(replaceObjectInMyimagesAtIndex:withObject:)
    @NSManaged public func replaceMyimages(at idx: Int, with value: MyImages)

    @objc(replaceMyimagesAtIndexes:withMyimages:)
    @NSManaged public func replaceMyimages(at indexes: NSIndexSet, with values: [MyImages])

    @objc(addMyimagesObject:)
    @NSManaged public func addToMyimages(_ value: MyImages)

    @objc(removeMyimagesObject:)
    @NSManaged public func removeFromMyimages(_ value: MyImages)

    @objc(addMyimages:)
    @NSManaged public func addToMyimages(_ values: NSOrderedSet)

    @objc(removeMyimages:)
    @NSManaged public func removeFromMyimages(_ values: NSOrderedSet)

}

// MARK: Generated accessors for note
extension User {

    @objc(insertObject:inNoteAtIndex:)
    @NSManaged public func insertIntoNote(_ value: Note, at idx: Int)

    @objc(removeObjectFromNoteAtIndex:)
    @NSManaged public func removeFromNote(at idx: Int)

    @objc(insertNote:atIndexes:)
    @NSManaged public func insertIntoNote(_ values: [Note], at indexes: NSIndexSet)

    @objc(removeNoteAtIndexes:)
    @NSManaged public func removeFromNote(at indexes: NSIndexSet)

    @objc(replaceObjectInNoteAtIndex:withObject:)
    @NSManaged public func replaceNote(at idx: Int, with value: Note)

    @objc(replaceNoteAtIndexes:withNote:)
    @NSManaged public func replaceNote(at indexes: NSIndexSet, with values: [Note])

    @objc(addNoteObject:)
    @NSManaged public func addToNote(_ value: Note)

    @objc(removeNoteObject:)
    @NSManaged public func removeFromNote(_ value: Note)

    @objc(addNote:)
    @NSManaged public func addToNote(_ values: NSOrderedSet)

    @objc(removeNote:)
    @NSManaged public func removeFromNote(_ values: NSOrderedSet)

}

// MARK: Generated accessors for reminder
extension User {

    @objc(insertObject:inReminderAtIndex:)
    @NSManaged public func insertIntoReminder(_ value: Reminder, at idx: Int)

    @objc(removeObjectFromReminderAtIndex:)
    @NSManaged public func removeFromReminder(at idx: Int)

    @objc(insertReminder:atIndexes:)
    @NSManaged public func insertIntoReminder(_ values: [Reminder], at indexes: NSIndexSet)

    @objc(removeReminderAtIndexes:)
    @NSManaged public func removeFromReminder(at indexes: NSIndexSet)

    @objc(replaceObjectInReminderAtIndex:withObject:)
    @NSManaged public func replaceReminder(at idx: Int, with value: Reminder)

    @objc(replaceReminderAtIndexes:withReminder:)
    @NSManaged public func replaceReminder(at indexes: NSIndexSet, with values: [Reminder])

    @objc(addReminderObject:)
    @NSManaged public func addToReminder(_ value: Reminder)

    @objc(removeReminderObject:)
    @NSManaged public func removeFromReminder(_ value: Reminder)

    @objc(addReminder:)
    @NSManaged public func addToReminder(_ values: NSOrderedSet)

    @objc(removeReminder:)
    @NSManaged public func removeFromReminder(_ values: NSOrderedSet)

}

extension User : Identifiable {

}
