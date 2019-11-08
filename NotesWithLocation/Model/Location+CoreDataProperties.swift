//
//  Location+CoreDataProperties.swift
//  NotesWithLocation
//
//  Created by Arseny Neustroev on 02/11/2019.
//  Copyright © 2019 Arseny Neustroev. All rights reserved.
//
//

import Foundation
import CoreData


extension Location {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Location> {
        return NSFetchRequest<Location>(entityName: "Location")
    }

    @NSManaged public var lat: Double
    @NSManaged public var lon: Double
    @NSManaged public var note: Note?

}
