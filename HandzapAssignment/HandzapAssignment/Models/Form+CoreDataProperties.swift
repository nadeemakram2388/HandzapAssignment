//
//  Form+CoreDataProperties.swift
//  HandzapAssignment
//
//  Created by Nadeem Akram on 11/01/20.
//  Copyright © 2020 Nadeem Akram. All rights reserved.
//

import Foundation
import CoreData

@objc(Form)
public class Form: NSManagedObject, Codable {
    
    @NSManaged public var budget: String?
    @NSManaged public var title: String?
    @NSManaged public var desc: String?
    @NSManaged public var rate: String?
    @NSManaged public var payMethod: String?
    @NSManaged public var startDate: String?
    @NSManaged public var jobTerms: String?
    
    enum CodingKeys: String, CodingKey {
        case budget, title, desc, rate, payMethod, startDate, jobTerms
    }
    
    public required convenience init(from decoder: Decoder) throws {

        let managedObjectContext = CoreDataHelper.shared.managedObjectContext
        guard let entity = NSEntityDescription.entity(forEntityName: Form.name, in: managedObjectContext) else {
            fatalError("Failed to decode Contact")
        }
        
        self.init(entity: entity, insertInto: nil)

        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.budget = try container.decodeIfPresent(String.self, forKey: .budget)
        self.title = try container.decodeIfPresent(String.self, forKey: .title)
        self.desc = try container.decodeIfPresent(String.self, forKey: .desc)
        self.rate = try container.decodeIfPresent(String.self, forKey: .rate)
        self.payMethod = try container.decodeIfPresent(String.self, forKey: .payMethod)
        self.startDate = try container.decodeIfPresent(String.self, forKey: .startDate)
        self.jobTerms = try container.decodeIfPresent(String.self, forKey: .jobTerms)

    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(budget, forKey: .budget)
        try container.encode(title, forKey: .title)
        try container.encode(desc, forKey: .desc)
        try container.encode(rate, forKey: .rate)
        try container.encode(payMethod, forKey: .payMethod)
        try container.encode(startDate, forKey: .startDate)
        try container.encode(jobTerms, forKey: .jobTerms)

    }
}
