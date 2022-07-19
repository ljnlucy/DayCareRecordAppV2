//
//  DayCareClass.swift
//  DayCareRecordApp
//
//  Created by Jianan Li on 5/15/22.
//

import Foundation
import Firebase
import FirebaseAuth
import FirebaseStorage
import SwiftUI

class DayCareClass: ObservableObject{
    
    // declear variable for views
    @Published var teacherList : [Teacher] = [Teacher]()
    @Published var studentList : [Student] = [Student]()
    @Published var classRoomList : [classRoom] = [classRoom]()
    @Published var selectedTeacher : Teacher = Teacher()
    @Published var selectedStudent : Student = Student()
    @Published var selectedclassRoom : classRoom = classRoom()
    @Published var profileImageDict : Dictionary = [String : Data]()
    @Published var timeSheets : [timeSheet] = [timeSheet]()
    @Published var errorMsg1 : String = ""
    @Published var errorMsg2 : String = ""
    @Published var currentSignedInUserRole : String = ""
    @Published var currentSignedInUserUID : String = ""
    
    var listener1 : ListenerRegistration?
    var listener2 : ListenerRegistration?
    var listener3 : ListenerRegistration?
    var listener4 : ListenerRegistration?  // for single student mode
    
    @Published var signedInStatus : Bool = false
    
    // fire store releated variables
    var db = Firestore.firestore()
    var storage = Storage.storage()
    
    //
    @Published var selectedMonth : Int = 1
    var monthArray : [Date] = [Calendar.current.date(from: DateComponents(year : 2022, month: 1, day: 1, hour: 0, minute: 0, second: 0))!,
                               Calendar.current.date(from: DateComponents(year : 2022, month: 2, day: 1, hour: 0, minute: 0, second: 0))!,
                               Calendar.current.date(from: DateComponents(year : 2022, month: 3, day: 1, hour: 0, minute: 0, second: 0))!,
                               Calendar.current.date(from: DateComponents(year : 2022, month: 4, day: 1, hour: 0, minute: 0, second: 0))!,
                               Calendar.current.date(from: DateComponents(year : 2022, month: 5, day: 1, hour: 0, minute: 0, second: 0))!,
                               Calendar.current.date(from: DateComponents(year : 2022, month: 6, day: 1, hour: 0, minute: 0, second: 0))!,
                               Calendar.current.date(from: DateComponents(year : 2022, month: 7, day: 1, hour: 0, minute: 0, second: 0))!,
                               Calendar.current.date(from: DateComponents(year : 2022, month: 8, day: 1, hour: 0, minute: 0, second: 0))!,
                               Calendar.current.date(from: DateComponents(year : 2022, month: 9, day: 1, hour: 0, minute: 0, second: 0))!,
                               Calendar.current.date(from: DateComponents(year : 2022, month: 10, day: 1, hour: 0, minute: 0, second: 0))!,
                               Calendar.current.date(from: DateComponents(year : 2022, month: 11, day: 1, hour: 0, minute: 0, second: 0))!,
                               Calendar.current.date(from: DateComponents(year : 2022, month: 12, day: 1, hour: 0, minute: 0, second: 0))!,
                               Calendar.current.date(from: DateComponents(year : 2023, month: 1, day: 1, hour: 0, minute: 0, second: 0))!]
    var startDate = Calendar.current.date(from: DateComponents(year : 2022, month: 1, day: 1, hour: 0, minute: 0, second: 0))!
    var endDate = Calendar.current.date(from: DateComponents(year : 2022, month: 1, day: 1, hour: 0, minute: 0, second: 0))!
    var dateFormatter : DateFormatter = DateFormatter()
    @Published var showTimeSheet : Bool = false
    
    
    init() {
        // download teacher, student, classroom, and other information list
        //getTeacherList()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        addTeacherCollectionListener()
        addStudentCollectionListener()
        addclassRoomCollectionListener()
    }
    
    func getTeacherList() -> Void {
        let teacherCollection = db.collection("Teacher List")
        teacherCollection.getDocuments { querySnapshot, error in
            if error == nil && querySnapshot != nil {
                var teachers = [Teacher]()
                for doc in querySnapshot!.documents {
                    var t : Teacher = Teacher()
                    t.id = UUID()
                    t.name = doc["name"] as? String ?? nil
                    t.UID = doc["UID"] as? String ?? nil
                    t.nickName = doc["nickName"] as? String ?? nil
                    t.imageUrl = doc["imageUrl"] as? String ?? nil
                    t.isCheckedIn = doc["isCheckedIn"] as? Bool ?? false
                    t.group = doc["group"] as? String ?? ""
                    t.lastKnownTimestamp = (doc["lastKnownTimestamp"] as? Timestamp)?.dateValue() ?? nil
                    
                    teachers.append(t)
                }
                DispatchQueue.main.async {
                    self.teacherList = teachers
                    print("number of teacher")
                    print(self.teacherList.count)
                }
            }
            
        }
    }
    func getStudentList() -> Void {
        let studentCollection = db.collection("Student List")
        studentCollection.getDocuments { querySnapshot, error in
            if error == nil && querySnapshot != nil {
                var students = [Student]()
                for doc in querySnapshot!.documents {
                    var s : Student = Student()
                    s.id = UUID()
                    s.studentName = doc["studentName"] as? String ?? nil
                    s.nickName = doc["nickName"] as? String ?? nil
                    s.UID = doc["UID"] as? String ?? nil
                    s.imageUrl = doc["imageUrl"] as? String ?? nil
                    s.isCheckedIn = doc["isCheckedIn"] as? Bool ?? false
                    s.lastKnownTimestamp = (doc["lastKnownTimestamp"] as? Timestamp)?.dateValue() ?? nil
                    s.guardianPhone = doc["guardianPhone"] as? String ?? nil
                    s.guardianEmail = doc["guardianEmail"] as? String ?? nil
                    s.guardianName = doc["guardianName"] as? String ?? nil
                    s.guardian2Phone = doc["guardian2Phone"] as? String ?? nil
                    s.guardian2Email = doc["guardian2Email"] as? String ?? nil
                    s.guardian2Name = doc["guardian2Name"] as? String ?? nil
                    s.group = doc["group"] as? String ?? ""
                    students.append(s)
                }
                DispatchQueue.main.async {
                    self.studentList = students
                }
            }
            
        }
    }
    
    
    func createTeacherProfile(name : String, UID : String, nickName : String, originalImage : UIImage) -> Void {
        // reduce image size

        // compress image then upload image
        var compressedImageData : Data = originalImage.aspectFittedToHeight(160).jpegData(compressionQuality: 0.0) ?? Data()
        var parentPath = "images/teacher/"
        var childPath = "\(UID).jpg"
        
        let storageRef = storage.reference(withPath: parentPath + childPath)
        
        if compressedImageData != nil{
            storageRef.putData(compressedImageData) { meta, error in
                // create teacher profile + image url
                if error == nil{
                    self.db.collection("Teacher List").document(UID).setData(["name" : name,
                                                                               "UID" : UID,
                                                                               "nickName" : nickName,
                                                                               "isCheckedIn" : false,
                                                                               "imageUrl" : parentPath + childPath],
                                                                              merge: true) { error in
                        if error == nil{
                            self.getTeacherList()
                        }
                    }
                }
            }
        }
        
        
        
        
    }
    
    func createStudentProfile(studentName : String, UID : String, nickName : String,
                              guardianName : String, guardianEmail : String, guardianPhone : String,
                              guardian2Name : String, guardian2Email : String, guardian2Phone : String,
                              group : String, originalImage : UIImage) -> Void {
        var compressedImageData : Data = originalImage.aspectFittedToHeight(160).jpegData(compressionQuality: 0.2) ?? Data()
        var parentPath = "images/student/"
        var childPath = "\(UID).jpg"
        
        let storageRef = storage.reference(withPath: parentPath + childPath)
        
        if compressedImageData != nil{
            storageRef.putData(compressedImageData) { meta, error in
                // create teacher profile + image url
                if error == nil{
                    self.db.collection("Student List").document(UID).setData(["studentName" : studentName,
                                                                               "guardianName" : guardianName,
                                                                               "guardianEmail" : guardianEmail,
                                                                               "guardianPhone" : guardianPhone,
                                                                              "guardian2Name" : guardian2Name,
                                                                              "guardian2Email" : guardian2Email,
                                                                              "guardian2Phone" : guardian2Phone,
                                                                               "group" : group,
                                                                               "UID" : UID,
                                                                              "nickName" : nickName,
                                                                               "lastKnownTimestamp" : Date(),
                                                                               "isCheckedIn" : false,
                                                                               "imageUrl" : parentPath + childPath],
                                                                              merge: true) { error in
                        if error == nil{
                            self.getStudentList()
                        }
                    }
                }
            }
        }
    }
    
    func teacherCheckedIn() -> Void {
        
        if self.selectedTeacher.isCheckedIn == false {
            db.collection("Teacher List").document(selectedTeacher.UID!).setData(["isCheckedIn" : true, "lastKnownTimestamp" : Timestamp(date: Date())], merge: true)
            db.collection("Teacher List").document(selectedTeacher.UID!).collection("InOutRecords").document(self.dateFormatter.string(from: Date())).setData(["In" : Timestamp(date: Date())], merge: true)
        }
        else{
            print("teacher is already checked in. can't check in again")
            print("add HMI in future")
        }
        
        
        
    }
    func studentCheckedIn() -> Void {
        
        if self.selectedStudent.isCheckedIn == false {
        db.collection("Student List").document(selectedStudent.UID!).setData(["isCheckedIn" : true, "lastKnownTimestamp" : Timestamp(date: Date())], merge: true)
        db.collection("Student List").document(selectedStudent.UID!).collection("InOutRecords").document(self.dateFormatter.string(from: Date())).setData(["In" : Timestamp(date: Date())], merge: true)
        }
        else{
            print("student is already checked in. can't check in again")
            print("add HMI in future")
        }
        
    }
    
    func teacherCheckedOut() -> Void {
        // update firebase document field
        
        if self.selectedTeacher.isCheckedIn == true{
            db.collection("Teacher List").document(selectedTeacher.UID!).setData(["isCheckedIn" : false, "lastKnownTimestamp" : Timestamp(date: Date())], merge: true)
            db.collection("Teacher List").document(selectedTeacher.UID!).collection("InOutRecords").document(self.dateFormatter.string(from: Date())).setData(["Out" : Timestamp(date: Date())], merge: true)
        }
        else{
            print("teacher is already checked in. can't check in again")
            print("add HMI in future")
        }
        
        
    }
    func studentCheckedOut() -> Void {
        // update firebase document field
        if self.selectedStudent.isCheckedIn == true{
        db.collection("Student List").document(selectedStudent.UID!).setData(["isCheckedIn" : false, "lastKnownTimestamp" : Timestamp(date: Date())], merge: true)
        db.collection("Student List").document(selectedStudent.UID!).collection("InOutRecords").document(self.dateFormatter.string(from: Date())).setData(["Out" : Timestamp(date: Date())], merge: true)
        }
        else{
            print("student is already checked out. can't check out again")
            print("add HMI in future")
        }
    }
    
    func deleteTeacherProfile() -> Void {
        self.db.collection("Teacher List").document(selectedTeacher.UID!).delete { [self] error in
            if error == nil{
                // delete photo from storage as well
                self.storage.reference(withPath: self.selectedTeacher.imageUrl!).delete { error2 in
                    if error2 == nil{
                        DispatchQueue.main.async {
                            self.selectedTeacher = Teacher()
                        }
                    }
                }
                
                
            }
        }
        
    }
    func deleteStudentProfile() -> Void {
        self.db.collection("Student List").document(selectedStudent.UID!).delete { [self] error in
            if error == nil{
                // delete photo from storage as well
                self.storage.reference(withPath: self.selectedStudent.imageUrl!).delete { error2 in
                    if error2 == nil{
                        DispatchQueue.main.async {
                            self.selectedStudent = Student()
                        }
                    }
                }
                
                
            }
        }
        
    }
    
    func updateSelectedTeacherInfo() -> Void {
        if self.selectedTeacher.UID == nil{
            return
        }
        else{
            for t in self.teacherList {
                if t.UID == self.selectedTeacher.UID {
                    self.selectedTeacher = t
                    break
                }
            }
            
        }
    }
    func updateSelectedStudentInfo() -> Void {
        if self.selectedStudent.UID == nil{
            return
        }
        else{
            for t in self.studentList {
                if t.UID == self.selectedStudent.UID {
                    self.selectedStudent = t
                    break
                }
            }
            
        }
    }
    
    func downloadTeacherProfileImageData(t : Teacher) -> Void {
        if t.imageUrl != nil && t.UID != nil{
            let pathRef = self.storage.reference(withPath: t.imageUrl!)
            pathRef.getData(maxSize: 256 * 256) { data, error in
                if error == nil && data != nil{
                    DispatchQueue.main.async{
                        self.profileImageDict[t.UID!] = data!
                        print("teacher image is downloaded")
                    }
                }
                else{
                    print("image download error")
                    print(error?.localizedDescription)
                }
            }            
        }
        else{
            return
        }
    }
    func downloadStudentProfileImageData(s : Student) -> Void {
        if s.imageUrl != nil && s.UID != nil{
            let pathRef = self.storage.reference(withPath: s.imageUrl!)
            pathRef.getData(maxSize: 1 * 256 * 256) { data, error in
                if error == nil && data != nil{
                    DispatchQueue.main.async{
                        self.profileImageDict[s.UID!] = data!
                    }
                }
            }
            
        }
        else{
            return
        }
    }
    func downloadClassRoomProfileImageData(s : classRoom) -> Void {
        if s.imageUrl != nil && s.classRoomName != nil{
            let pathRef = self.storage.reference(withPath: s.imageUrl!)
            pathRef.getData(maxSize: 1 * 256 * 256) { data, error in
                if error == nil && data != nil{
                    DispatchQueue.main.async{
                        self.profileImageDict[s.classRoomName!] = data!
                    }
                }
            }
            
        }
        else{
            return
        }
    }
    
    
    /// add listeners to Teacher collection, and future collection
    func addTeacherCollectionListener() -> Void {
        self.listener2 = db.collection("Teacher List").addSnapshotListener { querySnapshot, error in
            if error == nil && querySnapshot != nil {
                var teachers = [Teacher]()
                for doc in querySnapshot!.documents {
                    var t : Teacher = Teacher()
                    t.id = UUID()
                    t.name = doc["name"] as? String ?? nil
                    t.UID = doc["UID"] as? String ?? nil
                    t.nickName = doc["nickName"] as? String ?? nil
                    t.imageUrl = doc["imageUrl"] as? String ?? nil
                    t.isCheckedIn = doc["isCheckedIn"] as? Bool ?? false
                    t.group = doc["group"] as? String ?? ""
                    t.lastKnownTimestamp = (doc["lastKnownTimestamp"] as? Timestamp)?.dateValue() ?? nil
                    teachers.append(t)
                }
                DispatchQueue.main.async {
                    // update teacher list
                    self.teacherList = teachers
                    
                    // update selected teacher
                    self.updateSelectedTeacherInfo()
                  
                }
            }
        }
        
    }
    func addStudentCollectionListener() -> Void {
        
        self.listener2 = db.collection("Student List").addSnapshotListener { querySnapshot, error in
            if error == nil && querySnapshot != nil {
                var students = [Student]()
                for doc in querySnapshot!.documents {
                    var s : Student = Student()
                    s.id = UUID()
                    s.studentName = doc["studentName"] as? String ?? nil
                    s.UID = doc["UID"] as? String ?? nil
                    s.nickName = doc["nickName"] as? String ?? nil
                    s.imageUrl = doc["imageUrl"] as? String ?? nil
                    s.isCheckedIn = doc["isCheckedIn"] as? Bool ?? false
                    s.guardianPhone = doc["guardianPhone"] as? String ?? nil
                    s.guardianEmail = doc["guardianEmail"] as? String ?? nil
                    s.guardianName = doc["guardianName"] as? String ?? nil
                    s.guardian2Phone = doc["guardian2Phone"] as? String ?? nil
                    s.guardian2Email = doc["guardian2Email"] as? String ?? nil
                    s.guardian2Name = doc["guardian2Name"] as? String ?? nil
                    s.group = doc["group"] as? String ?? ""
                    students.append(s)
                }
                DispatchQueue.main.async {
                    // update teacher list
                    self.studentList = students
                    // update selected teacher
                    self.updateSelectedStudentInfo()
                  
                }
            }
        }
        
    }
    
    
    func fetchTeacherTimeSheetGivenMonth() -> Void{
        
        // write a logic to set startDate and endDate
        self.startDate = self.monthArray[self.selectedMonth - 1]
        self.endDate = self.monthArray[self.selectedMonth]
        
        guard selectedTeacher.UID != nil else{
            return
        }
        let ref = db.collection("Teacher List").document(selectedTeacher.UID!).collection("InOutRecords").order(by: "In", descending: false)
        
        
        ref.whereField("In", isLessThan: endDate).whereField("In", isGreaterThan: startDate).getDocuments { querySnapShot, error in
            if error == nil && querySnapShot != nil {
                // temp storage
                var allTimeSheet = [timeSheet]()
                for doc in querySnapShot!.documents{
                    var singleTimeSheet = timeSheet()
                    singleTimeSheet.id = UUID()
                    singleTimeSheet.In = (doc["In"] as? Timestamp)?.dateValue() ?? nil
                    singleTimeSheet.Out = (doc["Out"] as? Timestamp)?.dateValue() ?? nil
                    singleTimeSheet.day = doc.documentID
                    
                    allTimeSheet.append(singleTimeSheet)
                }
                DispatchQueue.main.async {
                    self.timeSheets = allTimeSheet
                }
            }
        }
    
    }
    func fetchStudentTimeSheetGivenMonth() -> Void{
        
        // write a logic to set startDate and endDate
        self.startDate = self.monthArray[self.selectedMonth - 1]
        self.endDate = self.monthArray[self.selectedMonth]
        
        guard selectedStudent.UID != nil else{
            return
        }
        let ref = db.collection("Student List").document(selectedStudent.UID!).collection("InOutRecords").order(by: "In", descending: false)
        
        
        ref.whereField("In", isLessThan: endDate).whereField("In", isGreaterThan: startDate).getDocuments { querySnapShot, error in
            if error == nil && querySnapShot != nil {
                // temp storage
                var allTimeSheet = [timeSheet]()
                for doc in querySnapShot!.documents{
                    var singleTimeSheet = timeSheet()
                    singleTimeSheet.id = UUID()
                    singleTimeSheet.In = (doc["In"] as? Timestamp)?.dateValue() ?? nil
                    singleTimeSheet.Out = (doc["Out"] as? Timestamp)?.dateValue() ?? nil
                    singleTimeSheet.day = doc.documentID
                    
                    allTimeSheet.append(singleTimeSheet)
                }
                DispatchQueue.main.async {
                    self.timeSheets = allTimeSheet
                }
            }
        }
    
    }

    /// three new functions for classroom
    func addclassRoomCollectionListener() -> Void{
        self.listener3 = db.collection("classRoom List").addSnapshotListener { querySnapshot, error in
            if error == nil && querySnapshot != nil {
                var groups = [classRoom]()
                for doc in querySnapshot!.documents {
                    var g : classRoom = classRoom()
                    g.classRoomName = doc["classRoomName"] as? String ?? nil
                    g.classRoomDescription = doc["classRoomDescription"] as? String ?? nil
                    g.imageUrl = doc["imageUrl"] as? String ?? nil
                    groups.append(g)
                }
                DispatchQueue.main.async {
                    // update teacher list
                    self.classRoomList = groups
                }
            }
        }
    }
    func createclassRoomProfile(classRoomName : String, classRoomDescription : String, originalImage : UIImage) -> Void {
        // upload image
        var compressedImageData : Data = originalImage.aspectFittedToHeight(160).jpegData(compressionQuality: 0.2) ?? Data()
        var parentPath = "images/classRoom/"
        var childPath = "\(classRoomName).jpg"
        
        let storageRef = storage.reference(withPath: parentPath + childPath)
        
        if compressedImageData != nil{
            storageRef.putData(compressedImageData) { meta, error in
                // create teacher profile + image url
                if error == nil{
                    self.db.collection("classRoom List").document(classRoomName).setData(["classRoomName" : classRoomName,
                                                                               "classRoomDescription" : classRoomDescription,
                                                                               "imageUrl" : parentPath + childPath],
                                                                              merge: true) { error in
                        if error == nil{
                            //self.getTeacherList()
                        }
                    }
                }
            }
        }
        
        
        
        
    }
    func deleteclassRoomProfile() -> Void {
        // 1. delete group document
        self.db.collection("classRoom List").document(selectedclassRoom.classRoomName!).delete { [self] error in
            if error == nil{
                //1.1 delete photo from storage as well
                self.storage.reference(withPath: self.selectedclassRoom.imageUrl!).delete { error2 in
                    if error2 == nil{
                        DispatchQueue.main.async {
                            self.selectedclassRoom = classRoom()
                        }
                    }
                }
                // 2. change teacher document's group field if those group field match current group name
                db.collection("Teacher List").whereField("group", isEqualTo: selectedclassRoom.classRoomName).getDocuments { querySnapShot, error in
                    if error == nil && querySnapShot != nil {
                        for doc in querySnapShot!.documents {
                            db.collection("Teacher List").document(doc.documentID).setData(["group" : ""], merge: true)
                        }
                    }
                }
                // 3. change student document's group field if those group field match current group name
                db.collection("Student List").whereField("group", isEqualTo: selectedclassRoom.classRoomName).getDocuments { querySnapShot, error in
                    if error == nil && querySnapShot != nil {
                        for doc in querySnapShot!.documents {
                            db.collection("Student List").document(doc.documentID).setData(["group" : ""], merge: true)
                        }
                    }
                }
            }
        }
        
    }
    
    func assignClassTeacher(group : String) -> Void{
        db.collection("Teacher List").document(self.selectedTeacher.UID!).setData(["group" : group], merge: true)
    }
    func assignClassStudent(group : String) -> Void{
        db.collection("Student List").document(self.selectedStudent.UID!).setData(["group" : group], merge: true)
    }
    
    func signIn(email : String, password : String) -> Void {
        // how to sign in?
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            if error == nil{
                self.isSignedIn()
                self.errorMsg1 = ""
                self.checkCurrentSignedUserRole(email: email)
            }
            else{
                self.errorMsg1 = error!.localizedDescription
            }
        }
        
    }
    
    func checkCurrentSignedUserRole(email: String) -> Void {
        db.collection("User List").whereField("email", isEqualTo: email.lowercased()).getDocuments { querySnapShot, error in
            if error == nil && querySnapShot != nil{
                var role : String = ""
                var UID : String = ""
                for doc in querySnapShot!.documents{
                    role = doc["role"] as? String ?? ""
                    UID = doc["UID"] as? String ?? ""
                }
                DispatchQueue.main.async {
                    self.currentSignedInUserRole = role
                    self.currentSignedInUserUID = UID
                    print("current user role is " + role)
                    print("current user UID is " + UID)
                    
                    
                    // speical code only for student
                    if role == "student" {
                        self.removeListeners()
                        // reset list
                        self.teacherList.removeAll()
                        self.studentList.removeAll()
                        self.classRoomList.removeAll()
                        
                        //add a single student listener
                        self.addSingleStudentListener(UID: UID)
                    }
                    
                    
                    
                }
            }
        }
    }
    
    func signUp(email : String, password : String , UID : String) -> Void {
        // how to sign up
        db.collection("Teacher List").whereField("UID", isEqualTo: UID).getDocuments { querySnapShot, error in
            if error == nil && querySnapShot != nil{
                for doc in querySnapShot!.documents{
                    print(doc.data())
                    print("UID is found in teacher list collection")
                    print("start create new account")
                    Auth.auth().createUser(withEmail: email, password: password) { result, error2 in
                        if error2 == nil{
                            self.db.collection("User List").document(email).setData(["email" : email.lowercased(), "UID" : UID, "role" : "teacher"], merge: true)
                            self.currentSignedInUserRole = "teacher"
                            self.isSignedIn()
                            return
                        }
                    }
                }
            }
        }
        db.collection("Student List").whereField("UID", isEqualTo: UID).getDocuments { querySnapShot, error in
            if error == nil && querySnapShot != nil{
                for doc in querySnapShot!.documents{
                    print(doc.data())
                    print("UID is found in student list collection")
                    print("start create new account")
                    Auth.auth().createUser(withEmail: email, password: password) { result, error3 in
                        if error3 == nil{
                            self.db.collection("User List").document(email).setData(["email" : email, "UID" : UID, "role" : "student"], merge: true)
                            self.currentSignedInUserRole = "student"
                            self.isSignedIn()
                            return
                        }
                    }
                }
            }
        }
        
    }
   
    func signOut() -> Void{
        try! Auth.auth().signOut()
        self.signedInStatus = false
        removeListeners()
        self.classRoomList.removeAll()
        self.studentList.removeAll()
        self.teacherList.removeAll()
        self.selectedStudent = Student()
        self.selectedTeacher = Teacher()
        self.selectedclassRoom = classRoom()
        
    }
    
    func isSignedIn() -> Void{
        self.signedInStatus = Auth.auth().currentUser == nil ? false: true
    }
    
    func removeListeners () -> Void{
        self.listener1?.remove()
        self.listener2? .remove()
        self.listener3? .remove()
    }
    
    func autoSignOutAfterTenMinutes() -> Void {
        // 1. start a timer when app goes to background
        // 2. set timer as 10 minutes (30 seconds for testing)
        // 3. call signOut
        print("app goes to background")
//
//        let timer = Timer.scheduledTimer(withTimeInterval: 5.0, repeats: false) { timer in
//            print("Time is up!")
//        }
    }
    
    func addSingleStudentListener(UID : String) -> Void {
        // debug log
        print("listener 4 is added")
        listener4 = db.collection("Student List").document(UID).addSnapshotListener { docSnapShot, error in
            if error == nil && docSnapShot != nil {
                // fetch data and save it as selected student as student list
                var s : Student = Student()
                s.UID = UID
                s.role = "student"
                s.isCheckedIn = docSnapShot!.data()!["isCheckedIn"] as? Bool ?? false
                s.group = docSnapShot!.data()!["group"] as? String ?? ""
                s.guardianName = docSnapShot!.data()!["guardianName"] as? String ?? ""
                s.guardian2Name = docSnapShot!.data()!["guardian2Name"] as? String ?? ""
                s.guardianEmail = docSnapShot!.data()!["guardianEmail"] as? String ?? ""
                s.guardian2Email = docSnapShot!.data()!["guardian2Email"] as? String ?? ""
                s.guardianPhone = docSnapShot!.data()!["guardianPhone"] as? String ?? ""
                s.guardian2Phone = docSnapShot!.data()!["guardian2Phone"] as? String ?? ""
                s.imageUrl = docSnapShot!.data()!["imageUrl"] as? String ?? ""
                s.lastKnownTimestamp = (docSnapShot!.data()!["lastKnownTimestamp"] as? Timestamp)?.dateValue() ?? nil
                s.nickName = docSnapShot!.data()!["nickName"] as? String ?? ""
                s.studentName = docSnapShot!.data()!["studentName"] as? String ?? ""
                
                DispatchQueue.main.async {
                    // print debug log
                    print("there is a data change.")
                    print(docSnapShot!.data())
                    self.studentList = [s]
                    self.selectedStudent = s
                }
            }
        }
    }
    
    func updateTeacherProfileName(newValue : String) -> Void {
        db.collection("Teacher List").document(selectedTeacher.UID!).setData(["name" : newValue], merge: true)
    }
    func updateTeacherProfileNickName(newValue : String) -> Void {
        db.collection("Teacher List").document(selectedTeacher.UID!).setData(["nickName" : newValue], merge: true)
    }
    /*                                          */
    func updateStudentProfileName(newValue : String) -> Void {
        db.collection("Student List").document(selectedStudent.UID!).setData(["studentName" : newValue], merge: true)
    }
    
    func updateStudentProfileNickName(newValue : String) -> Void {
        db.collection("Student List").document(selectedStudent.UID!).setData(["nickName" : newValue], merge: true)
    }
    func updateStudentProfileGuardianName(newValue : String) -> Void {
        db.collection("Student List").document(selectedStudent.UID!).setData(["guardianName" : newValue], merge: true)
    }
    func updateStudentProfileGuardianPhone(newValue : String) -> Void {
        db.collection("Student List").document(selectedStudent.UID!).setData(["guardianPhone" : newValue], merge: true)
    }
    func updateStudentProfileGuardianEmail(newValue : String) -> Void {
        db.collection("Student List").document(selectedStudent.UID!).setData(["guardianEmail" : newValue], merge: true)
    }
    func updateStudentProfileGuardian2Name(newValue : String) -> Void {
        db.collection("Student List").document(selectedStudent.UID!).setData(["guardian2Name" : newValue], merge: true)
    }
    func updateStudentProfileGuardian2Phone(newValue : String) -> Void {
        db.collection("Student List").document(selectedStudent.UID!).setData(["guardian2Phone" : newValue], merge: true)
    }
    func updateStudentProfileGuardian2Email(newValue : String) -> Void {
        db.collection("Student List").document(selectedStudent.UID!).setData(["guardian2Email" : newValue], merge: true)
    }
}


extension UIImage {
    func aspectFittedToHeight(_ newHeight: CGFloat) -> UIImage {
        
        let scale = newHeight / self.size.height
        let newWidth = self.size.width * scale
        let newSize = CGSize(width: newWidth, height: newHeight)
        let renderer = UIGraphicsImageRenderer(size: newSize)

        return renderer.image { _ in
            self.draw(in: CGRect(origin: .zero, size: newSize))
        }
    }
}
