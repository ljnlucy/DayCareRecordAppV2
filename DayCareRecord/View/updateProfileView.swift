//
//  updateProfileView.swift
//  DayCareRecord
//
//  Created by Jianan Li on 7/4/22.
//

import SwiftUI

struct updateProfileView: View {
    @EnvironmentObject var daycare : DayCareClass
    @State var newValue : String = ""
    @State var category: String = ""
    @State var field : String = ""
    var body: some View {
        VStack(alignment:.leading){
            TextField("Enter new value here", text: $newValue).font(.largeTitle)
            Button {
                // call function to merge new data
                if category == "teacher"{
                    switch field {
                    case "name":
                        if newValue != ""{
                            daycare.updateTeacherProfileName(name: newValue)
                        }
                    case "nickName":
                        if newValue != ""{
                            daycare.updateTeacherProfileNickName(nickName: newValue)
                        }
                    default:
                        return
                    }
                }
            } label: {
                Text("Confirm").font(.largeTitle)
            }

        }
    }
}

struct updateProfileView_Previews: PreviewProvider {
    static var previews: some View {
        updateProfileView()
    }
}
