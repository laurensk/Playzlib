//
//  SwiftUIView.swift
//  ShareExtension
//
//  Created by Laurens on 01.05.20.
//  Copyright © 2020 Laurens. All rights reserved.
//

import SwiftUI

struct CreatePlayzView: View {
    
    let extensionContext: NSExtensionContext?
    
    @State private var playzName: String = ""
    
    var body: some View {
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
                                    self.createPlayz()
                                }) {
                                    Text("Create Playz").foregroundColor(Color("accentColor"))
                                }
                                Spacer()
                            }
                        }
                    }
                }
            }.listStyle(GroupedListStyle())
                .environment(\.horizontalSizeClass, .regular)
        }
        
    }
    
    
    func createPlayz() {
        if !playzName.isEmpty {
            ExtensionHelpers.extensionHelpers.getFileFromExtensionAndSave(name: playzName, extensionContext)
        }
    }
}
