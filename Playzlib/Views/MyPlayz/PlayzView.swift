//
//  PlayzView.swift
//  Playzlib
//
//  Created by Laurens on 24.04.20.
//  Copyright © 2020 Laurens. All rights reserved.
//

import SwiftUI

struct PlayzView: View {
    
    @EnvironmentObject var playbackPlayz: PlaybackPlayz
    
    let playz: Playz
    var playzPlayer = PlayzAudioPlayer()
    
    let activityViewController = SwiftUIActivityViewController()
    
    @State private var soundPlaying = false
    @State private var showMenuSheet = false
    @State private var showShareSheet = false
    
    var body: some View {
        
        ZStack {
            RoundedRectangle(cornerRadius: 13).fill(Color("cardColor"))
                .frame(height: 73)
                .shadow(radius: 3, x: 1.5, y: 1.5) // .shadow(radius: 5, x: 2, y: 2)
            HStack {
                VStack {
                    HStack() {
                        VStack(alignment: .leading) {
                            Text(playz.name ?? "Untitled").font(.headline).foregroundColor(Color("textColor")).padding(EdgeInsets(top: 0, leading: 0, bottom: 3, trailing: 0))
                            Text("Last played: Today").font(.caption).foregroundColor(Color.gray)
                        }
                        Spacer()
                    }.padding(.leading)
                }
                Spacer()
                Button(action: {
                    self.showMenuSheet.toggle()
                }) {
                    Image(systemName: "ellipsis").rotationEffect(.degrees(90)).imageScale(.large).foregroundColor(.secondary)
                }.actionSheet(isPresented: $showMenuSheet) {
                    ActionSheet(title: Text("Playz"), message: Text("\(playz.name ?? "Untitled")"), buttons: [
                        .default(Text("Share Playz"), action: {
                            self.showShareSheet.toggle()
                        }),
                        .default(Text("Edit Playz"), action: {print(self.playz.audioUrl)}),
                        .destructive(Text("Delete Playz"), action: {print("delete")}),
                        .cancel()
                    ])
                }.sheet(isPresented: $showShareSheet) {
                    SwiftUIActivityViewController(audioURL: self.playz.audioUrl)
                }
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
            
        }.onReceive(playbackPlayz.$playbackPlayz) {_ in
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
        
        if !Settings.getSetting(setting: .AllowSimultaneouslyPlays) && self.playbackPlayz.playbackPlayz != self.playz {
            stopPlayingPlayz()
        }
    }
    
    func playPlayz() {
        
        self.playbackPlayz.playbackPlayz = playz
        
        self.playzPlayer.playSound(playz: playz)
    }
    
    func stopPlayingPlayz() {
        if soundPlaying {
         self.playzPlayer.stop(playz: self.playz)
        }
    }
    
}
