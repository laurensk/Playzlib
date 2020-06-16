//
//  TabBar.swift
//  Playzlib
//
//  Created by Laurens on 24.04.20.
//  Copyright © 2020 Laurens. All rights reserved.
//

import SwiftUI

struct TabBarView: View {
    var body: some View {
        TabView {
            MyPlayzView()
                .tabItem {
                    Image(systemName: "play.circle.fill").imageScale(.large)
                    Text("My Playz")
            }
            HowToView()
                .tabItem {
                    Image(systemName: "plus.circle").imageScale(.large)
                    Text("How to")
            }
            SettingsView()
                .tabItem {
                    Image(systemName: "gear").imageScale(.large)
                    Text("Settings")
            }
        }.accentColor(Color("accentColor"))
    }
}

struct TabBarView_Previews: PreviewProvider {
    static var previews: some View {
        TabBarView()
    }
}
