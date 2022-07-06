//
//  SingleTeacherDetailView.swift
//  DayCareRecordApp
//
//  Created by Jianan Li on 5/21/22.
//

import SwiftUI


struct SingleTeacherDetailView: View {
    @EnvironmentObject var daycare : DayCareClass
    @State var selectedMonth : Int = 1
    @State var selectedClass : String = ""
    @State var selectedLinkIndex : Int?
    
    var body: some View {
        ScrollView(){
            VStack(alignment : .leading){
                HStack{
                    Spacer()
                    if daycare.selectedTeacher.UID != nil && daycare.profileImageDict[daycare.selectedTeacher.UID!] != nil{
                        Image(uiImage: UIImage(data: daycare.profileImageDict[daycare.selectedTeacher.UID!]!)!)
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
                    Text("Profile").bold().foregroundColor(.gray)
                    
                    NavigationLink(destination: updateProfileView(category : "teacher", field : "name", selectedLinkIndex: $selectedLinkIndex), tag: 0, selection: $selectedLinkIndex) {
                        HStack{
                            Text("Name: " + (daycare.selectedTeacher.name ?? ""))
                            Spacer()
                            Image(systemName: "chevron.right")
                        }
                        .accentColor(.black)
                    }
                    
                    
                    NavigationLink(tag: 1, selection: $selectedLinkIndex) {
                        updateProfileView(category : "teacher", field : "nickName", selectedLinkIndex: $selectedLinkIndex)
                    } label: {
                        HStack{
                            Text("Nick Name: " + (daycare.selectedTeacher.nickName ?? ""))
                            Spacer()
                            Image(systemName: "chevron.right")
                        }
                        .accentColor(.black)
                    }

                    
                    
                    
                    Divider()
                }
                
                HStack{
                    VStack(alignment:.leading){
                        Text("Current Status").bold().foregroundColor(.gray)
                        Text(daycare.selectedTeacher.isCheckedIn ? "IN" : "OUT" ).frame(width: 50).padding().background {
                            Rectangle()
                                .cornerRadius(10)
                                .foregroundColor(daycare.selectedTeacher.isCheckedIn ? .green : .red)
                        }
                        Text("Since").bold().foregroundColor(.gray)
                        Text(daycare.selectedTeacher.lastKnownTimestamp ?? Date(), style: .time)
                        
                    }
                    Divider()
                    VStack(alignment: .leading){
                        Text("Change Status: ").bold().foregroundColor(.gray)
                        Button {
                            daycare.teacherCheckedIn()
                        } label: {
                            ZStack{
                                Rectangle()
                                    .cornerRadius(10)
                                    .foregroundColor(.green)
                                Text("Check In").padding(.vertical).foregroundColor(.black)
                            }
                        }
                        
                        Button {
                            daycare.teacherCheckedOut()
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
                    TimeSheetView()
                        .onAppear {
                            daycare.selectedMonth = selectedMonth
                            daycare.fetchTeacherTimeSheetGivenMonth()
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
                                .frame(width: 200)
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
                            daycare.assignClassTeacher(group: selectedClass)
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
            
        }
        .padding(.horizontal)
        .navigationTitle("Teacher Details")
        .toolbar {
            Button {
                daycare.deleteTeacherProfile()
            } label: {
                HStack{
                    Text("Delete").font(.caption2)
                    Image(systemName: "person.crop.circle.badge.xmark")
                }
                
            }
        }
        
    }
}




