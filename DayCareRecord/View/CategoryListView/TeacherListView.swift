//
//  TeacherListView.swift
//  DayCareRecordApp
//
//  Created by Jianan Li on 5/21/22.
//

import SwiftUI

struct TeacherListView: View {
    @EnvironmentObject var daycare : DayCareClass
    @State var isAddTeacherSheetShow : Bool = false
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
            ScrollView{
                VStack{
                    ForEach(daycare.teacherList){ teacher in
                        // add large Card view
                        largeCardView(teacher: teacher)

                    }
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
        }
        
        
    }
}

struct TeacherListView_Previews: PreviewProvider {
    static var previews: some View {
        TeacherListView()
    }
}
