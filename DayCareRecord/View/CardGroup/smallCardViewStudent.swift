//
//  smallCardViewStudent.swift
//  DayCareRecordApp
//
//  Created by Jianan Li on 6/6/22.
//

import SwiftUI

struct smallCardViewStudent: View {
    @EnvironmentObject var daycare : DayCareClass
    @Binding var isStudentQuickViewShow : Bool
    
    var backgroundColor : Color{
        if student.isCheckedIn == true{
            return .green
        }
        else{
            return .red
        }
    }

    var student : Student
    var body: some View {
        Button {
            isStudentQuickViewShow = true
            daycare.selectedStudent = student
        } label: {
            ZStack(alignment : .center){
                Rectangle()
                    .frame(width: 70, height: 100)
                    .foregroundColor(backgroundColor)
                    .opacity(0.9)
                    .cornerRadius(10)
                
                VStack(alignment : .center){
                    if student.UID != nil{
                        ProfileImageHandler(student: student)
                    }
                    
                    Text("Status: " + (student.isCheckedIn ? "IN" : "OUT"))
                        .font(.caption2)
            }
            
            }
        }
    }
}

