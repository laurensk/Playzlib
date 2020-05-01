//
//  ExtensionHelpers.swift
//  ShareExtension
//
//  Created by Laurens on 01.05.20.
//  Copyright © 2020 Laurens. All rights reserved.
//

import Foundation
import MobileCoreServices

public class ExtensionHelpers {
    
    static let extensionHelpers = ExtensionHelpers()
    
    public func dismissExtension(_ extensionContext: NSExtensionContext?) {
        extensionContext?.completeRequest(returningItems: [], completionHandler: nil)
    }
    
    public func getFileFromExtensionAndSave(name: String, _ extensionContext: NSExtensionContext?) {
        
        guard let extensionItems = extensionContext?.inputItems as? [NSExtensionItem] else {
            return
        }
        
        for extensionItem in extensionItems {
            if let itemProviders = extensionItem.attachments {
                for itemProvider in itemProviders {
                    if itemProvider.hasItemConformingToTypeIdentifier(kUTTypeMovie as String) {
                        
                        itemProvider.loadItem(forTypeIdentifier: kUTTypeMovie as String, options: nil, completionHandler: { file, error in
                            
                            if let url = file as? URL {
                                FileManagerHelpers.fileManagerHelpers.savePlayzFile(url, name, extensionContext)
                            }
                        })
                        
                    } else if itemProvider.hasItemConformingToTypeIdentifier(kUTTypeAudio as String) {
                        
                        itemProvider.loadItem(forTypeIdentifier: kUTTypeAudio as String, options: nil, completionHandler: { file, error in
                            
                            if let url = file as? URL {
                                FileManagerHelpers.fileManagerHelpers.savePlayzFile(url, name, extensionContext)
                            }
                            
                        })
                        
                    }
                }
            }
        }
    }
    
}
