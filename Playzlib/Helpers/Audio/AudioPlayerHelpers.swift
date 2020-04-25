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
    
    var audioPlayers: [AVAudioPlayer] = []
    
    var soundPlaying: Binding<Bool> = .constant(false)
    
    var playzPlayer: AVAudioPlayer = AVAudioPlayer()
    
    override init() {
        try? AVAudioSession.sharedInstance().setCategory(.playback, mode: .default, options: [])
    }
    
    func addAudioPlayer() {
        
    }
    
    func playSound(playz: Playz) {
        if let path = Bundle.main.path(forResource: playz.audioName, ofType: nil) {
            do {
                playzPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: path))
                playzPlayer.delegate = self
                soundPlaying.wrappedValue = true
                playzPlayer.play()
            } catch {
                soundPlaying.wrappedValue = false
                print("couldn't play.. sorry!")
            }
        }
        

    }
    
    func stop(playz: Playz) {
        playzPlayer.stop()
        soundPlaying.wrappedValue = false
    }
    
    func stopAll() {
        
    }
    
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        soundPlaying.wrappedValue = false
    }
    
    
}
