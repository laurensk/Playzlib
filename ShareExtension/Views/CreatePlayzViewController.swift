//
//  CreatePlayzViewController.swift
//  ShareExtension
//
//  Created by Laurens on 27.04.20.
//  Copyright © 2020 Laurens. All rights reserved.
//

import UIKit
import MobileCoreServices
import AVFoundation
import CoreData

enum ErrorType {
    case validationError
    case saveError
}

class CreatePlayzViewController: UIViewController {
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.view.backgroundColor = .systemGray6
        
        setupNavBar()
        setupViews()
    }
    
    // MARK: - Helper Functions
    
    @objc private func cancelAction () {
        
        let error = NSError(domain: "some.bundle.identifier", code: 0, userInfo: [NSLocalizedDescriptionKey: "An error description"])
        extensionContext?.cancelRequest(withError: error)
    }
    
    @objc private func saveAction() {
        if validateForm() {
            if !savePlayz(name: textField.text ?? "Untitled") {
                saveError(errorType: .saveError)
            }
        } else {
            saveError(errorType: .validationError)
        }
    }
    
    private func dismissExtension() {
        extensionContext?.completeRequest(returningItems: [], completionHandler: nil)
    }
    
    private func saveError(errorType: ErrorType) {
        
        let alert: UIAlertController
        
        if errorType == .validationError {
            alert = UIAlertController(title: "Error", message: "validation error", preferredStyle: .alert)
        } else {
            alert = UIAlertController(title: "Error", message: "error while saving playz", preferredStyle: .alert)
        }
        
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        self.present(alert, animated: true)
    }
    
    private func validateForm() -> Bool {
        return !(textField.text?.isEmpty ?? true)
    }
    
    // MARK: - savePlayz() Main Feature
    
    private func savePlayz(name: String) -> Bool {
        
        return getPlayzFileFromExtension(name: name)
    }
    
    private func getPlayzFileFromExtension(name: String) -> Bool {
        
        guard let extensionItems = extensionContext?.inputItems as? [NSExtensionItem] else {
            return false
        }
        
        for extensionItem in extensionItems {
            if let itemProviders = extensionItem.attachments {
                for itemProvider in itemProviders {
                    if itemProvider.hasItemConformingToTypeIdentifier(kUTTypeMovie as String) {
                        
                        itemProvider.loadItem(forTypeIdentifier: kUTTypeMovie as String, options: nil, completionHandler: { file, error in
                            
                            if let url = file as? URL {
                                self.savePlayzFile(url, name)
                            }
                        })
                        
                    } else if itemProvider.hasItemConformingToTypeIdentifier(kUTTypeAudio as String) {
                        
                        itemProvider.loadItem(forTypeIdentifier: kUTTypeAudio as String, options: nil, completionHandler: { file, error in
                            
                            if let url = file as? URL {
                                self.savePlayzFile(url, name)
                            }
                            
                        })
                        
                    }
                }
            }
        }
        
        return true
    }
    
    private func savePlayzFile(_ fileURL: URL, _ name: String) {
        
        let playz = Playz(context: CoreDataStack.store.context)
        playz.uuid = UUID()
        playz.audioUrl = copyPlayz(originURL: fileURL, destinationName: prepareAudioName(playz: playz, fileURL: fileURL))
        playz.name = name
        playz.lastPlayed = nil
        playz.creationDate = Date()
        
        do {
            try CoreDataStack.store.context.save()
            dismissExtension()
        } catch {
            saveError(errorType: .saveError)
        }
        
    }
    
    // MARK: - File System Stuff (pls make a different class then)
    
    func prepareAudioName(playz: Playz, fileURL: URL) -> String {
        
        var audioName = playz.uuid?.uuidString ?? "UUID"
        audioName.append(".")
        audioName.append(fileURL.pathExtension)
        
        return audioName
    }
    
    func createDirectory(withFolderName dest: String, toDirectory directory: FileManager.SearchPathDirectory = .applicationSupportDirectory) {
        let fileManager = FileManager.default
        let url = fileManager.containerURL(forSecurityApplicationGroupIdentifier: "group.com.laurensk.Playzlib")
        if let applicationSupportURL = url {
            do{
                var newURL = applicationSupportURL
                newURL = newURL.appendingPathComponent(dest, isDirectory: true)
                try fileManager.createDirectory(at: newURL, withIntermediateDirectories: true, attributes: nil)
            }
            catch{
                print("error \(error)")
            }
        }
    }
    
    func copyPlayz(originURL: URL, destinationName: String) -> URL {
        // check if audio or video
        if originURL.pathExtension.lowercased() == "mov" || originURL.pathExtension.lowercased() == "mp4" {
            return copyPlayzFromVideo(originURL: originURL, destinationName: destinationName)
        } else {
            return copyPlayzFromAudio(originURL: originURL, destinationName: destinationName)
        }
    }
    
    func copyPlayzFromVideo(originURL: URL, destinationName: String) -> URL {
        
        // implement audio convertion here
        // test that thing....
        
        let directoryName = "MyPlayz"
        
        createDirectory(withFolderName: directoryName)
        
        let fileManager = FileManager.default
        let path = fileManager.containerURL(forSecurityApplicationGroupIdentifier: "group.com.laurensk.Playzlib")!
        
        let destinationURL = path.appendingPathComponent(directoryName, isDirectory: true).appendingPathComponent(destinationName)
        _ = originURL.startAccessingSecurityScopedResource()
        
        
        let asset = AVURLAsset(url: originURL, options: nil)
        asset.writeAudioTrackToURL(destinationURL) { (success, error) -> () in
            if !success {
                print("\(error) error")
            }
        }
        
        originURL.stopAccessingSecurityScopedResource()
        return destinationURL
    }
    
    func copyPlayzFromAudio(originURL: URL, destinationName: String) -> URL {
        
        let directoryName = "MyPlayz"
        
        createDirectory(withFolderName: directoryName)
        
        let fileManager = FileManager.default
        let path = fileManager.containerURL(forSecurityApplicationGroupIdentifier: "group.com.laurensk.Playzlib")!
        
        let destinationURL = path.appendingPathComponent(directoryName, isDirectory: true).appendingPathComponent(destinationName)
        _ = originURL.startAccessingSecurityScopedResource()
        
        do {
            try fileManager.copyItem(at: originURL, to: destinationURL)
            originURL.stopAccessingSecurityScopedResource()
            return destinationURL
            
        }
        catch let error {
            originURL.stopAccessingSecurityScopedResource()
            print ("\(error) error")
        }
        
        originURL.stopAccessingSecurityScopedResource()
        return URL(string: "https://www.laurensk.at")!
    }
    
    // MARK: - User Interface
    
    private func setupNavBar() {
        self.navigationItem.title = "Create Playz"
        
        let itemCancel = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancelAction))
        self.navigationItem.setLeftBarButton(itemCancel, animated: false)
        
        let itemDone = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(saveAction))
        self.navigationItem.setRightBarButton(itemDone, animated: false)
    }
    
    private func setupViews() {
        self.view.addSubview(textField)
        NSLayoutConstraint.activate([
            textField.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            textField.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            textField.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            textField.heightAnchor.constraint(equalToConstant: 44)
        ])
    }
    
    private lazy var textField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Name"
        textField.backgroundColor = .white
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        return textField
    }()
    
}

// MARK: - CreatePlayzNavigationController

@objc(CreatePlayzNavigationController)
class CreatePlayzNavigationController: UINavigationController {
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
        self.setViewControllers([CreatePlayzViewController()], animated: false)
    }
    
    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
