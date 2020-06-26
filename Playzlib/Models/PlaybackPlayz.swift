//
//  PlaybackPlayz.swift
//  Playzlib
//
//  Created by Laurens on 26.04.20.
//  Copyright © 2020 Laurens. All rights reserved.
//

import Foundation
import CoreData
import UIKit

class PlaybackPlayz: ObservableObject {
    @Published var playbackPlayz: UUID = UUID()
}
