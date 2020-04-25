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
            PlayzlibView()
                .tabItem {
                    Image(systemName: "folder.circle.fill").imageScale(.large)
                    Text("Playzlib")
            }
        }
    }
}

struct TabBarView_Previews: PreviewProvider {
    static var previews: some View {
        TabBarView()
    }
}
