//
//  Day+CoreDataClass.swift
//  TimeSheet
//
//  Created by Hossein Safaie on 11/14/1397 AP.
//
//

import Foundation
import CoreData

@objc(Day)
public class Day: NSManagedObject {

}

extension Day {
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<Day> {
        return NSFetchRequest<Day>(entityName: "Day")
    }
    
    @NSManaged public var date: String?
    @NSManaged public var time: String?
    @NSManaged public var weekDay: String?
    @NSManaged public var isCheckIn: Bool
    
}
