//
//  SingleStudentDetailView.swift
//  DayCareRecordApp
//
//  Created by Jianan Li on 6/6/22.
//

import SwiftUI

struct SingleStudentDetailView: View {
    @EnvironmentObject var daycare : DayCareClass
    @State var selectedMonth : Int = 1
    @State var selectedClass : String = ""

    var body: some View {
        ScrollView(){
            VStack(alignment : .leading){
                HStack{
                    Spacer()
                    if daycare.selectedStudent.UID != nil && daycare.profileImageDict[daycare.selectedStudent.UID!] != nil {
                        Image(uiImage: UIImage(data: daycare.profileImageDict[daycare.selectedStudent.UID!]!)!)
                            .resizable()
                            .frame(width: 200, height: 200, alignment: .center)
                            .scaledToFill()
                            .cornerRadius(10)
                    }
                    else{
                        ProgressView()
                            .frame(width: 200, height: 200, alignment: .center)
                    }
                    Spacer()
                }
                
                VStack(alignment:.leading){
                    Divider()
                    Group{
                        Text("Profile").bold().foregroundColor(.gray)
                        Text("Name: " + (daycare.selectedStudent.studentName ?? ""))
                        Text("Nick Name: " + (daycare.selectedStudent.nickName ?? ""))
                        Text("Guardian: " + (daycare.selectedStudent.guardianName ?? ""))
                        Text("Phone: " + "\(daycare.selectedStudent.guardianPhone ?? "")")
                        Text("Email: " + (daycare.selectedStudent.guardianEmail ?? ""))
                        Text("Guardian2: " + (daycare.selectedStudent.guardian2Name ?? ""))
                        Text("Phone2: " + "\(daycare.selectedStudent.guardian2Phone ?? "")")
                        Text("Email2: " + (daycare.selectedStudent.guardian2Email ?? ""))
                    }
                    
                    Divider()
                }
                
                HStack{
                    VStack(alignment:.leading){
                        Text("Current Status").bold().foregroundColor(.gray)
                        Text(daycare.selectedStudent.isCheckedIn ? "IN" : "OUT" ).frame(width: 50).padding().background {
                            Rectangle()
                                .cornerRadius(10)
                                .foregroundColor(daycare.selectedStudent.isCheckedIn ? .green : .red)
                        }
                        Text("Since").bold().foregroundColor(.gray)
                        Text(daycare.selectedStudent.lastKnownTimestamp ?? Date(), style: .time)
                        
                    }
                    Divider()
                    VStack(alignment: .leading){
                        Text("Change Status: ").bold().foregroundColor(.gray)
                        Button {
                            daycare.studentCheckedIn()
                        } label: {
                            ZStack{
                                Rectangle()
                                    .cornerRadius(10)
                                    .foregroundColor(.green)
                                Text("Check In").padding(.vertical).foregroundColor(.black)
                            }
                        }
                        
                        Button {
                            daycare.studentCheckedOut()
                        } label: {
                            ZStack{
                                Rectangle()
                                    .cornerRadius(10)
                                    .foregroundColor(.red)
                                Text("Check Out").padding(.vertical).foregroundColor(.black)
                            }
                            
                        }
                    }
                }
                Divider()
                
                HStack{
                    // left: picker
                    Text("Choose month")
                    
                    Picker("Tap me", selection : $selectedMonth){
                        Group{
                            Text("Jan").tag(1).frame(width: 100)
                            Text("Feb").tag(2).frame(width: 100)
                            Text("Mar").tag(3).frame(width: 100)
                            Text("Apr").tag(4).frame(width: 100)
                            Text("May").tag(5).frame(width: 100)
                            Text("Jun").tag(6).frame(width: 100)
                        }
                        Group{
                            Text("Jul").tag(7).frame(width: 100)
                            Text("Aug").tag(8).frame(width: 100)
                            Text("Sep").tag(9).frame(width: 100)
                            Text("Oct").tag(10).frame(width: 100)
                            Text("Nov").tag(11).frame(width: 100)
                            Text("Dec").tag(12).frame(width: 100)
                        }
                    }
                    .pickerStyle(MenuPickerStyle())
                    
                    
                    
                    
                }
                NavigationLink {
                    TimeSheetViewStudent()
                        .onAppear {
                            daycare.selectedMonth = selectedMonth
                            daycare.fetchStudentTimeSheetGivenMonth()
                        }
                } label: {
                    HStack{
                        ZStack{
                            Rectangle()
                                .cornerRadius(10)
                                .frame(height: 50)
                                .foregroundColor(.orange)
                                .padding()
                            
                            Text("See Timesheet")
                                .foregroundColor(.black)
                                .frame(width: 100)
                        }
                    }
                    
                }
                
            }
            
            // add a picker to assign classroom
            if daycare.classRoomList.count != 0{
                
                HStack(spacing: 30){
                    Text("Assign to: ")
                    Picker("Choose Class", selection: $selectedClass) {
                        ForEach(daycare.classRoomList){ g in
                            Text(g.classRoomName!).tag(g.classRoomName!)
                        }
                    }
                    .pickerStyle(MenuPickerStyle())
                    Button {
                        // update teacher profile's field
                        daycare.assignClassStudent(group: selectedClass)
                    } label: {
                        ZStack{
                            Rectangle()
                                .cornerRadius(10)
                                .foregroundColor(.orange)
                                .frame(height: 40)
                                .padding()
                            
                            Text("Confirm")
                                .onAppear(perform: {
                                    self.selectedClass = daycare.classRoomList[0].classRoomName!
                                })
                                .foregroundColor(.black)
                        }
                        
                        
                            
                    }

                }
            }
            
        }
        .padding(.horizontal)
        .navigationTitle("Student Details")
        .toolbar {
            Button {
                daycare.deleteStudentProfile()
            } label: {
                HStack{
                    if daycare.currentSignedInUserRole == "teacher"{
                        Text("Delete").font(.caption2)
                        Image(systemName: "person.crop.circle.badge.xmark")
                    }
                    
                }
                
            }
        }
        
    }
}

struct SingleStudentDetailView_Previews: PreviewProvider {
    static var previews: some View {
        SingleStudentDetailView()
    }
}
