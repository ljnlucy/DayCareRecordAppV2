//
//  StudentListView.swift
//  DayCareRecordApp
//
//  Created by Jianan Li on 6/6/22.
//

import SwiftUI

struct StudentListView: View {
    @EnvironmentObject var daycare : DayCareClass
    @State var isAddStudentSheetShow : Bool = false
    var body: some View {

        if daycare.studentList.count == 0{
            ScrollView{
                Text("add student")
            }
            .padding()
            .navigationTitle("Student List")
            .toolbar {
                Button {
                    isAddStudentSheetShow = true
                } label: {
                    HStack{
                        if daycare.currentSignedInUserRole == "teacher"{
                            Text("Add Person").font(.caption2)
                            Image(systemName: "person.crop.circle.badge.plus")
                        }
                        
                    }
                    
                }

            }
            .sheet(isPresented: $isAddStudentSheetShow, onDismiss: nil) {
                addStudentProfileSheet(isAddStudentSheetShow: $isAddStudentSheetShow)
            }
            
        }
        else{
            ScrollView{
                VStack{
                    ForEach(daycare.studentList){ student in
                        // add large Card view
                        largeCardViewStudent(student: student)
                    }
                }
                .padding()
                .navigationTitle("Student List")
                .toolbar {
                    Button {
                        isAddStudentSheetShow = true
                    } label: {
                        HStack{
                            if daycare.currentSignedInUserRole == "teacher"{
                                Text("Add Person").font(.caption2)
                                Image(systemName: "person.crop.circle.badge.plus")
                            }
                            
                        }
                        
                    }

                }
                .sheet(isPresented: $isAddStudentSheetShow, onDismiss: nil) {
                    addStudentProfileSheet(isAddStudentSheetShow: $isAddStudentSheetShow)
                }
                
            }
        }
        
        
        
    }
}


