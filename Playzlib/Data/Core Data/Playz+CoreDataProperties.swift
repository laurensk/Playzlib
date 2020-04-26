//
//  Playz+CoreDataProperties.swift
//  Playzlib
//
//  Created by Laurens on 26.04.20.
//  Copyright © 2020 Laurens. All rights reserved.
//
//

import Foundation
import CoreData


extension Playz {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Playz> {
        return NSFetchRequest<Playz>(entityName: "Playz")
    }

    @NSManaged public var uuid: UUID?
    @NSManaged public var name: String?
    @NSManaged public var audioName: String?
    @NSManaged public var lastPlayed: Date?
    @NSManaged public var creationDate: Date?

}
