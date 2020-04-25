//
//  MyPlayzView.swift
//  Playzlib
//
//  Created by Laurens on 24.04.20.
//  Copyright © 2020 Laurens. All rights reserved.
//

import SwiftUI

struct MyPlayzView: View {
    
    init() {
        setupUI()
    }
    
    let addPlayzButton: some View = Button(action: {
        print("show add screen")
    }) {
        Image(systemName: "plus").imageScale(.large)
    }
    
    let navigateToOldView: some View = NavigationLink(destination: ContentView()) {
        Image(systemName: "arrow.left.circle.fill").imageScale(.large)
    }
    
    var body: some View {
        NavigationView {
            VStack {
                List {
                    ForEach(demoPlayz, id: \.self) { playz in
                        PlayzView(playz: playz).padding(EdgeInsets(top: 10, leading: 0, bottom: 0, trailing: 0))
                    }
                }
            }.navigationBarTitle("My Playz")
                .navigationBarItems(trailing: addPlayzButton)
        }.navigationViewStyle(StackNavigationViewStyle())
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
