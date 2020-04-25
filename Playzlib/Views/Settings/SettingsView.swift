//
//  SettingsView.swift
//  Playzlib
//
//  Created by Laurens on 25.04.20.
//  Copyright © 2020 Laurens. All rights reserved.
//

import SwiftUI

struct SettingsToggle {
    var allowSimultaneouslyPlays: Bool = Settings.getSetting(setting: .AllowSimultaneouslyPlays) {
        didSet {
            Settings.setSetting(setting: .AllowSimultaneouslyPlays, value: allowSimultaneouslyPlays)
        }
    }
}

struct SettingsView: View {
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @State var settings = SettingsToggle()
    
    var body: some View {
        NavigationView {
            VStack {
                Form {
                    Section(header: Text("AUDIO SETTINGS")) {
                        List {
                            VStack {
                                Toggle(isOn: $settings.allowSimultaneouslyPlays) {
                                    Text("Allow simultaneously plays")
                                }
                            }
                        }
                    }
                }
            }.navigationBarTitle("Settings")
                .navigationBarItems(trailing: Button(action: {
                    self.presentationMode.wrappedValue.dismiss()
                }) {
                    Text("Done").fontWeight(.semibold)
                })
        }.onAppear {
            self.setupUI()
        }
    }
    
    func setupUI() {
        UITableView.appearance().tableFooterView = UIView()
        UITableView.appearance().separatorStyle = .singleLine
        UITableView.appearance().allowsSelection = true
        UITableViewCell.appearance().selectionStyle = .default
    }
    
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
