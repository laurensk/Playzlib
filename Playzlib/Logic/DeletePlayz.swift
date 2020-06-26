//
//  DeletePlayz.swift
//  Playzlib
//
//  Created by Laurens on 19.06.20.
//  Copyright © 2020 Laurens. All rights reserved.
//

import Foundation
import UIKit
import CoreData

public class DeletePlayz {
    
    let delegate: AppDelegate
    let context: NSManagedObjectContext
    
    init() {
        delegate = UIApplication.shared.delegate as! AppDelegate
        context = delegate.persistentContainer.viewContext
    }
    
    func deletePlayz(playz: Playz) {
        deletePlayzAudio(playz: playz, completion: {
            deletePlayzEntry(playz: playz)
        })
    }
    
    func deletePlayzAudio(playz: Playz, completion: () -> Void) {
        completion()
    }
    
    func deletePlayzEntry(playz: Playz) {
        self.context.delete(playz)
    }
    
}
