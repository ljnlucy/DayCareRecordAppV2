//
//  TeacherListView.swift
//  DayCareRecord
//
//  Created by Jianan Li on 7/8/22.
//

import SwiftUI

struct TeacherListView: View {
    @EnvironmentObject var daycare : DayCareClass
    @State var isAddTeacherSheetShow : Bool = false
    var body: some View {
        if daycare.teacherList.count < 2 {
            Text("No teacher available")
        }
        else{
            NavigationView {
                List {
                    
                        ForEach(daycare.teacherList){ teacher in
                            NavigationLink {
                                // single teacher detail view
                                singleTeacherDetailView(/*teacher: teacher*/)
                                .onAppear {
                                        daycare.selectedTeacher = teacher
                                }
                            } label: {
                                HStack{
                                    
                                    Circle()
                                        .foregroundColor(teacher.isCheckedIn ? .green : .red)
                                        .frame(width: 20, height: 20)
                                    Text(teacher.name ?? "No name")
                                    Spacer()
                                    //Image(systemName: "chevron.right")
                                }
                            }
                        }
                    
                    
                }
                .navigationTitle("Teacher List")
                .toolbar {
                    HStack{
                        
                    
                    Button {
                        // show a view to add teacher
                        isAddTeacherSheetShow = true
                    } label: {
                        Image(systemName: "person.crop.circle.badge.plus")
                    }
                    Button {
                                        daycare.signOut()
                                    } label: {
                                        HStack{
                                            //Text("Sign Out").font(.caption2)
                                            Image(systemName: "square.and.arrow.up")
                                        }
                                        
                                    }
                    }

                }
                .sheet(isPresented: $isAddTeacherSheetShow) {
                    
                } content: {
                    addTeacherProfileSheet(isAddTeacherSheetShow : $isAddTeacherSheetShow)
                }

                navigationLandingView()
            }
        }
    }
}

struct TeacherListView_Previews: PreviewProvider {
    static var previews: some View {
        TeacherListView()
    }
}
