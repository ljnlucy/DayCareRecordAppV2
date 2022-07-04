//
//  smallCardView.swift
//  DayCareRecordApp
//
//  Created by Jianan Li on 5/29/22.
//

import SwiftUI

struct smallCardView: View {
    /// small card for home view
    @EnvironmentObject var daycare : DayCareClass
    @Binding var isTeacherQuickViewShow : Bool
    
    var backgroundColor : Color{
        if teacher.isCheckedIn == true{
            return .green
        }
        else{
            return .red
        }
    }

    var teacher : Teacher
    var body: some View {
        Button {
            isTeacherQuickViewShow = true
            daycare.selectedTeacher = teacher
        } label: {
            ZStack(alignment : .center){
                Rectangle()
                    .frame(width: 70, height: 100)
                    .foregroundColor(backgroundColor)
                    .opacity(0.9)
                    .cornerRadius(10)
                
                VStack(alignment : .center){
                    if teacher.UID != nil{
                        ProfileImageHandler(teacher: teacher)
                    }
                    
                    Text("Status: " + (teacher.isCheckedIn ? "IN" : "OUT"))
                        .font(.caption2)
            }
            
            }
        }
    }
}


