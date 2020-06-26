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
                    Section() {
                        VStack {
                            HStack {
                                Spacer()
                                Image("createPlayzIcon").resizable().scaledToFit().padding(.bottom, 4)
                                Spacer()
                            }
                            Text("Playzlib").font(.system(size: 25, design: .rounded)).fontWeight(.bold).foregroundColor(Color("accentColor"))
                        }.padding()
                        
                    }.frame(height: 200)
                    Section(header: Text("AUDIO SETTINGS")) {
                        List {
                            VStack {
                                Toggle(isOn: $settings.allowSimultaneouslyPlays) {
                                    Text("Allow simultaneous plays")
                                }
                            }
                        }
                    }
                    Section(header: Text("ABOUT")) {
                        List {
                            HStack {
                                Text("Developer").fontWeight(.semibold)
                                Text("Laurens K.")
                            }.onTapGesture(perform: { print("developer") })
                            HStack {
                                Text("Twitter").fontWeight(.semibold)
                                Text("@laurensk")
                            }.onTapGesture(perform: { print("twitter") })
                            HStack {
                                Text("Contact").fontWeight(.semibold)
                                Text("hello@laurensk.at")
                            }.onTapGesture(perform: { print("contact") })
                        }
                    }
                }.listStyle(GroupedListStyle())
                .environment(\.horizontalSizeClass, .regular)
            }.navigationBarTitle("Settings")
            .navigationViewStyle(StackNavigationViewStyle())
        }.onAppear {
            self.setupUI()
        }
    }
    
    func setupUI() {
        UISwitch.appearance().onTintColor = UIColor(named: "accentColor")
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
