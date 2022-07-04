//
//  ProfileImageHandler.swift
//  DayCareRecordApp
//
//  Created by Jianan Li on 5/28/22.
//

import SwiftUI

struct ProfileImageHandler: View {
    @EnvironmentObject var daycare : DayCareClass
    var teacher : Teacher?
    var student : Student?
    var classroom : classRoom?
    var isLarge : Bool = false
    
    
    
    var body: some View {
        /// having student, teacher, classroom options -> to develop
        /// having large Image or small Image options -> to develop
        if teacher != nil{
            if daycare.profileImageDict.keys.contains(teacher!.UID!) == true {
                
                Image(uiImage: UIImage(data: daycare.profileImageDict[teacher!.UID!]!)!)
                    .resizable()
                    .frame(width: (isLarge ? 150 : 50), height: (isLarge ? 150 : 50), alignment: .center)
                    .scaledToFill()
                    .cornerRadius(10)
            }
            else{
                ProgressView()
                    .frame(width: (isLarge ? 150 : 50), height: (isLarge ? 150 : 50), alignment: .center)
                    .onAppear {
                        daycare.downloadTeacherProfileImageData(t: teacher!)
                    }
                    
            }
        }
        else if student != nil {
            if daycare.profileImageDict.keys.contains(student!.UID!) == true {
                
                Image(uiImage: UIImage(data: daycare.profileImageDict[student!.UID!]!)!)
                    .resizable()
                    .frame(width: (isLarge ? 150 : 50), height: (isLarge ? 150 : 50), alignment: .center)
                    .scaledToFill()
                    .cornerRadius(10)
            }
            else{
                ProgressView()
                    .frame(width: (isLarge ? 150 : 50), height: (isLarge ? 150 : 50), alignment: .center)
                    .onAppear {
                        daycare.downloadStudentProfileImageData(s: student!)
                    }
                    
            }
        }
        else if classroom != nil {
            if daycare.profileImageDict.keys.contains(classroom!.classRoomName!) == true {
                
                Image(uiImage: UIImage(data: daycare.profileImageDict[classroom!.classRoomName!]!)!)
                    .resizable()
                    .frame(width: (isLarge ? 150 : 50), height: (isLarge ? 150 : 50), alignment: .center)
                    .scaledToFill()
                    .cornerRadius(10)
            }
            else{
                ProgressView()
                    .frame(width: (isLarge ? 150 : 50), height: (isLarge ? 150 : 50), alignment: .center)
                    .onAppear {
                        daycare.downloadClassRoomProfileImageData(s: classroom!)
                    }
                    
            }
        }
        
            
    
        
       
    }
}


