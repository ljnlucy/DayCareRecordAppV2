//
//  singleClassRoomDetailView.swift
//  DayCareRecordApp
//
//  Created by Jianan Li on 6/10/22.
//

import SwiftUI

struct singleClassRoomDetailView: View {
    @EnvironmentObject var daycare : DayCareClass
    
    var body: some View {
        // to show class room name, description, who belongs here(teacher and student)
        Form{
            Section {
                Text(daycare.selectedclassRoom.classRoomDescription ?? "")
            } header: {
                Text("Class Description")
            }
            
            Section("Teachers") {
                if daycare.teacherList.count != 0{
                    ForEach(daycare.teacherList) { t in
                        if t.group == daycare.selectedclassRoom.classRoomName{
                            Text(t.name ?? "unknown")
                        }
                    }
                }
            }
            Section("Student") {
                if daycare.studentList.count != 0{
                    ForEach(daycare.studentList){ s in
                        if s.group == daycare.selectedclassRoom.classRoomName{
                            Text(s.studentName ?? "unknown")
                        }
                    }
                }
            }
        }
        .navigationTitle(daycare.selectedclassRoom.classRoomName ?? "")
        .toolbar {
            Button {
                daycare.deleteclassRoomProfile()
            } label: {
                Text("Delete").font(.caption2)
                Image(systemName: "person.crop.circle.badge.xmark")
            }
            
        }
       
    }
}

struct singleClassRoomDetailView_Previews: PreviewProvider {
    static var previews: some View {
        singleClassRoomDetailView()
    }
}
