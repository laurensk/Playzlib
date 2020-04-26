//
//  PlayzView.swift
//  Playzlib
//
//  Created by Laurens on 24.04.20.
//  Copyright © 2020 Laurens. All rights reserved.
//

import SwiftUI

struct PlayzView: View {
    
    let playz: Playz
    var playzPlayer = PlayzAudioPlayer()
    
    @State private var soundPlaying = false
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 13).fill(Color("cardColor"))
                .frame(height: 73)
                .shadow(radius: 5, x: 2, y: 2)
            VStack {
                HStack() {
                    VStack(alignment: .leading) {
                        Text(playz.name).font(.headline).foregroundColor(Color("textColor")).padding(EdgeInsets(top: 0, leading: 0, bottom: 3, trailing: 0))
                        Text("Last played: \(playz.lastPlayed)").font(.caption).foregroundColor(Color.gray)
                    }
                    Spacer()
                }.padding(.leading)
            }
            
            HStack() {
                Spacer()
                ZStack {
                    RoundedRectangle(cornerRadius: 13).fill(LinearGradient(gradient:  Gradient(colors: [Color("playButtonGradient1"), Color("playButtonGradient2")]), startPoint: .top, endPoint: .bottom))
                        .frame(width: 73, height: 73)
                    Button(action: {
                        self.togglePlayer()
                    }) {
                        Image(systemName: self.soundPlaying ? "pause.fill" : "play.fill").resizable().scaledToFit().frame(width: 25, height: 25).foregroundColor(Color.white)
                    }
                }
            }
        }.onReceive(NotificationCenter.default.publisher(for: NSNotification.Name("stopAudio"))) { _ in
            self.checkForSimultaneouslyPlays()
        }
    }
    
    func togglePlayer() {
        
        playzPlayer.soundPlaying = $soundPlaying
        
        if soundPlaying {
            stopPlayingPlayz()
        } else {
            playPlayz()
        }
    }
    
    func checkForSimultaneouslyPlays() {
        
        if !Settings.getSetting(setting: .AllowSimultaneouslyPlays) {
            stopPlayingPlayz()
        }
    }
    
    func playPlayz() {
        
        let nc = NotificationCenter.default
        nc.post(name: Notification.Name("stopAudio"), object: nil)
        
        self.playzPlayer.playSound(playz: playz)
    }
    
    func stopPlayingPlayz() {
        
        self.playzPlayer.stop(playz: self.playz)
    }
    
}

struct PlayzView_Previews: PreviewProvider {
    static var previews: some View {
        PlayzView(playz: Playz(uuid: UUID(), name: "Leave the class. Leave!", audioName: "klasseraus.mp3", lastPlayed: "Today", creationDate: "Today"))
    }
}
