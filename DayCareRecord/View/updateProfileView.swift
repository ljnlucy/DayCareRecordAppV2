//
//  updateProfileView.swift
//  DayCareRecord
//
//  Created by Jianan Li on 7/4/22.
//

import SwiftUI

struct updateProfileView: View {
    @EnvironmentObject var daycare : DayCareClass
    @State var newValue : String = ""
    @State var category: String = ""
    @State var field : String = ""
    @Binding var selectedLinkIndex : Int?
    var body: some View {
        VStack(alignment:.leading){
            TextField("Enter new value here", text: $newValue).font(.largeTitle)
            Button {
                // call function to merge new data
                if category == "teacher"{
                    switch field {
                    case "name":
                        if newValue != ""{
                            daycare.updateTeacherProfileName(name: newValue)
                        }
                    case "nickName":
                        if newValue != ""{
                            daycare.updateTeacherProfileNickName(nickName: newValue)
                        }
                    default:
                        return
                    }
                }
                else if category == "student"{
                    switch field {
                    case "name":
                        if newValue != "" {
                            daycare.updateStudentProfileName(newValue: newValue)
                        }
                    case "nickName":
                        if newValue != "" {
                            daycare.updateStudentProfileNickName(newValue: newValue)
                        }
                    case "Guardian":
                        if newValue != "" {
                            daycare.updateStudentProfileGuardianName(newValue: newValue)
                        }
                        
                    case "Phone":
                        if newValue != "" {
                            daycare.updateStudentProfileGuardianPhone(newValue: newValue)
                        }
                        
                    case "Email":
                        if newValue != "" {
                            daycare.updateStudentProfileGuardianEmail(newValue: newValue)
                        }
                        
                    case "Guardian2":
                        if newValue != "" {
                            daycare.updateStudentProfileGuardian2Name(newValue: newValue)
                        }
                        
                    case "Phone2":
                        if newValue != "" {
                            daycare.updateStudentProfileGuardian2Phone(newValue: newValue)
                        }
                        
                    case "Email2":
                        if newValue != "" {
                            daycare.updateStudentProfileGuardian2Email(newValue: newValue)
                        }
                    default:
                        return
                    }
                }
                
                selectedLinkIndex = nil
            } label: {
                Text("Confirm").font(.largeTitle)
            }

        }
    }
}


