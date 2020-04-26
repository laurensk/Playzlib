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
                List {
                    SearchBarView(searchText: $searchText).padding(.top, 10)
                    Spacer()
                    HStack {
                        Spacer()
                        Text("We're working\non the Playzlib").fontWeight(.semibold).multilineTextAlignment(.center)
                        Spacer()
                    }
                }
            }.navigationBarTitle("Playzlib")
                .navigationBarItems(leading: showSettingsButton)
        }.navigationViewStyle(StackNavigationViewStyle())
            .sheet(isPresented: $showSettings) {
                SettingsView()
        }.onAppear {
            self.setupUI()
        }
    }
    
    func setupUI() {
        UITableView.appearance().tableFooterView = UIView()
        UITableView.appearance().separatorStyle = .none
        UITableView.appearance().allowsSelection = false
        UITableViewCell.appearance().selectionStyle = .none
    }
}

struct PlayzlibView_Previews: PreviewProvider {
    static var previews: some View {
        PlayzlibView()
    }
}
