//
//  addClassRoomProfileSheet.swift
//  DayCareRecordApp
//
//  Created by Jianan Li on 6/10/22.
//

import SwiftUI

struct addClassRoomProfileSheet: View {
    @EnvironmentObject var daycare : DayCareClass
    @Binding var isAddClassRoomSheetShow : Bool
    
    // Store teacher profile
    @State var classRoomName : String = ""
    @State var classRoomDescription : String = ""
    
    // choose image from library
    @State var isPickerShowing : Bool = false
    @State var selectedImage : UIImage?
    
    var body: some View {
        ScrollView{
            VStack{
                HStack{
                    Button {
                        // cancel action
                        isAddClassRoomSheetShow = false
                    } label: {
                        Text("Cancel").padding(.horizontal)
                    }
                    
                    Spacer()
                    
                    Button {
                        // Add action
                        // check textfield is not empty
                        if classRoomName != "" && classRoomDescription != "" && selectedImage != nil{
                            daycare.createclassRoomProfile(classRoomName: classRoomName, classRoomDescription: classRoomDescription, originalImage: selectedImage!)
                            isAddClassRoomSheetShow = false
                            
                        }
                    } label: {
                        Text("Add").padding(.horizontal)
                    }
                }.padding(.top)
                
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
                        
                    
                    TextField("Class Name", text: $classRoomName)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    TextField("Description", text: $classRoomDescription)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    
                }
            }
            .sheet(isPresented: $isPickerShowing, onDismiss: nil) {
                ImagePicker(selectedImage: $selectedImage, isPickerShowing: $isPickerShowing)
            }
        }
        

    }
}


