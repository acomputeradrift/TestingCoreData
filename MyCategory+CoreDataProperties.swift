//
//  MyCategory+CoreDataProperties.swift
//  TestingCoreData
//
//  Created by Jamie on 2018-10-13.
//  Copyright © 2018 Jamie. All rights reserved.
//
//

import Foundation
import CoreData


extension MyCategory {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<MyCategory> {
        return NSFetchRequest<MyCategory>(entityName: "MyCategory")
    }

    @NSManaged public var name: String?

}
