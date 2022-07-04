//
//  homeView.swift
//  DayCareRecordApp
//
//  Created by Jianan Li on 6/13/22.
//

import SwiftUI

struct homeView: View {
    @EnvironmentObject var daycare : DayCareClass
    
    
    var body: some View {
        if daycare.signedInStatus == false{
            
            LoginView()
                .onReceive(NotificationCenter.default.publisher(for: UIApplication.didBecomeActiveNotification)) { publish in
                    daycare.autoSignOutAfterTenMinutes()
                }
        }
        else if daycare.signedInStatus == true {
            TabView{
                mainTabView()
                    .tabItem {
                        VStack{
                            Image(systemName: "house")
                            Text("Home")
                        }
                    }
                schoolInformationTabView()
                    .tabItem {
                        VStack{
                            Image(systemName: "info.circle")
                            Text("Information")
                        }
                    }
            }
            .onReceive(NotificationCenter.default.publisher(for: UIApplication.didBecomeActiveNotification)) { publish in
                daycare.autoSignOutAfterTenMinutes()
            }
        }
        else{
            ProgressView("Loading...")
        }
        
        
        
    }
    
}

struct homeView_Previews: PreviewProvider {
    static var previews: some View {
        homeView()
    }
}
