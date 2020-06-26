//
//  ErrorPresenterExtension.swift
//  ShareExtension
//
//  Created by Laurens on 26.06.20.
//  Copyright © 2020 Laurens. All rights reserved.
//

import Foundation
import UIKit

public class ErrorPresenter {
    
    var vc = UIViewController()
    
    public func setViewController(_ viewController: UIViewController) {
        self.vc = viewController
    }
    
    public func presentErrorAlert(error: PlayzlibError) {
        let alert = UIAlertController(title: "Uups!", message: "\(error)", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.cancel, handler: nil))
        self.vc.present(alert, animated: true, completion: nil)
    }
}

