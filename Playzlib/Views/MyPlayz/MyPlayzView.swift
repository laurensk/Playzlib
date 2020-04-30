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
    
    @Environment(\.managedObjectContext) var context
    
    @FetchRequest(
        entity: Playz.entity(),
        sortDescriptors: [NSSortDescriptor(keyPath: \Playz.creationDate, ascending: false)]
    ) var fetchedPlayz: FetchedResults<Playz>
    
    @State private var showSettings = false
    @State private var searchText = ""
    
    var addPlayzButton: some View {
        Button(action: {
            //self.addPlayz()
        }) {
            Image(systemName: "plus").imageScale(.large)
        }
        
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
                    ForEach(fetchedPlayz.filter {
                        self.searchText.isEmpty ? true : $0.name!.contains(self.searchText)
                    }, id: \.uuid) { playz in
                        PlayzView(playz: playz).padding(.top, 10)
                    }
                }.buttonStyle(BorderlessButtonStyle())
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
        MyPlayzView()
    }
}
