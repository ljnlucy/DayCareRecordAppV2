//
//  SignUpView.swift
//  DayCareRecordApp
//
//  Created by Jianan Li on 6/15/22.
//

import SwiftUI

struct SignUpView: View {
    @EnvironmentObject var daycare : DayCareClass
    
    @Binding var showSignUpView : Bool
    
    @State var email : String = ""
    @State var password : String = ""
    @State var UID : String = ""
    @State var acceptTerms : Bool = false
    
    var body: some View {
        
            ScrollView{
                VStack(alignment: .leading){
                    HStack{
                        Spacer()
                        Image("background")
                            .resizable()
                            .ignoresSafeArea()
                            .scaledToFit()
                            .frame(height: 300)
                        Spacer()
                    }
                                    
                    
                    Group{
                        Text("EMAIL").foregroundColor(.gray).bold()
                        TextField("please enter your email", text: $email)
                        Divider()
                        Text("PASSWORD").foregroundColor(.gray).bold()
                        SecureField("please enter your password", text: $password)
                        Divider()
                        Text("UID").foregroundColor(.gray).bold()
                        TextField("Contact Admin to get an UID", text: $UID)
                        Divider()
                        
                    }
                    
                    if daycare.errorMsg2 != ""{
                        Text(daycare.errorMsg2).font(.caption2)
                    }
                    
                    Toggle("Accept privacy policy", isOn: $acceptTerms)
                    
                    Button {
                        // sign up
                        if self.acceptTerms == true{
                            daycare.signUp(email: email, password: password, UID: UID)
                        }
                        
                    } label: {
                        ZStack{
                            Rectangle()
                                .frame(maxWidth : .infinity, minHeight: 20, maxHeight: 30)
                                .padding(.vertical)
                                .foregroundColor(.teal)
                            
                            Text("SIGN UP")
                                .foregroundColor(.white)
                        }
                    }
                    
                    Button {
                        // back to sign in
                        showSignUpView = false
                        
                    } label: {
                        ZStack{
                            Rectangle()
                                .frame(maxWidth : .infinity, minHeight: 20, maxHeight: 30)
                                .padding(.vertical)
                                .foregroundColor(.teal)
                            
                            Text("Back to SIGN IN")
                                .foregroundColor(.white)
                        }
                    }
                    
                    Link(destination: URL(string: "https://www.freeprivacypolicy.com/live/3b3e060e-1468-404a-940a-9cadc536bfaa")!) {
                       Text("privacy policy")
                    }
                }
                .navigationTitle("Sign Up")
                .navigationBarTitleDisplayMode(.inline)
            }
            .padding(.horizontal)
            
            
            
        
        
        
    }
        
    
}



