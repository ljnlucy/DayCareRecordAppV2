//
//  UpdateProfileSheet.swift
//  DayCareRecord
//
//  Created by Jianan Li on 7/10/22.
//

import SwiftUI

struct UpdateProfileSheet: View {
    @EnvironmentObject var daycare : DayCareClass
    @Binding var showUpdateSheet : Bool
    @Binding var role : String
    @Binding var field : String
    
    @State var newValue : String = ""
    
    var body: some View {
        ScrollView{
            VStack(alignment : .center){
                TextField("enter here", text: $newValue)
                    .frame(width: 200)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                Button {
                    if role == "teacher"{
                        switch field {
                        case "Name":
                            if newValue != ""{
                                daycare.updateTeacherProfileName(newValue: newValue)
                            }
                            showUpdateSheet = false
                            
                        case "Nick Name":
                            if newValue != ""{
                                daycare.updateTeacherProfileNickName(newValue: newValue)
                            }
                            showUpdateSheet = false
                        default:
                            showUpdateSheet = false
                        }
                    }
                    else if role == "student"{
                        switch field {
                        case "Name":
                            if newValue != ""{
                                daycare.updateStudentProfileName(newValue: newValue)
                            }
                            showUpdateSheet = false
                            
                        case "Nick Name":
                            if newValue != ""{
                                daycare.updateStudentProfileNickName(newValue: newValue)
                            }
                            showUpdateSheet = false
                            
                        case "Guardian1":
                            if newValue != ""{
                                daycare.updateStudentProfileGuardianName(newValue: newValue)
                            }
                            showUpdateSheet = false
                            
                        case "GuardianPhone":
                            if newValue != ""{
                                daycare.updateStudentProfileGuardianPhone(newValue: newValue)
                            }
                            showUpdateSheet = false
                            
                        case "GuardianEmail":
                            if newValue != ""{
                                daycare.updateStudentProfileGuardianEmail(newValue: newValue)
                            }
                            showUpdateSheet = false
                        case "Guardian2":
                            if newValue != ""{
                                daycare.updateStudentProfileGuardian2Name(newValue: newValue)
                            }
                            showUpdateSheet = false
                            
                        case "Guardian2Phone":
                            if newValue != ""{
                                daycare.updateStudentProfileGuardian2Phone(newValue: newValue)
                            }
                            showUpdateSheet = false
                            
                        case "Guardian2Email":
                            if newValue != ""{
                                daycare.updateStudentProfileGuardian2Email(newValue: newValue)
                            }
                            showUpdateSheet = false
                        default:
                            showUpdateSheet = false
                        }
                    }
                    else{
                        showUpdateSheet = false
                    }
                } label: {
                    Text("Update")
                }
            }
            .padding()
        }
        .onAppear {
            print(role)
            print(field)
        }
    }
}


