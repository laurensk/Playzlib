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
            savePlayz(name: textField.text ?? "Untitled") ? dismissExtension() : saveError(errorType: .saveError)
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
        playz.audioUrl = copyPlayz(withOriginURL: fileURL, withDestinationName: prepareAudioName(playz: playz, fileURL: fileURL), uuid: playz.uuid?.uuidString ?? "UUID")
        playz.name = name
        playz.lastPlayed = nil
        playz.creationDate = Date()
        
        try! CoreDataStack.store.context.save()
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
    
    func copyPlayz(withOriginURL originURL:URL, withDestinationName destinationName: String, uuid: String) -> URL {
        
        let directoryName = "MyPlayz"
        
        createDirectory(withFolderName: directoryName)
        
        let fileManager = FileManager.default
        let path = fileManager.containerURL(forSecurityApplicationGroupIdentifier: "group.com.laurensk.Playzlib")!
        
        let baseURL = path.appendingPathComponent(directoryName, isDirectory: true)
        let audioURL = baseURL.appendingPathComponent(destinationName)
        
        _ = originURL.startAccessingSecurityScopedResource()
        
        do {
            try fileManager.copyItem(at: originURL, to: audioURL)
            originURL.stopAccessingSecurityScopedResource()
            
            if audioURL.pathExtension == "mov" || audioURL.pathExtension == "mp4" {
                return extractAudioAndSave(videoURL: audioURL, baseURL: baseURL, uuid: uuid)
            } else {
                return audioURL
            }
            
        }
        catch let error {
            originURL.stopAccessingSecurityScopedResource()
            print ("\(error) error")
        }
        
        originURL.stopAccessingSecurityScopedResource()
        return URL(string: "https://www.laurensk.at")!
    }
    
    func extractAudioAndSave(videoURL: URL, baseURL: URL, uuid: String) -> URL {
        
        let audioURL = baseURL.appendingPathComponent(uuid).appendingPathComponent(".mov")
        
        let asset = AVURLAsset(url: videoURL, options: nil)
        asset.writeAudioTrack(to: audioURL, success: {}) { (error) in
            self.saveError(errorType: .validationError)
        }
        
        return audioURL
        
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
