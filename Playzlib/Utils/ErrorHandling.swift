//
//  ErrorHandling.swift
//  Playzlib
//
//  Created by Laurens on 01.05.20.
//  Copyright © 2020 Laurens. All rights reserved.
//

import Foundation
import UIKit

public enum PlayzlibError: String {
    
    // File system
    case curruptedFileError = "curruptedFileError"
    case savingError = "savingError"
    
    // Unknown
    case unknownError = "unknownError"
}

public class ErrorHandling {
    
    static let errorHandling = ErrorHandling()
    
    static let errorPresenter = ErrorPresenter()
    
    public func throwError(error: PlayzlibError, showError: Bool) {
        print("[PLAYZLIB-ERROR] Error: \(error)")
        if showError {
            ErrorHandling.errorPresenter.presentErrorAlert(error: error)
        }
    }
    
}
