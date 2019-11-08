//
//  NoteImage+CoreDataProperties.swift
//  NotesWithLocation
//
//  Created by Arseny Neustroev on 02/11/2019.
//  Copyright © 2019 Arseny Neustroev. All rights reserved.
//
//

import Foundation
import CoreData


extension NoteImage {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<NoteImage> {
        return NSFetchRequest<NoteImage>(entityName: "NoteImage")
    }

    @NSManaged public var imageBig: Data?
    @NSManaged public var note: Note?

}
