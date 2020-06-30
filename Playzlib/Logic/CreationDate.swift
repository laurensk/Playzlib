//
//  LastPlayed.swift
//  Playzlib
//
//  Created by Laurens on 27.06.20.
//  Copyright © 2020 Laurens. All rights reserved.
//

import Foundation
import UIKit
import CoreData

public class CreationDate {
    
    let delegate: AppDelegate
    let context: NSManagedObjectContext
    
    init() {
        delegate = UIApplication.shared.delegate as! AppDelegate
        context = delegate.persistentContainer.viewContext
    }
    
    func getCreationDate(playz: Playz) -> String {
        if let date = playz.creationDate {
            if Calendar.current.isDateInToday(date) {
                return "Today"
            } else {
                let formatter = DateFormatter()
                formatter.dateFormat = "dd.MM.yyyy"

                formatter.timeZone = TimeZone(secondsFromGMT: 0)
                formatter.locale = Locale.current

                return formatter.string(from: date)
            }
        } else {
            return "Never"
        }
    }
    
}

