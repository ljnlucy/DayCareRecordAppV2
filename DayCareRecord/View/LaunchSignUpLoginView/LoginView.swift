//
//  LoginView.swift
//  DayCareRecordApp
//
//  Created by Jianan Li on 6/15/22.
//

import SwiftUI

struct LoginView: View {
    @EnvironmentObject var daycare : DayCareClass

    @State var email : String = ""
    @State var password : String = ""
    @State var showSignUpView : Bool = false
    @State var showForgetPasswordPopup : Bool = false
    
    var body: some View {
        
        if showSignUpView == false {
            ScrollView{
                ZStack{
                    /// Mark1: sign in view
                    VStack{
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
                                showSignUpView = true
                            } label: {
                                Text("SIGN UP").bold()
                            }
//                            NavigationLink {
//                                SignUpView()
//                            } label: {
//                                Text("SIGN UP").bold()
//                            }
                            Spacer()
                        }
                        
                    }
                    /// Mark2: error popup
                    if showForgetPasswordPopup == true {
                        ZStack{
                            Button {
                                showForgetPasswordPopup = false
                            } label: {
                                ZStack{
                                    Capsule()
                                        .frame(height : 50)
                                        .foregroundColor(.yellow)
                                    VStack{
                                        Text("Please contact admin to reset password").foregroundColor(.black)
                                        Text("OK")
                                            .bold().foregroundColor(.black)
                                    }
                                    
                                }
                            }

                        }
                    }
                }
            }
            .padding(.horizontal)
        }
        else{
            SignUpView(showSignUpView: $showSignUpView)
        }
        
        
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
