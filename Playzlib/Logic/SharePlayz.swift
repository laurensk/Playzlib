//
//  SharePlayz.swift
//  Playzlib
//
//  Created by Laurens on 30.04.20.
//  Copyright © 2020 Laurens. All rights reserved.
//

import Foundation
import UIKit
import SwiftUI

struct SwiftUIActivityViewController : UIViewControllerRepresentable {
    
    var audioURL: URL?

    func makeUIViewController(context: Context) -> UIActivityViewController {
        
        let vc = UIActivityViewController(activityItems: [audioURL!], applicationActivities: [])
        vc.excludedActivityTypes =  [
            UIActivity.ActivityType.postToWeibo,
            UIActivity.ActivityType.assignToContact,
            UIActivity.ActivityType.addToReadingList,
            UIActivity.ActivityType.postToVimeo,
            UIActivity.ActivityType.postToTencentWeibo,
            UIActivity.ActivityType(rawValue: "com.laurensk.Playzlib.ShareExtension")
        ]
        
        return vc
        
    }
    func updateUIViewController(_ uiViewController: UIActivityViewController, context: Context) {
        //
    }
}
