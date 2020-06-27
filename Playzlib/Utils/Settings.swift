//
//  Settings.swift
//  Playzlib
//
//  Created by Laurens on 25.04.20.
//  Copyright © 2020 Laurens. All rights reserved.
//

import Foundation

enum SettingProperties: String {
    case AllowSimultaneouslyPlays = "allowSimultaneouslyPlays"
    case DisableLastPlayed = "disableLastPlayed"
}

public class Settings {
    
    static func getSetting(setting: SettingProperties) -> Bool {
        let defaults = UserDefaults.standard
        return defaults.bool(forKey: "\(setting)")
        
    }
    
    static func setSetting(setting: SettingProperties, value: Bool) {
        let defaults = UserDefaults.standard
        defaults.set(value, forKey: "\(setting)")
    }
    
}
