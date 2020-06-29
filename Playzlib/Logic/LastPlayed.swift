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

public class LastPlayed {
    
    let delegate: AppDelegate
    let context: NSManagedObjectContext
    
    init() {
        delegate = UIApplication.shared.delegate as! AppDelegate
        context = delegate.persistentContainer.viewContext
    }
    
    let errorHandling = ErrorHandling()
    
    func getLastPlayedString(playz: Playz) -> String {
        if let date = playz.lastPlayed {
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
    
    func setLastPlayedDate(playz: Playz) {
        playz.lastPlayed = Date()
        do {
            try context.save()
        } catch let error as NSError {
            errorHandling.throwNSError(error: error, showError: false)
        }
    }
    
    func setLastPlayedDateNew(playz: Playz, completion: () -> Void) {
        playz.lastPlayed = Date()
        do {
            try context.save()
        } catch let error as NSError {
            errorHandling.throwNSError(error: error, showError: false)
        }
        completion()
    }
    
}

