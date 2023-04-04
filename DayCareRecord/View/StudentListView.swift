//
//  StudentListView.swift
//  DayCareRecord
//
//  Created by Jianan Li on 7/9/22.
//

import SwiftUI

struct StudentListView: View {
    @EnvironmentObject var daycare : DayCareClass
    @State var isAddStudentSheetShow : Bool = false
    @State var checkedInStudent : Int = 0
    var body: some View {
        if daycare.studentList.count < 2 {
            Text("No student available")
        }
        else{
            NavigationView {
                
                
                List {
                    VStack(alignment : .trailing){
                        Text("Total Student: \(daycare.studentList.count)")
                            .bold()
                        Text("Checked In Student: \(daycare.checkedInStudentNumber)")
                    }
                    ForEach(daycare.studentList){ student in
                        NavigationLink {
                            // single teacher detail view
                            singleStudentDetailView()
                                .onAppear {
                                    daycare.selectedStudent = student
                                }
                        } label: {
                            HStack{
                                
                                Circle()
                                    .foregroundColor(student.isCheckedIn ? .green : .red)
                                    .frame(width: 20, height: 20)
                                Text(student.studentName ?? "No name")
                                Spacer()
                            }
                        }
                        .swipeActions(edge: .trailing, allowsFullSwipe: false) {
                            Button {
                                daycare.deleteStudentProfile_swipeMethod(student: student)
                            } label: {
                                Image(systemName: "trash")
                            }
                            .tint(.red)

                        }
                    }
                    
                    
                }
                .navigationTitle("Student List")
                .toolbar {
                    HStack{
                    
                    Button {
                        // show a view to add teacher
                        isAddStudentSheetShow = true
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
                .sheet(isPresented: $isAddStudentSheetShow) {
                    addStudentProfileSheet(isAddStudentSheetShow : $isAddStudentSheetShow)
                }
                navigationLandingView()
            }
        }
    }
}


