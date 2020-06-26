//
//  FileManagerHelpers.swift
//  ShareExtension
//
//  Created by Laurens on 01.05.20.
//  Copyright © 2020 Laurens. All rights reserved.
//

import Foundation
import AVFoundation
import CoreData

public class FileManagerHelpers {
    
    static let fileManagerHelpers = FileManagerHelpers()
    
    public func savePlayzFile(_ fileURL: URL, _ name: String, _ extensionContext: NSExtensionContext?) {
        
        let playz = Playz(context: CoreDataStack.store.context)
        playz.uuid = UUID()
        playz.audioUrl = copyPlayz(originURL: fileURL, destinationName: prepareAudioName(playz: playz, fileURL: fileURL, extensionContext), extensionContext)
        playz.name = name
        playz.lastPlayed = nil
        playz.creationDate = Date()
        
        do {
            try CoreDataStack.store.context.save()
            ExtensionHelpers.extensionHelpers.dismissExtension(extensionContext)
        } catch {
            ErrorHandling.errorHandling.throwError(error: .savingError, showError: true)
            ExtensionHelpers.extensionHelpers.dismissExtension(extensionContext)
        }
        
    }
    
    private func prepareAudioName(playz: Playz, fileURL: URL, _ extensionContext: NSExtensionContext?) -> String {
        
        var audioName = "Playz-"
        audioName.append(playz.uuid?.uuidString ?? "UUID")
        audioName.append(".")
        audioName.append(fileURL.pathExtension)
        
        return audioName
    }
    
    private func createDirectory(withFolderName dest: String, toDirectory directory: FileManager.SearchPathDirectory = .applicationSupportDirectory, _ extensionContext: NSExtensionContext?) {
        let fileManager = FileManager.default
        let url = fileManager.containerURL(forSecurityApplicationGroupIdentifier: "group.com.laurensk.Playzlib")
        if let applicationSupportURL = url {
            do{
                var newURL = applicationSupportURL
                newURL = newURL.appendingPathComponent(dest, isDirectory: true)
                try fileManager.createDirectory(at: newURL, withIntermediateDirectories: true, attributes: nil)
            }
            catch{
                ErrorHandling.errorHandling.throwError(error: .savingError, showError: true)
                ExtensionHelpers.extensionHelpers.dismissExtension(extensionContext)
            }
        }
    }
    
    private func copyPlayz(originURL: URL, destinationName: String, _ extensionContext: NSExtensionContext?) -> URL {
        // check if audio or video
        if originURL.pathExtension.lowercased() == "mov" || originURL.pathExtension.lowercased() == "mp4" {
            return copyPlayzFromVideo(originURL: originURL, destinationName: destinationName, extensionContext)
        } else {
            return copyPlayzFromAudio(originURL: originURL, destinationName: destinationName, extensionContext)
        }
    }
    
    private func copyPlayzFromVideo(originURL: URL, destinationName: String, _ extensionContext: NSExtensionContext?) -> URL {
        
        let directoryName = "MyPlayz"
        createDirectory(withFolderName: directoryName, extensionContext)
        
        let fileManager = FileManager.default
        let path = fileManager.containerURL(forSecurityApplicationGroupIdentifier: "group.com.laurensk.Playzlib")!
        
        let destinationURL = path.appendingPathComponent(directoryName, isDirectory: true).appendingPathComponent(destinationName + ".m4a")
        _ = originURL.startAccessingSecurityScopedResource()
        
        
        let asset = AVURLAsset(url: originURL, options: nil)
        asset.writeAudioTrackToURL(destinationURL) { (success, error) -> () in
            if !success {
                ErrorHandling.errorHandling.throwError(error: .savingError, showError: true)
                ExtensionHelpers.extensionHelpers.dismissExtension(extensionContext)
            }
        }
        
        originURL.stopAccessingSecurityScopedResource()
        return destinationURL
    }
    
    private func copyPlayzFromAudio(originURL: URL, destinationName: String, _ extensionContext: NSExtensionContext?) -> URL {
        
        let directoryName = "MyPlayz"
        createDirectory(withFolderName: directoryName, extensionContext)
        
        let fileManager = FileManager.default
        let path = fileManager.containerURL(forSecurityApplicationGroupIdentifier: "group.com.laurensk.Playzlib")!
        
        let destinationURL = path.appendingPathComponent(directoryName, isDirectory: true).appendingPathComponent(destinationName)
        _ = originURL.startAccessingSecurityScopedResource()
        
        do {
            try fileManager.copyItem(at: originURL, to: destinationURL)
            originURL.stopAccessingSecurityScopedResource()
            return destinationURL
            
        }
        catch {
            originURL.stopAccessingSecurityScopedResource()
            ErrorHandling.errorHandling.throwError(error: .savingError, showError: true)
            ExtensionHelpers.extensionHelpers.dismissExtension(extensionContext)
        }
        
        originURL.stopAccessingSecurityScopedResource()
        return URL(string: "https://www.laurensk.at")!
    }
    
    
}
