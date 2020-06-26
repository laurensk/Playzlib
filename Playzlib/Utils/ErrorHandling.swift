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
    case savingError = "This Playz cannot be saved. If you think that's our vault, please file a bug."
    case deleteError = "An error occurred while deleting the Playz. If you think that's our vault, please file a bug."
    
    // Playback
    case playbackError = "This Playz cannot be played. If you think that's our vault, please file a bug."
    
    // Unknown
    case unknownError = "An unknown error occurred. If you think that's our vault, please file a bug."
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
