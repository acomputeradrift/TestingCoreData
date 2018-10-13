//
//  Category.swift
//  TestingCoreData
//
//  Created by Jamie on 2018-10-13.
//  Copyright © 2018 Jamie. All rights reserved.
//

import Foundation



class Category{
    var name:String
    var subCategories = [SubCategory]()
    init(name: String) {
        self.name = name
        let subCategory = SubCategory(name: "None")
        self.subCategories.append(subCategory)
    }
    
}
