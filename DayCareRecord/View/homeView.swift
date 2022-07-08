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
                .onAppear(perform: daycare.getTeacherList)
            
            // student list view
            // classroom list view
            // school information view
        }
        
        
    }
    
}

struct homeView_Previews: PreviewProvider {
    static var previews: some View {
        homeView()
    }
}
