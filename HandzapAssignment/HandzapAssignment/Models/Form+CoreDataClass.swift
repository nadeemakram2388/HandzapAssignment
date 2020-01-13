//
//  Form+CoreDataClass.swift
//  HandzapAssignment
//
//  Created by Nadeem Akram on 11/01/20.
//  Copyright © 2020 Nadeem Akram. All rights reserved.
//

import Foundation
import CoreData

extension Form {
    
    func saveToDataBase() {
        CoreDataHelper.shared.saveContext()
    }
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<Form> {
        return NSFetchRequest<Form>(entityName: Form.name)
    }
    
    func delete() {
        //Delete permanatly
        let managedObjectContext = CoreDataHelper.shared.managedObjectContext
        managedObjectContext.delete(self)
        CoreDataHelper.shared.saveContext()
    }
}
