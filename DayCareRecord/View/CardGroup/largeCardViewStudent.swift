//
//  largeCardViewStudent.swift
//  DayCareRecordApp
//
//  Created by Jianan Li on 6/6/22.
//

import SwiftUI

struct largeCardViewStudent: View {
    @EnvironmentObject var daycare : DayCareClass
    var student : Student
    
    var body: some View {
        NavigationLink {
            SingleStudentDetailView()
                .onAppear {
                    daycare.selectedStudent = student
                }
        } label: {
            ZStack{
                Rectangle()
                    .cornerRadius(10)
                    .frame(maxWidth: .infinity, alignment: .center)
                    .foregroundColor(student.isCheckedIn ? .green : .red)
                    .opacity(0.5)
                
                HStack(alignment: .center, spacing : 10){
                    ProfileImageHandler(student : student, isLarge: true)
                        .padding(.vertical)
                    Divider()
                    
                    VStack(alignment : .leading){
                        Text("Name: " + (student.studentName ?? ""))
                        Text("Guardian Name: " + (student.guardianName ?? ""))
                        Text("UID: " + (student.UID ?? ""))
                        Text("Status: " + (student.isCheckedIn ? "IN" : "OUT" ))
                    }
                    .foregroundColor(.black)
                    .font(.caption)
                    
                }
            }
        }
    }
}


