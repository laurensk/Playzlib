//
//  EditPlayzView.swift
//  Playzlib
//
//  Created by Laurens on 17.06.20.
//  Copyright © 2020 Laurens. All rights reserved.
//

import SwiftUI

struct EditPlayzView: View {
    
    let playz: Playz?
    
    init(playz: Playz) {
        self.playz = playz
    }
    
    @Environment(\.managedObjectContext) var context
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.colorScheme) var colorScheme
    
    @State private var playzName: String = ""
    
    var saveButton: some View {
        Button(action: {
            self.savePlayz()
        }) {
            Text("Save").fontWeight(.semibold).foregroundColor(Color("accentColor"))
        }
    }
    
    var cancelButton: some View {
        Button(action: {
            self.presentationMode.wrappedValue.dismiss()
        }) {
            Text("Cancel").foregroundColor(Color("accentColor"))
        }
    }
    
    var body: some View {
        NavigationView {
            VStack {
                Form {
                    Section {
                        VStack {
                            HStack {
                                Spacer()
                                Image("createPlayzIcon").resizable().scaledToFit().padding(.bottom, 4)
                                Spacer()
                            }
                            Text("Edit Playz").font(.system(size: 25, design: .rounded)).fontWeight(.bold).foregroundColor(Color("accentColor"))
                        }.padding()
                        
                    }.frame(height: 200)
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
            }.navigationBarTitle(Text("Edit Playz"), displayMode: .inline)
                .navigationBarItems(leading: cancelButton, trailing: saveButton)
        }.navigationViewStyle(StackNavigationViewStyle())
            .onAppear {
                if let name = self.playz?.name {
                    self.playzName = name
                }
        }
    }
    
    func savePlayz() {
        self.playz?.name = self.playzName
        do {
            try self.context.save()
        } catch let error as NSError {
            print(error)
        }
        self.presentationMode.wrappedValue.dismiss()
    }
}
