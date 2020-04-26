//
//  MyPlayzView.swift
//  Playzlib
//
//  Created by Laurens on 24.04.20.
//  Copyright © 2020 Laurens. All rights reserved.
//

import SwiftUI
import Combine

struct MyPlayzView: View {
    
    @State private var showSettings = false
    @State private var searchText = ""
    
    let navigateToOldView: some View = NavigationLink(destination: ContentView()) {
        Image(systemName: "arrow.left.circle.fill").imageScale(.large)
    }
    
    let addPlayzButton: some View = Button(action: {
        print("show add screen")
    }) {
        Image(systemName: "plus").imageScale(.large)
    }
    
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
                    ForEach(demoPlayz.filter {
                        self.searchText.isEmpty ? true : $0.name.contains(self.searchText)
                    }, id: \.self) { playz in
                        PlayzView(playz: playz).padding(EdgeInsets(top: 10, leading: 0, bottom: 0, trailing: 0))
                    }
                }
            }.navigationBarTitle("My Playz")
                .navigationBarItems(leading: showSettingsButton, trailing: addPlayzButton)
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

struct MyPlayzView_Previews: PreviewProvider {
    static var previews: some View {
        MyPlayzView().environment(\.colorScheme, .dark)
    }
}
