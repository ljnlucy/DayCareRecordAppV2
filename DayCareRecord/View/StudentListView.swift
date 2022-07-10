//
//  StudentListView.swift
//  DayCareRecord
//
//  Created by Jianan Li on 7/9/22.
//

import SwiftUI

struct StudentListView: View {
    @EnvironmentObject var daycare : DayCareClass
    
    var body: some View {
        if daycare.studentList.count < 2 {
            Text("No student available")
        }
        else{
            NavigationView {
                List {
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
                    }
                    
                    
                }
                .navigationTitle("Student List")
                .toolbar {
                    Button {
                        // show a view to add teacher
                    } label: {
                        Image(systemName: "person.crop.circle.badge.plus")
                    }
                    
                }
                navigationLandingView()
            }
        }
    }
}


