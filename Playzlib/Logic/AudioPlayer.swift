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
    var playzPlayer: AVAudioPlayer = AVAudioPlayer()
    
    override init() {
        try? AVAudioSession.sharedInstance().setCategory(.playback, mode: .default, options: [])
    }
    
    func playSound(playz: Playz) {
        do {
            playzPlayer = try AVAudioPlayer(contentsOf: URL(resolvingAliasFileAt: playz.audioUrl!)) // at this point i cannot read the icloud file. i have to use a local copy!
            playzPlayer.delegate = self
            soundPlaying.wrappedValue = true
            playzPlayer.play()
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
