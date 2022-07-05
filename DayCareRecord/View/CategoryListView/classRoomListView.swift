//
//  GroupListView.swift
//  DayCareRecordApp
//
//  Created by Jianan Li on 6/9/22.
//

import SwiftUI

struct classRoomListView: View {
    @EnvironmentObject var daycare : DayCareClass
    @State var isAddClassRoomSheetShow : Bool = false
    @Binding var showClassRoomListView : Bool
    var body: some View {
        NavigationView{
            if daycare.classRoomList.count == 0 {
                Text("Pleae add new group")
            }
            else{
               
                ScrollView{
                    
                
                ForEach(daycare.classRoomList){ g in
                    largeCardViewClassRoom(classroom: g)
//                    NavigationLink {
//                        singleClassRoomDetailView()
//                            .onAppear {
//                                daycare.selectedclassRoom = g
//                            }
//                    } label: {
//                        Text(g.classRoomName ?? "no name")
//                    }

                }
                }
                .padding(.horizontal)
                .navigationTitle("Class List")
                .toolbar {
                    HStack{
                        Button {
                            showClassRoomListView = false
                        } label: {
                            HStack{
                                Text("Home Screen").font(.caption2)
                                Image(systemName: "chevron.left")
                                }
                            }
                        
                        Button {
                            isAddClassRoomSheetShow = true
                        } label: {
                            HStack{
                                Text("Add classRoom").font(.caption2)
                                Image(systemName: "person.crop.circle.badge.plus")
                            }
                        }
                    }
                    
                    

                }
                .sheet(isPresented: $isAddClassRoomSheetShow) {
                    addClassRoomProfileSheet(isAddClassRoomSheetShow: $isAddClassRoomSheetShow)
                }
            }
        }
        
    }
}


