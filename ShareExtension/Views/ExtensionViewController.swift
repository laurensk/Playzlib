//
//  ExtensionViewController.swift
//  ShareExtension
//
//  Created by Laurens on 01.05.20.
//  Copyright © 2020 Laurens. All rights reserved.
//

import UIKit
import MobileCoreServices
import SwiftUI

class ExtensionViewController: UIViewController {
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.view.backgroundColor = .systemGray6
        
        setupNavBar()
        setupViews()
    }
    
    @objc private func cancelAction () {
        
        let error = NSError(domain: "com.laurensk.Playzlib.ShareExtension", code: 0, userInfo: [NSLocalizedDescriptionKey: "An error description"])
        extensionContext?.cancelRequest(withError: error)
    }
    
    private func setupNavBar() {
        self.navigationItem.title = "Create Playz"
        
        let itemCancel = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancelAction))
        self.navigationItem.setLeftBarButton(itemCancel, animated: false)
    }
    
    private func setupViews() {
        
        let swiftUIView = UIHostingController(rootView: CreatePlayzView(extensionContext: extensionContext))
        self.view.addSubview(swiftUIView.view)
        swiftUIView.view.frame = self.view.bounds
        
    }
    
}

// MARK: - CreatePlayzNavigationController

@objc(ExtensionNavigationController)
class ExtensionNavigationController: UINavigationController {
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
        self.setViewControllers([ExtensionViewController()], animated: false)
    }
    
    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}

extension UIView {
    func pinEdges(to other: UIView) {
        leadingAnchor.constraint(equalTo: other.leadingAnchor).isActive = true
        trailingAnchor.constraint(equalTo: other.trailingAnchor).isActive = true
        topAnchor.constraint(equalTo: other.topAnchor).isActive = true
        bottomAnchor.constraint(equalTo: other.bottomAnchor).isActive = true
    }
}
