//
//  CoreDataStack.swift
//  ShareExtension
//
//  Created by Laurens on 27.04.20.
//  Copyright © 2020 Laurens. All rights reserved.
//

import Foundation
import CoreData


final class CoreDataStack {
    
    
    static let store = CoreDataStack()
    private init() {}
    
    
    public var context: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    
    func storePlayz(_ playz : Playz) {
        
        let newPlayz = Playz(context: context)
        
        newPlayz.uuid = playz.uuid
        newPlayz.name = playz.name
        newPlayz.lastPlayed = playz.lastPlayed
        newPlayz.creationDate = playz.creationDate
        newPlayz.audioUrl = playz.audioUrl
        
        try! context.save()
    }
    
    public lazy var persistentContainer: CustomPersistantContainer = {
        
        let container = CustomPersistantContainer(name: "Playzlib")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    // MARK: - Core Data Saving support
    func saveContext() {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}


class CustomPersistantContainer : NSPersistentContainer {
    
    static let url = FileManager.default.containerURL(forSecurityApplicationGroupIdentifier: "group.com.laurensk.Playzlib")!
    let storeDescription = NSPersistentStoreDescription(url: url)
    
    override class func defaultDirectoryURL() -> URL {
        return url
    }
}
