//
//  Category+CoreDataProperties.swift
//  TestingCoreData
//
//  Created by Jamie on 2018-10-13.
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

}
