//
//  SubCategory+CoreDataProperties.swift
//  TestingCoreData
//
//  Created by Jamie on 2018-10-13.
//  Copyright © 2018 Jamie. All rights reserved.
//
//

import Foundation
import CoreData


extension SubCategory {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<SubCategory> {
        return NSFetchRequest<SubCategory>(entityName: "SubCategory")
    }

    @NSManaged public var name: String?
    @NSManaged public var category: Category?

}
