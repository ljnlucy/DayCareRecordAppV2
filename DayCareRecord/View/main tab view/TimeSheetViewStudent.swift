//
//  TimeSheetViewStudent.swift
//  DayCareRecordApp
//
//  Created by Jianan Li on 6/6/22.
//

import SwiftUI

struct TimeSheetViewStudent: View {
    @EnvironmentObject var daycare : DayCareClass
    var dateFormatter1 : DateFormatter = DateFormatter()
    var dateFormatter2 : DateFormatter = DateFormatter()

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
        
        if daycare.timeSheets.count == 0{
            ProgressView("Downloading Data...")
        }
        else{
            
            ScrollView{
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
                            }
                            else{
                                Text("N/A").font(.caption2)
                            }
                        }
                    }
                }
                .padding(.horizontal)
                .navigationTitle((daycare.selectedStudent.studentName ?? "") + "'s Timesheet")
            }
        }
        
        
    }
}

struct TimeSheetViewStudent_Previews: PreviewProvider {
    static var previews: some View {
        TimeSheetViewStudent()
    }
}
