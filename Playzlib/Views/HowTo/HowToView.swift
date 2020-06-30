//
//  HowToView.swift
//  Playzlib
//
//  Created by Laurens on 16.06.20.
//  Copyright © 2020 Laurens. All rights reserved.
//

import SwiftUI

struct HowToView: View {
    
    private var titles: [String] = ["Find a Sound", "Prepare the Sound", "Add the Sound to Playzlib", "Enjoy!"]
    private var texts: [String] = [
        "Before you can start adding and enjoying sounds in Playzlib, you have to find and prepare it. Start by searching for a audio or video file you want to add to Playzlib. If you've got an audio file already, you can skip to step 3.",
        "Since your sound may not be an audio only file and may be a video, you have to prepare it for Playzlib. You can do that using the screen-recording feature of iOS. Just record a video into your gallery and you're done.",
        "After your sound is in your gallery or in the files app, you can select it, click on this share button and select \"Playzlib\" to add your sound. Find a good name and you're good to go.",
        "You're done! After you start/restart the Playzlib app the next time, your newly created Playz waits to get played!"
    ]
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    ForEach(0...titles.count-1, id: \.self) {
                        self.generateHowTo(index: $0)
                    }
                }.padding()
                    .navigationBarTitle("Add Sounds")
                    .navigationViewStyle(StackNavigationViewStyle())
            }
        }
    }
    
    func generateHowTo(index: Int) -> some View {
        switch index {
        case 0:
            return AnyView(VStack {
                titleRow(number: "\(index+1)", title: "\(titles[index])")
                descText(text: "\(texts[index])")
            })
        default:
            return AnyView(VStack {
                titleRow(number: "\(index+1)", title: "\(titles[index])")
                descText(text: "\(texts[index])")
            }.padding(.top, 30))
        }
    }
    
    func titleRow(number: String, title: String) -> some View {
        return HStack {
            ZStack {
                Circle().foregroundColor(Color(UIColor.systemGray5)).frame(width: 45, height: 45)
                Text("\(number)").font(.title).fontWeight(.bold)
            }
            Text("\(title)").fontWeight(.semibold).font(.system(size: 20)).padding(.leading, 10)
            Spacer()
        }.padding(.top, 5).padding(.bottom, 5)
    }
    
    func descText(text: String) -> some View {
        return HStack {
            Text("\(text)").fixedSize(horizontal: false, vertical: true)
        }
    }
}

struct HowToView_Previews: PreviewProvider {
    static var previews: some View {
        HowToView()
    }
}
