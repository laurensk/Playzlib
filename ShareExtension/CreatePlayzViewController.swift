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

struct PlayzFile {
    var originalFile: Any?
    var fileUrl: URL?
    var fileName: String?
    var name: String?
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
                    if itemProvider.hasItemConformingToTypeIdentifier(kUTTypeMPEG4 as String) {
                        
                        itemProvider.loadItem(forTypeIdentifier: kUTTypeMPEG4 as String, options: nil, completionHandler: { file, error in
                            
                            let fileUrl = file as? URL
                            let fileName = fileUrl?.lastPathComponent
                            
                            let asset = AVURLAsset(url: fileUrl!, options: nil)
                            asset.writeAudioTrack(to: fileUrl!, success: {
                                
                                let playzFile: PlayzFile = PlayzFile(originalFile: file, fileUrl: fileUrl, fileName: fileName, name: name)
                                self.savePlayzFile(playzFile)
                                
                            }) { (error) in
                                self.saveError(errorType: .validationError)
                            }
                        })
                        
                    } else if itemProvider.hasItemConformingToTypeIdentifier(kUTTypeAudio as String) {
                        
                        itemProvider.loadItem(forTypeIdentifier: kUTTypeAudio as String, options: nil, completionHandler: { file, error in
                            
                            let fileUrl = file as? URL
                            let fileName = fileUrl?.lastPathComponent
                            
                            let playzFile: PlayzFile = PlayzFile(originalFile: file, fileUrl: fileUrl, fileName: fileName, name: name)
                            self.savePlayzFile(playzFile)
                            
                        })
                        
                    }
                }
            }
        }
        
        return true
    }
    
    private func savePlayzFile(_ playzFile: PlayzFile) {
        let store = CoreDataStack.store
        store.storePlayz(playzFile)
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
