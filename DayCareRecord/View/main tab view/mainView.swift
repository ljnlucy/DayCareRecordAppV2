//
//  ContentView.swift
//  DayCareRecordApp
//
//  Created by Jianan Li on 5/14/22.
//

import SwiftUI

struct mainTabView: View {
    
    @EnvironmentObject var daycare : DayCareClass
    @State var isTeacherQuickViewShow : Bool = false
    @State var isStudentQuickViewShow : Bool = false
    @State var isClassRoomQuickViewShow : Bool = false

    @State var showTeacherListView : Bool = false
    @State var showStudentListView : Bool = false
    @State var showClassRoomListView : Bool = false
    
    var body: some View {
        
        if showTeacherListView == false && showStudentListView == false && showClassRoomListView == false {
            ScrollView{
                VStack{
                    
                    Text("Welcome to Beloved Daycare")
                        .font(.title3)
                        .foregroundColor(.white)
                    
                    HStack{
                        Spacer()
                        Button {
                            daycare.signOut()
                        } label: {
                            HStack{
                                Text("Sign Out").font(.headline)
                                Image(systemName: "square.and.arrow.up")
                            }.foregroundColor(.white).padding(.horizontal)
                            
                        }
                    }
                    .padding(.vertical)
                    // teacher scroll view horizontally
                    if daycare.currentSignedInUserRole == "teacher"{
                        HStack{
                            Text("Teacher: ").foregroundColor(.white)
                                .font(.headline)
                                .padding(.leading)
                            Spacer()
                            
                            Button {
                                // enable teacher list view flag
                                showTeacherListView = true
                                
                            } label: {
                                HStack{
                                    Text("See All").foregroundColor(.white).font(.headline)
                                    Image(systemName: "chevron.right").padding(.trailing).foregroundColor(.white)
                                }
                            }

                            /*
                            NavigationLink {
                                TeacherListView()
                            } label: {
                                HStack{
                                    Text("See All").foregroundColor(.white).font(.headline)
                                    Image(systemName: "chevron.right").padding(.trailing).foregroundColor(.white)
                                }
                            }*/
                        }
                        
                        if daycare.teacherList.count == 0{
                            ProgressView("loading ...")
                        }
                        else{
                            
                            // Teacher section
                            
                            ScrollView(.horizontal){
                                
                                HStack{
                                    ForEach(daycare.teacherList){ teacher in
                                        /// small card view
                                        smallCardView(isTeacherQuickViewShow : $isTeacherQuickViewShow, teacher: teacher)
                                    }
                                    
                                }
                            }
                        }
                    }
                    // student scroll view horizontally
                    HStack{
                        Text("Students: ").foregroundColor(.white)
                            .font(.headline)
                            .padding(.leading)
                        Spacer()
                        /*
                        NavigationLink {
                            StudentListView()
                           
                        } label: {
                            HStack{
                                Text("See All").foregroundColor(.white).font(.headline)
                                Image(systemName: "chevron.right").padding(.trailing).foregroundColor(.white)
                            }
                        }*/
                        
                        Button {
                            // enable teacher list view flag
                            showStudentListView = true
                            
                        } label: {
                            HStack{
                                Text("See All").foregroundColor(.white).font(.headline)
                                Image(systemName: "chevron.right").padding(.trailing).foregroundColor(.white)
                            }
                        }
                    }
                    if daycare.studentList.count == 0{
                        ProgressView("loading data ...")
                    }
                    else{
                        ScrollView(.horizontal){
                            
                            HStack{
                                ForEach(daycare.studentList){ student in
                                    /// small card view
                                    smallCardViewStudent(isStudentQuickViewShow : $isStudentQuickViewShow, student: student)
                                }
                                
                            }
                        }
                        
                    }
                    // classroom scroll view horizontally
                    if daycare.currentSignedInUserRole == "teacher"{
                        HStack{
                            Text("Class: ").foregroundColor(.white)
                                .font(.headline)
                                .padding(.leading)
                            Spacer()
                            
                            Button {
                                showClassRoomListView = true
                            } label: {
                                HStack{
                                    Text("See All").foregroundColor(.white).font(.headline)
                                    Image(systemName: "chevron.right").padding(.trailing).foregroundColor(.white)
                                }
                            }

                            
                            /*
                            NavigationLink {
                                classRoomListView()
                               
                            } label: {
                                HStack{
                                    Text("See All").foregroundColor(.white).font(.headline)
                                    Image(systemName: "chevron.right").padding(.trailing).foregroundColor(.white)
                                }
                                
                            }*/
                        }
                        if daycare.classRoomList.count == 0{
                            ProgressView("loading data ...")
                        }
                        else{
                            ScrollView(.horizontal){
                                
                                HStack{
                                    ForEach(daycare.classRoomList){ classroom in
                                        /// small card view
                                        smallCardViewClassRoom(isClassRoomQuickViewShow : $isClassRoomQuickViewShow, classroom: classroom)
                                    }
                                    
                                }
                            }
                            
                        }
                    }
                }
                .sheet(isPresented: $isStudentQuickViewShow, onDismiss: nil, content: {
                    // create a new sheet view to show teacher quick actions
                    StudentQuickView(isStudentQuickViewShow : $isStudentQuickViewShow)
                })
                .sheet(isPresented: $isClassRoomQuickViewShow, onDismiss: nil, content: {
                    // create a new sheet view to show teacher quick actions
                    ClassRoomQuickView(isClassRoomQuickViewShow : $isClassRoomQuickViewShow)
                })
                /*.background {
                    Image("background")
                        .resizable()
                        .ignoresSafeArea()
                        .scaledToFill()
                }*/
                .navigationBarHidden(false)
                .navigationTitle("Home screen")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    Button {
                        daycare.signOut()
                    } label: {
                        HStack{
                            Text("Sign Out").font(.caption2)
                            Image(systemName: "square.and.arrow.up")
                        }.foregroundColor(.white)
                        
                    }
                    
                        
            
            
                }
                .sheet(isPresented: $isTeacherQuickViewShow, onDismiss: nil, content: {
                    // create a new sheet view to show teacher quick actions
                    TeacherQuickView(isTeacherQuickViewShow : $isTeacherQuickViewShow)
                })
            }
            .background {
                Image("background")
                    .resizable()
                    .ignoresSafeArea()
                    .scaledToFill()
            }
            
        }
        else if showTeacherListView == true {
            TeacherListView(showTeacherListView: $showTeacherListView)
        }
        else if showStudentListView == true {
            // something to do
            StudentListView(showStudentListView: $showStudentListView)
        }
        else if showClassRoomListView == true {
            // something to do
            classRoomListView(showClassRoomListView: $showClassRoomListView)
        }
        
        
    }
}
