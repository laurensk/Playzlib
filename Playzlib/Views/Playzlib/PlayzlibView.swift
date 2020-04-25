//
//  PlayzlibView.swift
//  Playzlib
//
//  Created by Laurens on 24.04.20.
//  Copyright © 2020 Laurens. All rights reserved.
//

import SwiftUI

struct PlayzlibView: View {
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    Text("Idk if we can make that...")
                }
            }.navigationBarTitle("Playzlib")
        }.navigationViewStyle(StackNavigationViewStyle())
    }
}

struct PlayzlibView_Previews: PreviewProvider {
    static var previews: some View {
        PlayzlibView()
    }
}
