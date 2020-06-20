//
//  HowToView.swift
//  Playzlib
//
//  Created by Laurens on 16.06.20.
//  Copyright © 2020 Laurens. All rights reserved.
//

import SwiftUI

struct HowToView: View {
    var body: some View {
        NavigationView {
            VStack {
                Text("How to add a Playz")
            }.navigationBarTitle("Add Sounds")
            .navigationViewStyle(StackNavigationViewStyle())
        }.onAppear {
            self.setupUI()
        }
    }
    
    func setupUI() {
        // ui to come
    }
}

struct HowToView_Previews: PreviewProvider {
    static var previews: some View {
        HowToView()
    }
}
