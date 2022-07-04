//
//  ClassRommQuickView.swift
//  DayCareRecordApp
//
//  Created by Jianan Li on 6/10/22.
//

import SwiftUI

struct ClassRoomQuickView: View {
    @EnvironmentObject var daycare : DayCareClass
    @Binding var isClassRoomQuickViewShow : Bool
    var body: some View {
        /// profile image + check in + check out + current status
        ScrollView{
            VStack{
                
                HStack{
                    Text("Quick View")
                        .font(.headline)
                        .bold()
                    Spacer()
                    Button {
                        // cancel -> dismiss sheet
                        isClassRoomQuickViewShow = false
                    } label: {
                        HStack{
                            Text("Go Back").font(.caption2)
                            Image(systemName: "chevron.left.circle")
                        }
                        
                    }
                }
                
                Group{
                    if daycare.selectedclassRoom.classRoomName != nil && daycare.profileImageDict[daycare.selectedclassRoom.classRoomName!] != nil{

                        Image(uiImage: UIImage(data: daycare.profileImageDict[daycare.selectedclassRoom.classRoomName!]!)!)
                            .resizable()
                            .frame(width: 200, height: 200, alignment: .center)
                            .scaledToFill()
                            .cornerRadius(10)
                    }
                    else{
                        ProgressView()
                    }
                }
                Text("Students who belong to this class").font(.headline)
                if daycare.selectedclassRoom.classRoomName != nil && daycare.studentList.count != 0{
                    ForEach(daycare.studentList){ s in
                        if s.group == daycare.selectedclassRoom.classRoomName! {
                            HStack(spacing : 50){
                                Text(s.studentName ?? "unknown")
                                Text(s.isCheckedIn ? "IN" : "OUT")
                            }
                            
                        }
                    }
                }
                
                
            }
            .padding()
            
        }
    }
}


