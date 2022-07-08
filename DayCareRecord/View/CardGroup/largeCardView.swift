//
//  largeCardView.swift
//  DayCareRecordApp
//
//  Created by Jianan Li on 5/29/22.
//

import SwiftUI

struct largeCardView: View {
    /// large card for teacher/student/classroom list view,
    @EnvironmentObject var daycare : DayCareClass
    var teacher : Teacher
    
    var body: some View {
        NavigationLink {
            SingleTeacherDetailView()
                .onAppear {
                    daycare.selectedTeacher = teacher
                }
        } label: {
            ZStack{
                Rectangle()
                    .cornerRadius(10)
                    .frame(maxWidth: .infinity, alignment: .center)
                    .foregroundColor(teacher.isCheckedIn ? .green : .red)
                    .opacity(0.5)
                
                HStack(alignment: .center, spacing : 10){
                    
                    ProfileImageHandler(teacher : teacher, isLarge: true)
                        .padding(.vertical)
                    Divider()
                    
                    VStack(alignment : .leading){
                        Text("Name: " + (teacher.name ?? ""))
                        Text("Nick Name: " + (teacher.nickName ?? ""))
                        Text("UID: " + (teacher.UID ?? ""))
                        Text("Status: " + (teacher.isCheckedIn ? "IN" : "OUT" ))
                    }
                    .foregroundColor(.black)
                    .font(.caption)
                    
                }
            }
            
            
            
            
        }
        
        

    }
}



