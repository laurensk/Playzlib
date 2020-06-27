//
//  ErrorPresenterApp.swift
//  Playzlib
//
//  Created by Laurens on 26.06.20.
//  Copyright © 2020 Laurens. All rights reserved.
//

import Foundation
import UIKit

public class ErrorPresenter {
    
    public func presentErrorAlert(error: PlayzlibError) {
        let vc = UIApplication.shared.windows.first!.rootViewController
        let alert = UIAlertController(title: "Uups!", message: "\(error)", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.cancel, handler: nil))
        vc!.present(alert, animated: true, completion: nil)
    }
    
    public func presentCustomErrorAlert(error: String) {
        let vc = UIApplication.shared.windows.first!.rootViewController
        let alert = UIAlertController(title: "Uups!", message: "\(error)", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.cancel, handler: nil))
        vc!.present(alert, animated: true, completion: nil)
    }
}
