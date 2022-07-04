//
//  smallCardViewClassRoom.swift
//  DayCareRecordApp
//
//  Created by Jianan Li on 6/10/22.
//

import SwiftUI

struct smallCardViewClassRoom: View {
    @EnvironmentObject var daycare : DayCareClass
    @Binding var isClassRoomQuickViewShow : Bool
    var classroom : classRoom
    var backgroundColor : Color{
        for s in daycare.studentList{
            if s.isCheckedIn == true && s.group == classroom.classRoomName{
                return .green
                break
            }
        }
        return .red
    }

    
    var body: some View {
        Button {
            isClassRoomQuickViewShow = true
            daycare.selectedclassRoom = classroom
        } label: {
            ZStack(alignment : .center){
                Rectangle()
                    .frame(width: 70, height: 100)
                    .foregroundColor(backgroundColor)
                    .opacity(0.9)
                    .cornerRadius(10)
                
                VStack(alignment : .center){
                    if classroom.classRoomName != nil{
                        ProfileImageHandler(classroom: classroom)
                    }
                    
                    Text(classroom.classRoomName ?? "")
                        .font(.caption2)
            }
            
            }
        }
    }
}


