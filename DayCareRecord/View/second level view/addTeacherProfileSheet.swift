//
//  addTeacherProfileSheet.swift
//  DayCareRecord
//
//  Created by Jianan Li on 7/10/22.
//

import SwiftUI

struct addTeacherProfileSheet: View {
    @EnvironmentObject var daycare : DayCareClass
    @Binding var isAddTeacherSheetShow : Bool
    
    // Store teacher profile
    @State var name : String = ""
    @State var nickName : String = ""
    @State var UID : String = ""
    
    // choose image from library
    @State var isPickerShowing : Bool = false
    @State var selectedImage : UIImage?
    var body: some View {
        ScrollView{
            HStack{
                Button {
                    // cancel action
                    isAddTeacherSheetShow = false
                } label: {
                    Text("Cancel")
                }
                
                Spacer()
                
                Button {
                    // Add action
                    // check textfield is not empty
                    if name != "" && UID != "" && selectedImage != nil{
                        // use firestore to upload to collection--> create a function to upload teacher profile
                        daycare.createTeacherProfile(name: name, UID: UID, nickName: nickName, originalImage: selectedImage!)
                        isAddTeacherSheetShow = false
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
                
                
                TextField("Name", text: $name)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                TextField("Nick Name", text: $nickName)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                TextField("UID", text: $UID)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
            }
        }
        .sheet(isPresented: $isPickerShowing, onDismiss: nil) {
            ImagePicker(selectedImage: $selectedImage, isPickerShowing: $isPickerShowing)
        }
    }
}

