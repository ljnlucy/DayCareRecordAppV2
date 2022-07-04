//
//  Model.swift
//  DayCareRecordApp
//
//  Created by Jianan Li on 5/15/22.
//

import Foundation
import UIKit

class Teacher: Identifiable {
    var id : UUID?
    var name : String?
    var imageData : UIImage?
    var imageUrl : String?
    var isCheckedIn : Bool = false
    var lastKnownTimestamp : Date?
    var group : String = ""
    var UID : String?
    var nickName: String?
    var role : String = "teacher"
}

class Student: Identifiable {
    var id = UUID()
    var studentName : String?
    var isCheckedIn: Bool = false
    var guardianName : String?
    var guardianEmail : String?
    var guardianPhone : String?
    var guardian2Name : String?
    var guardian2Email : String?
    var guardian2Phone : String?
    var group : String = ""
    var imageUrl : String?
    var lastKnownTimestamp : Date?
    var imageData : UIImage?
    var UID : String?
    var nickName: String?
    var role : String = "student"


}

class classRoom : Identifiable{
    var id = UUID()
    var classRoomName : String?
    var classRoomDescription : String?
    var imageUrl : String?
}

class timeSheet : Identifiable{
    var id : UUID?
    var In : Date?
    var Out : Date?
    var day : String?
}

class randowm {
    var name : String?
}
