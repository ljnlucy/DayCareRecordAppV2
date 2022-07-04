//
//  largeCardViewClassRoom.swift
//  DayCareRecordApp
//
//  Created by Jianan Li on 6/10/22.
//

import SwiftUI

struct largeCardViewClassRoom: View {
    @EnvironmentObject var daycare : DayCareClass
    //var student : Student
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
        NavigationLink {
            singleClassRoomDetailView()
                .onAppear {
                    daycare.selectedclassRoom = classroom
                }
        } label: {
            ZStack{
                Rectangle()
                    .cornerRadius(10)
                    .frame(maxWidth: .infinity, alignment: .center)
                    .foregroundColor(backgroundColor)
                    .opacity(0.5)
                
                HStack(alignment: .center, spacing : 10){
                    ProfileImageHandler(classroom : classroom, isLarge: true)
                        .padding(.vertical)
                    Divider()
                    
                    VStack(alignment : .leading){
                        Text(classroom.classRoomName ?? "")
                    }
                    .foregroundColor(.black)
                    .font(.caption)
                    
                }
            }
            
            
            
            
        }
    }
}

