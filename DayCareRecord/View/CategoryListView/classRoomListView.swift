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
    
    var body: some View {
        ScrollView{
            if daycare.classRoomList.count == 0 {
                Text("Pleae add new group")
            }
            else{
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
        }
        .padding(.horizontal)
        .navigationTitle("Class List")
        .toolbar {
            Button {
                isAddClassRoomSheetShow = true
            } label: {
                HStack{
                    Text("Add classRoom").font(.caption2)
                    Image(systemName: "person.crop.circle.badge.plus")
                }
            }

        }
        .sheet(isPresented: $isAddClassRoomSheetShow) {
            addClassRoomProfileSheet(isAddClassRoomSheetShow: $isAddClassRoomSheetShow)
        }
    }
}

struct GroupListView_Previews: PreviewProvider {
    static var previews: some View {
        classRoomListView()
    }
}
