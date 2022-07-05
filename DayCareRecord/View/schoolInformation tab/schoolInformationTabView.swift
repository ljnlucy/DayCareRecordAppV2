//
//  schoolInformationTabView.swift
//  DayCareRecordApp
//
//  Created by Jianan Li on 6/13/22.
//

import SwiftUI

struct schoolInformationTabView: View {
    var body: some View {
        VStack{
                Form{
                    Section {
                        Text("Thank you for your interest in Beloved Children Academy. We aim to serve our students and their families in a God-honoring, professional manner every day.")
                        Text("We are committed to providing our children with the academic and spiritual foundation they need for their continued success. We are proud to become the bilingual preschool and kindergarten in our community. ")
                    } header: {
                        Text("Message From the Director").foregroundColor(.white).bold()
                    } footer: {
                        Text("Lisi Yu").bold().foregroundColor(.white)
                    }
                    
                    Section {
                        Text("Regular Semester (Sept - June)")
                        Text("8:30 A.M. to 5:30 P.M.")
                        Text("Summer Camp (Jul - Aug)")
                        Text("9:00 A.M. to 5:00 P.M.")
                    } header: {
                        Text("Hours of operation").foregroundColor(.white).bold()
                        
                    }
                    
                    Section {
                        Text("Tele: 248-525-4528")
                        Text("Email: beloved@fecc.us")
                    } header: {
                        Text("Contact").foregroundColor(.white).bold()
                        
                    }
                    
                    Section {
                        Text("3193 Rochester Road, Troy, MI 48083")
                    } header: {
                        Text("Address").foregroundColor(.white).bold()
                        
                    }
                    
                    Section {
                        Text("Lisi Yu")
                            
                    }header: {
                        Text("Director").foregroundColor(.white).bold()
                        
                    }
                    

                }
                .navigationTitle("Beloved Children Academy")
                .navigationBarTitleDisplayMode(.inline)
                .background(content: Image("background").resizable().ignoresSafeArea().scaledToFill)
                .onAppear {
                  UITableView.appearance().backgroundColor = .clear
                }
                
        
            
            
            
        }
        
        
    }
}

struct schoolInformationTabView_Previews: PreviewProvider {
    static var previews: some View {
        schoolInformationTabView()
    }
}
