//
//  DayCareRecordAppApp.swift
//  DayCareRecordApp
//
//  Created by Jianan Li on 5/14/22.
//

import SwiftUI
import FirebaseCore

@main
struct DayCareRecordAppApp: App {
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            homeView()
                .environmentObject(DayCareClass())
        }
    }
}
