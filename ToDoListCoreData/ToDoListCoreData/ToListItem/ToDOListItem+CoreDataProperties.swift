//
//  ToDOListItem+CoreDataProperties.swift
//  ToDoListCoreData
//
//  Created by Prachi on 14/09/21.
//
//

import Foundation
import CoreData


extension ToDOListItem {
// fetch request and the actully query out all of the to do list items we have save in core data properties that get saved  inside of core data
    @nonobjc public class func fetchRequest() -> NSFetchRequest<ToDOListItem> {
        return NSFetchRequest<ToDOListItem>(entityName: "ToDOListItem")
    }

    @NSManaged public var name: String? // @ns Managed is basically u want to save in core work with the a managed context or intermedairy saved data in the database and your app
    @NSManaged public var createdAt: Date?

}

extension ToDOListItem : Identifiable {

}
