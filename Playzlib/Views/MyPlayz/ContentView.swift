//
//  ContentView.swift
//  Playzlib
//
//  Created by Laurens on 23.04.20.
//  Copyright © 2020 Laurens. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    init() {
        UITableView.appearance().tableFooterView = UIView()
        UITableView.appearance().separatorStyle = .none
        UITableView.appearance().allowsSelection = false
        UITableViewCell.appearance().selectionStyle = .none
    }
    
    var body: some View {
        NavigationView {
            VStack {
                List {
                    ForEach(0...4, id: \.self) { playz in
                        ZStack {
                            RoundedRectangle(cornerRadius: 13).fill(Color("cardColor"))
                                .frame(height: 160)
                                .shadow(radius: 5, x: 2, y: 2)
                                .padding(.top)
                            VStack {
                                HStack() {
                                    VStack(alignment: .leading) {
                                        Text("Aus der Klasse raus").font(.title).foregroundColor(Color("textColor"))
                                        Text("Hinzugefügt am: Heute").font(.subheadline).foregroundColor(Color("textColor"))
                                    }
                                    Spacer()
                                }.padding()
                                HStack {
                                    Button(action: {
                                        print("works")
                                    }) {
                                        Image(systemName: "square.and.arrow.up").resizable().scaledToFit().frame(width: 25, height: 25).foregroundColor(Color("textColor"))
                                    }.padding(.trailing)
                                    Button(action: {
                                        print("works")
                                    }) {
                                        Image(systemName: "trash").resizable().scaledToFit().frame(width: 25, height: 25).foregroundColor(Color("textColor"))
                                    }.padding(.trailing)
                                    Button(action: {
                                        print("works")
                                    }) {
                                        Image(systemName: "square.and.pencil").resizable().scaledToFit().frame(width: 25, height: 25).foregroundColor(Color("textColor"))
                                    }
                                }.padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 70))
                            }.padding()
                            
                            HStack() {
                                Spacer()
                                ZStack {
                                    RoundedRectangle(cornerRadius: 13).fill(LinearGradient(gradient:  Gradient(colors: [Color("playButtonGradient1"), Color("playButtonGradient2")]), startPoint: .top, endPoint: .bottom))
                                        .frame(width: 70, height: 160)
                                    .padding(.top)
                                    Button(action: {
                                        print("works")
                                    }) {
                                        Image(systemName: "play.fill").resizable().scaledToFit().frame(width: 25, height: 25).foregroundColor(Color.white).padding(.top)
                                    }
                                }
                            }
                        }
                    }
                }
            }.navigationBarTitle("My Playz")
            .navigationBarItems(trailing:
                Button(action: {}) {
                    Image(systemName: "plus").imageScale(.large)
                }
            )
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
