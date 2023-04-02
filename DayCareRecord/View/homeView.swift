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
            launchingScreen()
                .onReceive(NotificationCenter.default.publisher(for: UIApplication.didBecomeActiveNotification)) { publish in
                    daycare.autoSignOutAfterTenMinutes()
                }
        }
        else if daycare.signedInStatus == true{
            TabView{
                // teacher list view
                TeacherListView()
                    .tabItem {
                        HStack{
                            Image(systemName: "person.text.rectangle")
                            Text("Teacher")
                        }
                    }
                    .tag(0)
                
                // student list view
                StudentListView()
                    .tabItem {
                        HStack{
                            Image(systemName: "studentdesk")
                            Text("Student")
                        }
                    }
                    .tag(1)
                
                // classroom list view
                ClassroomListView()
                    .tabItem {
                        HStack{
                            Image(systemName: "studentdesk")
                            Text("Class")
                        }
                    }
                    .tag(2)
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
