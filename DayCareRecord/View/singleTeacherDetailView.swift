//
//  singleTeacherDetailView.swift
//  DayCareRecord
//
//  Created by Jianan Li on 7/8/22.
//

import SwiftUI

struct singleTeacherDetailView: View {
    @EnvironmentObject var daycare : DayCareClass
    @State var selectedMonth : Int = 0
    @State var selectedClass : String = "No Class"
    @State var showTimesheet : Bool = false
    @State var showUpdateSheet : Bool = false
    @State var role : String = ""
    @State var field : String = ""
    //@State var isPickerShowing : Bool = false
    //@State var selectedImage : UIImage?
    
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
    //
    var body: some View {
        if daycare.selectedTeacher.UID != nil{
            let teacher = daycare.selectedTeacher
            
            if showTimesheet == false{
                ScrollView{
                    VStack(alignment : .leading){
                        // Profile Image
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
                                    .onAppear {
                                        daycare.downloadTeacherProfileImageData(t: teacher)
                                    }
                            }
                            Spacer()
                        }
                        
                        // group 1 static information
                        Group{
                            HStack{
                                Text("Name: " + (teacher.name ?? "no name"))
                                Spacer()
                                Button {
                                    // to show a sheet
                                    self.role = "teacher"
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
                                Text("Nick Name: " + (teacher.nickName ?? "no name"))
                                Spacer()
                                Button {
                                    // to show a sheet
                                    role = "teacher"
                                    field = "Nick Name"
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
                            
                            
                            Text("ID: " + (teacher.UID ?? "no UID"))
                            Text("Group Assigned: " + (teacher.group ?? "no group"))
                            HStack{
                                Text("Status: ")
                                Circle()
                                    .foregroundColor(teacher.isCheckedIn ? .green : .red)
                                    .frame(width: 20, height: 20)
                                Text(teacher.isCheckedIn ? "IN" : "OUT")
                                Text(" since:")
                                Text(daycare.selectedTeacher.lastKnownTimestamp ?? Date(), style: .time)
                                Spacer()
                            }
                        }
                        
                        // group 2 check in or check out
                        HStack{
                            Button {
                                daycare.teacherCheckedIn()
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
                                daycare.teacherCheckedOut()
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
                                daycare.fetchTeacherTimeSheetGivenMonth()
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
                                    daycare.assignClassTeacher(group: selectedClass)
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
                    .navigationTitle(teacher.name ?? "No name")
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
                                
                                // here is the problem.
                                VStack(alignment: .leading, spacing: 0){
                                    Text("Hours").font(.headline)
                                    Divider()
                                    ForEach(daycare.timeSheets){ i in
                                        if i.Out != nil && i.In != nil{
                                            Text("\((i.In!).distance(to: i.Out!)/3600, specifier: "%.1f")").font(.caption2)
                                                .onAppear {
                                                    totalHours = totalHours + (i.In!).distance(to: i.Out!)
                                                    print("print current total hours")
                                                    print("\(totalHours)")
                                                }
                                            
                                        }
                                        else{
                                            Text("N/A").font(.caption2)
                                        }
                                    }.onDisappear {
                                        print("reset total hours to 0.0")
                                        totalHours = 0.0
                                        daycare.timeSheets.removeAll()
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
            Text("No teacher")
            
        }
    }
        
}

