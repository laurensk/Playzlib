//
//  File.swift
//  Playzlib
//
//  Created by Laurens on 25.04.20.
//  Copyright © 2020 Laurens. All rights reserved.
//

import Foundation

struct Playz: Hashable, Codable {
    let uuid: UUID
    let name: String
    let audioName: String // will then be the filesystem url which is the same as the uuid
    let lastPlayed: String // will then be a Date()
    let creationDate: String // will then be a Date()
}
