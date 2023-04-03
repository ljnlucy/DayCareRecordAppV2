//
//  singleClassrommDetailView.swift
//  DayCareRecord
//
//  Created by Jianan Li on 4/3/23.
//

import SwiftUI

struct singleClassrommDetailView: View {
    @EnvironmentObject var daycare : DayCareClass
    var classroom : classRoom        
    var body: some View {
        ScrollView{
            VStack(alignment: .leading){
                Text("Class overview")
                    .font(.largeTitle)
                Text("Classroom Description: \(classroom.classRoomDescription ?? "no description")")
                    .font(.title2)
                Text("Total Students: \(daycare.totalStudentInGivenClassroom(classRoom: classroom))")
                Text("Total Present Students: \(daycare.totalPresentStudentInGivenClassroom(classRoom: classroom))")

                // teacher section
                Divider()
                HStack{
                    Text("Teacher:")
                        .font(.largeTitle)
                    ForEach(daycare.teacherList){ t in
                        if t.group == classroom.classRoomName{
                            Text(t.name ?? "unknown")
                                .font(.headline)
                                .foregroundColor(t.isCheckedIn ? .green : .gray)
                        }
                    }
                }
                
                // student section
                Divider()
                
                Text("Student:")
                    .font(.largeTitle)
                ForEach(daycare.studentList){ s in
                    if s.group == classroom.classRoomName{
                        Text(s.studentName ?? "unknown")
                            .foregroundColor(s.isCheckedIn ? .green : .gray)
                    }
                }
            }
        }
    }
}


