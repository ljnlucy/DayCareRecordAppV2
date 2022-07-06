//
//  TeacherListView.swift
//  DayCareRecordApp
//
//  Created by Jianan Li on 5/21/22.
//

import SwiftUI

struct TeacherListView: View {
    @EnvironmentObject var daycare : DayCareClass
    @Binding var showTeacherListView : Bool
    @State var isAddTeacherSheetShow : Bool = false
    @State var selectedLinkIndex : String?
    var body: some View {
        if daycare.teacherList.count == 0{
            ScrollView{
                Text("add teacher")
            }
            .padding()
            .navigationTitle("Teacher List")
            .toolbar {
                Button {
                    isAddTeacherSheetShow = true
                } label: {
                    HStack{
                        Text("Add Person").font(.caption2)
                        Image(systemName: "person.crop.circle.badge.plus")
                    }
                    
                }

            }
            .sheet(isPresented: $isAddTeacherSheetShow, onDismiss: nil) {
                addTeacherProfileSheet(isAddTeacherSheetShow: $isAddTeacherSheetShow)
            }
            
            
        }
        else{
            NavigationView{
                ScrollView{
                   
                    ForEach(daycare.teacherList){ teacher in
                        // add large Card view
                        largeCardView(teacher: teacher, selectedLinkIndex: $selectedLinkIndex)

                    }
                }
                .onAppear(perform: {
                    // it works when ipad is in portrait mode
                    if daycare.teacherList.count > 0 && daycare.teacherList[0].UID != nil {
                        selectedLinkIndex = daycare.teacherList[0].UID!
                    }
                    
                })
                .padding()
                .navigationTitle("Teacher List")
                .toolbar {
                    HStack{
                        
                        Button {
                            showTeacherListView = false
                        } label: {
                            HStack{
                                Text("Home Screen").font(.caption2)
                                Image(systemName: "chevron.left")
                            }
                        }
                        Button {
                            isAddTeacherSheetShow = true
                        } label: {
                            HStack{
                                Text("Add Person").font(.caption2)
                                Image(systemName: "person.crop.circle.badge.plus")
                            }
                        }
                        
                    }
                }
                .sheet(isPresented: $isAddTeacherSheetShow, onDismiss: nil) {
                    addTeacherProfileSheet(isAddTeacherSheetShow: $isAddTeacherSheetShow)
                }
                
            }
        }
        
        
    }
}


