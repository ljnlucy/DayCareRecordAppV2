//
//  singleStudentDetailView.swift
//  DayCareRecord
//
//  Created by Jianan Li on 7/9/22.
//

import SwiftUI

struct singleStudentDetailView: View {
    @EnvironmentObject var daycare : DayCareClass
    @State var selectedMonth : Int = 0
    @State var selectedClass : String = "No Class"
    @State var showTimesheet : Bool = false
    @State var showUpdateSheet : Bool = false
    @State var role : String = ""
    @State var field : String = ""
    
    
    var dateFormatter1 : DateFormatter = DateFormatter()
    var dateFormatter2 : DateFormatter = DateFormatter()
    @State var totalHours : Double = 0.0
    var month : String{
        switch daycare.selectedMonth {
        case 1:
            return "January"
        case 2:
            return "Febuary"
        case 3:
            return "March"
        case 4:
            return "April"
        case 5:
            return "May"
        case 6:
            return "June"
        case 7:
            return "July"
        case 8:
            return "Augest"
        case 9:
            return "September"
        case 10:
            return "October"
        case 11:
            return "November"
        case 12:
            return "December"
            
        default:
            return "Unknown"
        }
    }
    
    init() {
        //dateFormatter = DateFormatter()
        dateFormatter1.dateStyle = .none
        dateFormatter1.timeStyle = .short
        
        dateFormatter2.dateStyle = .short
        dateFormatter2.timeStyle = .none
        
    }
    
    var body: some View {
        if daycare.selectedStudent.UID != nil{
            let student = daycare.selectedStudent
            
            if showTimesheet == false{
                ScrollView{
                    VStack(alignment : .leading){
                        // group 1 static information
                        Group{
                            HStack{
                                Text("Name: " + (student.studentName ?? "no name"))
                                Spacer()
                                Button {
                                    // to show a sheet
                                    self.role = "student"
                                    self.field = "Name"
                                    showUpdateSheet = true
                                } label: {
                                    ZStack{
                                        Capsule()
                                            .frame(width: 110, height: 30)
                                            .foregroundColor(.orange)
                                        Text("Update")
                                            .foregroundColor(.black)
                                    }
                                }

                            }
                            
                            HStack{
                                Text("Nick Name: " + (student.nickName ?? "no name"))
                                Spacer()
                                Button {
                                    // to show a sheet
                                    self.role = "student"
                                    self.field = "Nick Name"
                                    showUpdateSheet = true
                                } label: {
                                    ZStack{
                                        Capsule()
                                            .frame(width: 110, height: 30)
                                            .foregroundColor(.orange)
                                        Text("Update")
                                            .foregroundColor(.black)
                                    }
                                }

                            }
                            
                            
                            
                            Text("ID: " + (student.UID ?? "no UID"))
                            // add other profile information
                            Group{
                                HStack{
                                    Text("Guardian1: " + (daycare.selectedStudent.guardianName ?? ""))
                                    Spacer()
                                    Button {
                                        // to show a sheet
                                        self.role = "student"
                                        self.field = "Guardian1"
                                        showUpdateSheet = true
                                    } label: {
                                        ZStack{
                                            Capsule()
                                                .frame(width: 110, height: 30)
                                                .foregroundColor(.orange)
                                            Text("Update")
                                                .foregroundColor(.black)
                                        }
                                    }

                                }
                                HStack{
                                    Text("Phone: " + "\(daycare.selectedStudent.guardianPhone ?? "")")
                                    Spacer()
                                    //Link("Call", destination: URL(string: "tel:\(business.phone!)")!)
                                    
                                    
                                    Link(destination: URL(string: "tel:\(daycare.selectedStudent.guardianPhone ?? "")")!) {
                                            ZStack{
                                                Capsule()
                                                    .frame(width: 30, height: 30)
                                                    .foregroundColor(.green).padding()
                                                Image(systemName: "phone.arrow.up.right")
                                                    .foregroundColor(.black)
                                                    .padding(.horizontal)
                                            }
                                        }
                                    
                                    
                                    
                                    Button {
                                        // to show a sheet
                                        self.role = "student"
                                        self.field = "GuardianPhone"
                                        showUpdateSheet = true
                                    } label: {
                                        ZStack{
                                            Capsule()
                                                .frame(width: 110, height: 30)
                                                .foregroundColor(.orange)
                                            Text("Update")
                                                .foregroundColor(.black)
                                        }
                                    }

                                }
                                HStack{
                                    Text("Email: " + (daycare.selectedStudent.guardianEmail ?? ""))
                                    Spacer()
                                    
                                    Link(destination: URL(string: "mailto:\(daycare.selectedStudent.guardianEmail ?? "")")!) {
                                            ZStack{
                                                Capsule()
                                                    .frame(width: 30, height: 30)
                                                    .foregroundColor(.blue)
                                                    .padding()
                                                Image(systemName: "envelope")
                                                    .foregroundColor(.black)
                                                    .padding(.horizontal)
                                            }
                                        }

                                    Button {
                                        // to show a sheet
                                        self.role = "student"
                                        self.field = "GuardianEmail"
                                        showUpdateSheet = true
                                    } label: {
                                        ZStack{
                                            Capsule()
                                                .frame(width: 110, height: 30)
                                                .foregroundColor(.orange)
                                            Text("Update")
                                                .foregroundColor(.black)
                                        }
                                    }

                                }
                                HStack{
                                    Text("Guardian2: " + (daycare.selectedStudent.guardian2Name ?? ""))
                                    Spacer()
                                    Button {
                                        // to show a sheet
                                        self.role = "student"
                                        self.field = "Guardian2"
                                        showUpdateSheet = true
                                    } label: {
                                        ZStack{
                                            Capsule()
                                                .frame(width: 110, height: 30)
                                                .foregroundColor(.orange)
                                            Text("Update")
                                                .foregroundColor(.black)
                                        }
                                    }

                                }
                                HStack{
                                    Text("Phone: " + "\(daycare.selectedStudent.guardian2Phone ?? "")")
                                    Spacer()
                                    
                                    Link(destination: URL(string: "tel:\(daycare.selectedStudent.guardian2Phone ?? "")")!) {
                                            ZStack{
                                                Capsule()
                                                    .frame(width: 30, height: 30)
                                                    .foregroundColor(.green).padding()
                                                Image(systemName: "phone.arrow.up.right")
                                                    .foregroundColor(.black)
                                                    .padding(.horizontal)
                                            }
                                        }
                                    Button {
                                        // to show a sheet
                                        self.role = "student"
                                        self.field = "Guardian2Phone"
                                        showUpdateSheet = true
                                    } label: {
                                        ZStack{
                                            Capsule()
                                                .frame(width: 110, height: 30)
                                                .foregroundColor(.orange)
                                            Text("Update")
                                                .foregroundColor(.black)
                                        }
                                    }

                                }
                                HStack{
                                    Text("Email: " + (daycare.selectedStudent.guardian2Email ?? ""))
                                    Spacer()
                                    Link(destination: URL(string: "mailto:\(daycare.selectedStudent.guardian2Email ?? "")")!) {
                                            ZStack{
                                                Capsule()
                                                    .frame(width: 30, height: 30)
                                                    .foregroundColor(.blue)
                                                Image(systemName: "envelope").padding()
                                                    .foregroundColor(.black)
                                                    .padding(.horizontal)
                                            }
                                        }

                                    Button {
                                        // to show a sheet
                                        self.role = "student"
                                        self.field = "Guardian2Email"
                                        showUpdateSheet = true
                                    } label: {
                                        ZStack{
                                            Capsule()
                                                .frame(width: 110, height: 30)
                                                .foregroundColor(.orange)
                                            Text("Update")
                                                .foregroundColor(.black)
                                        }
                                    }

                                }
                                
                                
                                
                                
                            }
                            
                            
                            Text("Group Assigned: " + (student.group ?? "no group"))
                            HStack{
                                Text("Status: ")
                                Circle()
                                    .foregroundColor(student.isCheckedIn ? .green : .red)
                                    .frame(width: 20, height: 20)
                                Text(student.isCheckedIn ? "IN" : "OUT")
                                Text(" since:")
                                Text(daycare.selectedStudent.lastKnownTimestamp ?? Date(), style: .time)
                                Spacer()
                            }
                        }
                        
                        // group 2 check in or check out
                        HStack{
                            Button {
                                daycare.studentCheckedIn()
                            } label: {
                                ZStack{
                                    Capsule()
                                        .frame(width: 130, height: 50)
                                        .foregroundColor(.green)
                                    
                                    HStack{
                                        Image(systemName: "square.and.arrow.down")
                                        Text("Check In")
                                    }
                                    .foregroundColor(.black)
                                    
                                }
                            }
                            
                            
                            Button {
                                daycare.studentCheckedOut()
                            } label: {
                                ZStack{
                                    Capsule()
                                        .frame(width: 130, height: 50)
                                        .foregroundColor(.red)
                                    
                                    HStack{
                                        Image(systemName: "square.and.arrow.up")
                                        Text("Check Out")
                                    }
                                    .foregroundColor(.black)
                                    
                                }
                            }
                            Spacer()
                        }
                        
                        // group 3: select month and see timesheet
                        Group{
                            HStack{
                            // left: picker
                            Text("Choose month")
                            
                            Picker("Tap me", selection : $selectedMonth){
                                Text("No Selection").tag(0).frame(width: 100)
                                Group{
                                    Text("January").tag(1).frame(width: 100)
                                    Text("Febuary").tag(2).frame(width: 100)
                                    Text("March").tag(3).frame(width: 100)
                                    Text("April").tag(4).frame(width: 100)
                                    Text("May").tag(5).frame(width: 100)
                                    Text("June").tag(6).frame(width: 100)
                                }
                                Group{
                                    Text("July").tag(7).frame(width: 100)
                                    Text("Augest").tag(8).frame(width: 100)
                                    Text("September").tag(9).frame(width: 100)
                                    Text("October").tag(10).frame(width: 100)
                                    Text("November").tag(11).frame(width: 100)
                                    Text("December").tag(12).frame(width: 100)
                                }
                            }
                            .pickerStyle(MenuPickerStyle())
                        }
                            
                            Button {
                            if selectedMonth != 0{
                                daycare.selectedMonth = selectedMonth
                                daycare.fetchStudentTimeSheetGivenMonth()
                                showTimesheet = true
                            }
                            
                        } label: {
                            ZStack{
                                Capsule()
                                    .frame(width: 300, height: 50)
                                    .foregroundColor(.orange)
                                
                                HStack{
                                    Image(systemName: "rectangle.split.3x3")
                                    Text("Show Selected Month Timesheet")
                                }
                                .foregroundColor(.black)
                                
                            }
                        }
                            
                        }
                        
                        // group 4: assign classroom
                        Group{
                            if (daycare.classRoomList.count != 0) {
                                HStack{
                                    Text("Assign to: ")
                                    Picker("Choose Class", selection: $selectedClass) {
                                        Text("No Class").tag("No Class")
                                        ForEach(daycare.classRoomList){ g in
                                            Text(g.classRoomName!).tag(g.classRoomName!)
                                        }
                                    }
                                    .pickerStyle(MenuPickerStyle())
                                }
                                
                                Button {
                                    // assign class, update backend data
                                    daycare.assignClassStudent(group: selectedClass)
                                } label: {
                                    ZStack{
                                        Capsule()
                                            .frame(width: 300, height: 50)
                                            .foregroundColor(.orange)
                                        HStack{
                                            Image(systemName: "icloud.and.arrow.up")
                                            Text("Assign to selected class")
                                        }
                                        .foregroundColor(.black)
                                    }
                                }

                            }
                        }
                        
                    }
                    .navigationTitle(student.studentName ?? "No name")
                    .navigationBarTitleDisplayMode(.inline)
                }
                .sheet(isPresented: $showUpdateSheet) {
                    UpdateProfileSheet(showUpdateSheet: $showUpdateSheet, role: $role, field: $field)
                }
            }
            else{
                // show time sheet
                if daycare.timeSheets.count == 0{
                    ProgressView("Downloading Data...")
                }
                else{
                    
                    ScrollView{
                        VStack{
                            HStack(spacing: 10){
                                VStack(alignment: .leading, spacing: 0){
                                    Text("Date").font(.headline)
                                    Divider()
                                    ForEach(daycare.timeSheets){ i in
                                        Text("\(i.In ?? Date(), formatter: dateFormatter2)").font(.caption2)
                                    }
                                }
                                Divider()
                                VStack(alignment: .leading, spacing: 0){
                                    Text("In").font(.headline)
                                    Divider()
                                    ForEach(daycare.timeSheets){ i in
                                        Text("\(i.In ?? Date(), formatter: dateFormatter1)").font(.caption2)
                                    }
                                }
                                Divider()
                                VStack(alignment: .leading, spacing: 0){
                                    Text("Out").font(.headline)
                                    Divider()
                                    ForEach(daycare.timeSheets){ i in
                                        if i.Out != nil && i.In != nil{
                                            Text("\(i.Out ?? Date(), formatter: dateFormatter1)").font(.caption2)
                                        }
                                        else{
                                            Text("N/A").font(.caption2)
                                        }
                                    }
                                }
                                Divider()
                                VStack(alignment: .leading, spacing: 0){
                                    Text("Hours").font(.headline)
                                    Divider()
                                    ForEach(daycare.timeSheets){ i in
                                        if i.Out != nil && i.In != nil{
                                            Text("\((i.In!).distance(to: i.Out!)/3600, specifier: "%.1f")").font(.caption2)
                                                .onAppear {
                                                    totalHours = totalHours + (i.In!).distance(to: i.Out!)
                                                }
                                            
                                        }
                                        else{
                                            Text("N/A").font(.caption2)
                                        }
                                    }
                                }
                            }
                            
                            Divider()
                            HStack{
                                Spacer()
                                Text("Total Hours: \(totalHours / 3600, specifier: "%.1f")").font(.headline)
                            }
                        }
                        .padding(.horizontal)
                        .navigationTitle((daycare.selectedTeacher.name ?? "") + "'s Timesheet")
                        .toolbar {
                            Button {
                                // flag flig
                                showTimesheet = false
                                totalHours = 0.0
                            } label: {
                                HStack{
                                    Text("Go back")
                                }
                            }

                        }
                        
                    }
                }
            }
            
        }
        else{
            Text("No student")
            
        }
    }
}


