//
//  EditPlayzView.swift
//  Playzlib
//
//  Created by Laurens on 17.06.20.
//  Copyright © 2020 Laurens. All rights reserved.
//

import SwiftUI

struct EditPlayzView: View {
    
    //let playz: Playz?
    
    init(){
        UITableView.appearance().backgroundColor = .clear
        UITableViewCell.appearance().backgroundColor = UIColor.systemGray6
    }
    
    @State private var playzName: String = ""
    
    var saveButton: some View {
        Button(action: {
            self.savePlayz()
        }) {
            Text("Save").fontWeight(.semibold).foregroundColor(Color("accentColor"))
        }
        
    }
    
    var body: some View {
        NavigationView {
            VStack {
                ScrollView {
                    VStack {
                        Image("createPlayzIcon")
                            .resizable()
                            .scaledToFit()
                            .padding()
                        Text("Edit Playz")
                            .font(.system(.title, design: .rounded))
                            .fontWeight(.bold)
                            .foregroundColor(Color("accentColor"))
                    }.padding(.top, 30)
                    Form {
                        Section {
                            List {
                                VStack {
                                    TextField("Give your Playz a name", text: $playzName).multilineTextAlignment(.center)
                                }
                            }
                        }
                        Section {
                            List {
                                VStack {
                                    HStack {
                                        Spacer()
                                        Button(action: {
                                            self.savePlayz()
                                        }) {
                                            Text("Save Playz").foregroundColor(Color("accentColor"))
                                        }
                                        Spacer()
                                    }
                                }
                            }
                        }
                    }.listStyle(GroupedListStyle())
                    .environment(\.horizontalSizeClass, .regular)
                }
            }.navigationBarTitle(Text("Edit Playz"), displayMode: .inline)
                .navigationBarItems(trailing: saveButton)
        }
    }
    
    
    func savePlayz() {
        
    }
}

struct EditPlayzView_Previews: PreviewProvider {
    static var previews: some View {
        EditPlayzView()
    }
}
