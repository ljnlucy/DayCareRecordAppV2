//
//  StudentQuickView.swift
//  DayCareRecordApp
//
//  Created by Jianan Li on 6/6/22.
//

import SwiftUI

struct StudentQuickView: View {
    @EnvironmentObject var daycare : DayCareClass
    @Binding var isStudentQuickViewShow : Bool
    
    var backgroundColor : Color{
        if daycare.selectedStudent.isCheckedIn == true{
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
                        isStudentQuickViewShow = false
                    } label: {
                        HStack{
                            Text("Go Back").font(.caption2)
                            Image(systemName: "chevron.left.circle")
                        }
                        
                    }
                }
                
                if daycare.selectedStudent.UID != nil && daycare.profileImageDict[daycare.selectedStudent.UID!] != nil{

                    Image(uiImage: UIImage(data: daycare.profileImageDict[daycare.selectedStudent.UID!]!)!)
                        .resizable()
                        .frame(width: 200, height: 200, alignment: .center)
                        .scaledToFill()
                        .cornerRadius(10)
                }
                else{
                    ProgressView()
                }
                HStack{
                    Text("Current Status").bold().foregroundColor(.gray)
                    Text(daycare.selectedStudent.isCheckedIn ? "IN" : "OUT" )
                        .padding(.horizontal)
                        .background(content: {
                            Rectangle()
                                .cornerRadius(10)
                                .foregroundColor(backgroundColor)
                        })
                    
                    Text("Since \(daycare.selectedStudent.lastKnownTimestamp ?? Date(), style: .time)")
                }
                HStack(spacing : 70){
                    Button {
                        // change status and update backend data
                        daycare.studentCheckedIn()
                        // flip sheet flag
                        isStudentQuickViewShow = false
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
                        daycare.studentCheckedOut()
                        // flip sheet flag
                        isStudentQuickViewShow = false
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

