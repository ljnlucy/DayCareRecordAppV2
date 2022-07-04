//
//  addStudentProfileSheet.swift
//  DayCareRecordApp
//
//  Created by Jianan Li on 6/6/22.
//

import SwiftUI

struct addStudentProfileSheet: View {
    @EnvironmentObject var daycare : DayCareClass
    @Binding var isAddStudentSheetShow : Bool
    
    // Store teacher profile
    @State var name : String = ""
    @State var email : String = ""
    @State var email2 : String = ""
    @State var UID : String = ""
    @State var phoneNumber : String = ""
    @State var phoneNumber2 : String = ""
    @State var guardianName : String = ""
    @State var guardianName2 : String = ""
    @State var group : String = ""
    @State var nickName : String = ""
    
    // choose image from library
    @State var isPickerShowing : Bool = false
    @State var selectedImage : UIImage?
    
    var body: some View {

        ScrollView{
            HStack{
                Button {
                    // cancel action
                    isAddStudentSheetShow = false
                } label: {
                    Text("Cancel")
                }
                
                Spacer()
                
                Button {
                    // Add action
                    // check textfield is not empty
                    if name != "" && UID != "" && selectedImage != nil{
                        daycare.createStudentProfile(studentName: name, UID: UID, nickName: nickName, guardianName: guardianName, guardianEmail: email, guardianPhone: phoneNumber, guardian2Name: guardianName2, guardian2Email: email2, guardian2Phone: phoneNumber2, group: group, originalImage: selectedImage!)
                        isAddStudentSheetShow = false
                    }
                } label: {
                    Text("Add")
                }
            }
            .padding(.top)
            
            Section {
                
                Image(uiImage: selectedImage ?? UIImage())
                    .resizable()
                    .frame(width: 200, height: 200)
                    .onTapGesture {
                        isPickerShowing = true
                    }
                    .overlay {
                        if selectedImage == nil{
                            Text("Choose image")
                        }
                    }
                    
                
                TextField("Student Name", text: $name)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                
                TextField("UID", text: $UID)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                TextField("Guardian1 Name", text: $guardianName)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                TextField("Guardian1 Email", text: $email)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                TextField("Guardian1 Phone", text: $phoneNumber)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                TextField("Guardian2 Name", text: $guardianName2)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                TextField("Guardian2 Email", text: $email2)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                TextField("Guardian2 Phone", text: $phoneNumber2)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
            }
        }
        .sheet(isPresented: $isPickerShowing, onDismiss: nil) {
            ImagePicker(selectedImage: $selectedImage, isPickerShowing: $isPickerShowing)
        }

    }
}

