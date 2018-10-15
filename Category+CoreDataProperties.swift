//
//  Category+CoreDataProperties.swift
//  TestingCoreData
//
//  Created by Jamie on 2018-10-15.
//  Copyright © 2018 Jamie. All rights reserved.
//
//

import Foundation
import CoreData


extension Category {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Category> {
        return NSFetchRequest<Category>(entityName: "Category")
    }

    @NSManaged public var name: String?
    @NSManaged public var sub: NSSet?

}

// MARK: Generated accessors for sub
extension Category {

    @objc(addSubObject:)
    @NSManaged public func addToSub(_ value: SubCategory)

    @objc(removeSubObject:)
    @NSManaged public func removeFromSub(_ value: SubCategory)

    @objc(addSub:)
    @NSManaged public func addToSub(_ values: NSSet)

    @objc(removeSub:)
    @NSManaged public func removeFromSub(_ values: NSSet)

}
