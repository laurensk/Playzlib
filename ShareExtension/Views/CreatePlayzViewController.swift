//
//  CreatePlayzViewController.swift
//  ShareExtension
//
//  Created by Laurens on 27.04.20.
//  Copyright © 2020 Laurens. All rights reserved.
//

import UIKit
import MobileCoreServices

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
    
    // MARK: - Save Playz
    
    @objc private func cancelAction () {
        
        let error = NSError(domain: "some.bundle.identifier", code: 0, userInfo: [NSLocalizedDescriptionKey: "An error description"])
        extensionContext?.cancelRequest(withError: error)
    }
    
    @objc private func saveAction() {
        savePlayz(name: textField.text ?? "Untitled")
    }
    
    private func savePlayz(name: String) {
        ExtensionHelpers.extensionHelpers.getFileFromExtensionAndSave(name: name, extensionContext)
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
