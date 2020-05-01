//
//  ErrorHandling.swift
//  Playzlib
//
//  Created by Laurens on 01.05.20.
//  Copyright © 2020 Laurens. All rights reserved.
//

import Foundation

public class ErrorHandling {
    
    static let errorHandling = ErrorHandling()
    
    public func curruptedFileError() {
        print("curruptedFileError")
    }
    
    public func savingError() {
        print("savingError")
    }
    
    public func unknownError() {
        print("unknownError")
    }
    
}
