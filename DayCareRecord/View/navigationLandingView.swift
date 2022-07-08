//
//  navigationLandingView.swift
//  DayCareRecord
//
//  Created by Jianan Li on 7/8/22.
//

import SwiftUI

struct navigationLandingView: View {
    var body: some View {
        VStack {
            Text("Welcome to Beloved Academy!")
                .font(.largeTitle)
            
            Text("Please select a teacher from the left-hand menu; swipe from the left edge to show it.")
                .foregroundColor(.secondary)
        }
    }
}

struct navigationLandingView_Previews: PreviewProvider {
    static var previews: some View {
        navigationLandingView()
    }
}
