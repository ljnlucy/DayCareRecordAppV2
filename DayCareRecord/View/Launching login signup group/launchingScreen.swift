//
//  launchingScreen.swift
//  DayCareRecord
//
//  Created by Jianan Li on 7/18/22.
//

import SwiftUI

struct launchingScreen: View {
    @EnvironmentObject var daycare : DayCareClass
    @State var chooseSignUp : Bool = false
    @State var email : String = ""
    @State var password : String = ""
    @State var showForgetPasswordPopup : Bool = false
    @State var UID : String = ""
    @State var acceptTerms : Bool = false
    
    var body: some View {
        ScrollView(showsIndicators: false){
            VStack{
                Image("background2")
                    .resizable()
                    //.frame(height: 300)
                    .scaledToFit()
                if chooseSignUp == false{
                    // log in view
                    Group{
                        VStack(alignment : .leading){
                            Text("EMAIL").foregroundColor(.gray).bold()
                            TextField("please enter your email", text: $email)
                            Divider()
                            Text("PASSWORD").foregroundColor(.gray).bold()
                            HStack{
                                SecureField("please enter your password", text: $password)
                                Spacer()
                                Button {
                                    // handle forget password-> show a popup
                                    showForgetPasswordPopup = true
                                    
                                } label: {
                                    Text("Forget Password").foregroundColor(.gray)
                                }
                                
                            }
                            
                            Divider()
                        }
                        
                    }
                    if daycare.errorMsg1 != ""{
                        Text(daycare.errorMsg1).font(.caption2)
                    }
                    
                    Button {
                        // sign in
                        daycare.signIn(email: email, password: password)
                    } label: {
                        ZStack{
                            Rectangle()
                                .frame(maxWidth : .infinity, minHeight: 20, maxHeight: 30)
                                .padding(.vertical)
                                .foregroundColor(.teal)
                            
                            Text("SIGN IN")
                                .foregroundColor(.white)
                        }
                    }
                    
                    HStack{
                        Spacer()
                        
                        Text("Don't have an account?").foregroundColor(.gray)
                        Button {
                            chooseSignUp = true
                        } label: {
                            Text("SIGN UP").bold()
                        }
                        
                        
                        Spacer()
                    }
                }
                else{
                    // sign up view
                    Group{
                        VStack(alignment : .leading){
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
                        // sign up
                        chooseSignUp = false
                        
                    } label: {
                        Text("Back to SIGN IN page")
                            .foregroundColor(.blue).bold()
                            .padding(.bottom)
                    }
                    
                    Link(destination: URL(string: "https://www.freeprivacypolicy.com/live/3b3e060e-1468-404a-940a-9cadc536bfaa")!) {
                        Text("See Privacy Policy")
                    }
                    
                }
            }
            .frame(width : 350)
        }
        
    }
}

struct launchingScreen_Previews: PreviewProvider {
    static var previews: some View {
        launchingScreen()
    }
}
