//
//  AudioPlayer.swift
//  Playzlib
//
//  Created by Laurens on 25.04.20.
//  Copyright © 2020 Laurens. All rights reserved.
//

import Foundation
import AVFoundation
import SwiftUI

class PlayzAudioPlayer: NSObject, ObservableObject, AVAudioPlayerDelegate {
    
    var soundPlaying: Binding<Bool> = .constant(false)
    var playzPlayer: AVAudioPlayer! = nil
    
    override init() {
        try? AVAudioSession.sharedInstance().setCategory(.playback, mode: .default, options: [])
    }
    
    func playSound(playz: Playz) {
        do {
            playzPlayer = try AVAudioPlayer(contentsOf: playz.audioUrl!, fileTypeHint: nil)
            playzPlayer.prepareToPlay()
            playzPlayer.delegate = self
            playzPlayer.play()
            soundPlaying.wrappedValue = true
        } catch {
            let errorHandling = ErrorHandling()
            errorHandling.throwError(error: .playbackError, showError: true)
            soundPlaying.wrappedValue = false
        }
    }
    
    func stop(playz: Playz) {
        playzPlayer.stop()
        soundPlaying.wrappedValue = false
    }
    
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        soundPlaying.wrappedValue = false
    }
    
    
}
