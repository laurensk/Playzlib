////
////  AudioPlayerHelpers2.swift
////  Playzlib
////
////  Created by Laurens on 25.04.20.
////  Copyright © 2020 Laurens. All rights reserved.
////
//
//import Foundation
//import AVFoundation
//
//struct PlayzPlayer {
//    var playz: Playz
//    var audioPlayer: AVAudioPlayer
//    var isPlaying: Bool
//}
//
//public class PlayzAudioPlayer2: NSObject, AVAudioPlayerDelegate {
//
//    static var playzPlayers: [PlayzPlayer] = []
//
//    override init() {
//        try? AVAudioSession.sharedInstance().setCategory(.playback, mode: .default, options: [])
//    }
//
//    static func playSound(playz: Playz) { // muss von anderen klassen erreichbar sein
//        if var playzPlayer = playzPlayers.first(where: {$0.playz == playz}) {
//            playerPlayAudio(playzPlayer: &playzPlayer)
//        } else {
//            addPlayerAndPlay(playz: playz)
//        }
//    }
//
//    static func stopSound(playz: Playz) {
//        if var playzPlayer = playzPlayers.first(where: {$0.playz == playz}) {
//            playerStopAudio(playzPlayer: &playzPlayer)
//        }
//    }
//
//    static func addPlayerAndPlay(playz: Playz) {
//        let newPlayer: PlayzPlayer = PlayzPlayer(playz: playz, audioPlayer: AVAudioPlayer(), isPlaying: false)
//        playzPlayers.append(newPlayer)
//        playerPlayAudio(playzPlayer: &playzPlayers[playzPlayers.count-1])
//    }
//
//    static func deletePlayer(playz: Playz) {
//        if let index = playzPlayers.firstIndex(where: { $0.playz == playz }) {
//            playzPlayers.remove(at: index)
//        }
//    }
//
//    static func deleteAllPlayers() {
//        stopAll()
//        playzPlayers.removeAll()
//    }
//
//    static func playerPlayAudio(playzPlayer: inout PlayzPlayer) {
//        if let path = Bundle.main.path(forResource: playzPlayer.playz.audioName, ofType: nil) {
//            do {
//                playzPlayer.audioPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: path))
//                //playzPlayer.audioPlayer.delegate = self
//                playzPlayer.audioPlayer.play()
//            } catch {
//                print("something failed...")
//            }
//        }
//    }
//
//    static func playerStopAudio(playzPlayer: inout PlayzPlayer) {
//        playzPlayer.audioPlayer.stop()
//        playzPlayer.isPlaying = false
//    }
//
//    static func stopAll() {
//        for var player in playzPlayers {
//            playerStopAudio(playzPlayer: &player)
//        }
//    }
//
////    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
////        print("\(player.url!)")
////    }
//
//
//}
