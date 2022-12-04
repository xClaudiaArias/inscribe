//
//  MyImages+CoreDataProperties.swift
//  inscribe
//
//  Created by Claudia Arias on 12/4/22.
//
//

import Foundation
import CoreData


extension MyImages {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<MyImages> {
        return NSFetchRequest<MyImages>(entityName: "MyImages")
    }

    @NSManaged public var imgfile: Data?
    @NSManaged public var title: String?
    @NSManaged public var user: User?

}

extension MyImages : Identifiable {

}
