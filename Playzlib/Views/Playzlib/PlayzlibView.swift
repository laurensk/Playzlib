//
//  PlayzlibView.swift
//  Playzlib
//
//  Created by Laurens on 24.04.20.
//  Copyright © 2020 Laurens. All rights reserved.
//

import SwiftUI

struct PlayzlibView: View {
    
    @State private var showSettings = false
    @State private var searchText = ""
    
    var showSettingsButton: some View {
        Button(action: {
            self.showSettings.toggle()
        }) {
            Image(systemName: "gear").imageScale(.large)
        }
    }
    
    var body: some View {
        NavigationView {
            VStack {
                SearchBarView(searchText: $searchText).padding(EdgeInsets(top: 10, leading: 5, bottom: 0, trailing: 5))
                Spacer()
                VStack {
                    Text("We're working\non the Playzlib.").fontWeight(.semibold).multilineTextAlignment(.center)
                }
                Spacer()
            }.navigationBarTitle("Playzlib")
                .navigationBarItems(leading: showSettingsButton)
        }.navigationViewStyle(StackNavigationViewStyle())
            .sheet(isPresented: $showSettings) {
                SettingsView()
        }
    }
}

struct PlayzlibView_Previews: PreviewProvider {
    static var previews: some View {
        PlayzlibView()
    }
}
