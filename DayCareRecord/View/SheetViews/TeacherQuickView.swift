//
//  TeacherQuickView.swift
//  DayCareRecordApp
//
//  Created by Jianan Li on 5/30/22.
//

import SwiftUI

struct TeacherQuickView: View {
    @EnvironmentObject var daycare : DayCareClass
    @Binding var isTeacherQuickViewShow : Bool
    var backgroundColor : Color{
        if daycare.selectedTeacher.isCheckedIn == true{
            return .green
        }
        else{
            return .red
        }
    }
    
    var body: some View {
        /// profile image + check in + check out + current status
        ScrollView{
            VStack{
                
                HStack{
                    Text("Quick Actions")
                        .font(.headline)
                        .bold()
                    Spacer()
                    Button {
                        // cancel -> dismiss sheet
                        isTeacherQuickViewShow = false
                    } label: {
                        HStack{
                            Text("Go Back").font(.caption2)
                            Image(systemName: "chevron.left.circle")
                        }
                        
                    }
                }
                
                Group{
                    if daycare.selectedTeacher.UID != nil && daycare.profileImageDict[daycare.selectedTeacher.UID!] != nil{
                            Image(uiImage: UIImage(data: daycare.profileImageDict[daycare.selectedTeacher.UID!]!)!)
                                .resizable()
                                .frame(width: 200, height: 200, alignment: .center)
                                .scaledToFill()
                                .cornerRadius(10)
                    }
                    else{
                        ProgressView()
                    }
                }
                HStack{
                    Text("Current Status").bold().foregroundColor(.gray)
                    Text(daycare.selectedTeacher.isCheckedIn ? "IN" : "OUT" )
                        .padding(.horizontal)
                        .background(content: {
                            Rectangle()
                                .cornerRadius(10)
                                .foregroundColor(backgroundColor)
                        })
                    
                    Text("Since \(daycare.selectedTeacher.lastKnownTimestamp ?? Date(), style: .time)")
                }
                HStack(spacing : 70){
                    Button {
                        // change status and update backend data
                        daycare.teacherCheckedIn()
                        // flip sheet flag
                        isTeacherQuickViewShow = false
                    } label: {
                        Text("Check In")
                            .padding()
                            .background {
                                Rectangle()
                                    .cornerRadius(10)
                                    .foregroundColor(.green)
                            }
                    }
                    Button {
                        // change status and update backend data
                        daycare.teacherCheckedOut()
                        // flip sheet flag
                        isTeacherQuickViewShow = false
                    } label: {
                        Text("Check Out")
                            .padding()
                            .background {
                                Rectangle()
                                    .cornerRadius(10)
                                    .foregroundColor(.red)
                            }
                    }
                }
                Spacer()
                
            }
            .padding()
            
        }
    }
    
        
}


