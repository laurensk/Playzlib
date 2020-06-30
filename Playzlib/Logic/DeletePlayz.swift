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
    
    let errorHandling = ErrorHandling()
    
    func deletePlayz(playz: Playz) {
        deletePlayzAudio(playz: playz, success: {
            deletePlayzEntry(playz: playz)
        })
    }
    
    private func deletePlayzAudio(playz: Playz, success: () -> Void) {
        let fileManager = FileManager.default
        if let path = playz.audioUrl?.path {
            if fileManager.fileExists(atPath: path) {
                if let url = playz.audioUrl {
                    do {
                        try fileManager.removeItem(at: url)
                        success()
                    }
                    catch {
                        errorHandling.throwError(error: .deleteError, showError: true)
                    }
                }
            } else {
                success()
            }
        }
        
    }
    
    private func deletePlayzEntry(playz: Playz) {
        self.context.delete(playz)
    }
    
}
