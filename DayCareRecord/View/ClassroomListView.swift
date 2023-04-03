//
//  ClassroomListView.swift
//  DayCareRecord
//
//  Created by Jianan Li on 4/2/23.
//

import SwiftUI

struct ClassroomListView: View {
    @EnvironmentObject var daycare : DayCareClass
    var body: some View {
        if daycare.classRoomList.count < 2 {
            Text("No class room available")
        }
        else{
            NavigationView {
                List {
                    ForEach(daycare.classRoomList){ c in
                        NavigationLink {
                            singleClassrommDetailView(classroom: c)
                        } label: {
                            Text(c.classRoomName ?? "no classroom name")
                        }
                    }
                }
                .navigationTitle("Classroom List")
                navigationLandingView()
            }
        }
    }
}

struct ClassroomListView_Previews: PreviewProvider {
    static var previews: some View {
        ClassroomListView()
    }
}
