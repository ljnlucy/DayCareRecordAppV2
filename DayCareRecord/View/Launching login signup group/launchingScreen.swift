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
    //@State var email : String = ""
    @AppStorage("email") var email : String = ""
    //@State var password : String = ""
    @AppStorage("password") var password : String = ""
    @State var showForgetPasswordPopup : Bool = false
    @State var UID : String = ""
    @State var acceptTerms : Bool = false
    @FocusState private var focusedField: FormField?
    @AppStorage("rememberPassword") var rememberPassword : Bool = false
    @State var showErrorMsg1 : Bool = false
    @State var showErrorMsg2 : Bool = false

    
    
    var body: some View {
        
        ScrollView(showsIndicators: false){
            VStack{
                Image("background2")
                        .resizable()
                    .scaledToFit()
                    .frame(maxHeight : 300)
                    
                if chooseSignUp == false{
                    // log in view
                    Group{
                        VStack(alignment : .leading){
                            Text("EMAIL").foregroundColor(.gray).bold()
                            TextField("please enter your email", text: $email)
                                .keyboardType(.emailAddress)
                                .disableAutocorrection(true)
                                .textCase(.lowercase)
                                .submitLabel(.next)
                                .focused($focusedField, equals: .email)
                                .onSubmit {
                                        focusedField = .password
                                      
                                    }
                            Divider()
                            Text("PASSWORD").foregroundColor(.gray).bold()
                            HStack{
                                SecureField("please enter your password", text: $password)
                                    .keyboardType(.default)
                                    .submitLabel(.go)
                                    .focused($focusedField, equals: .password)
                                    .onSubmit {
                                        daycare.signIn(email: email, password: password)
                                    }
                                Spacer()
                                
                                Button {
                                    // handle forget password-> show a popup
                                    showForgetPasswordPopup = true
                                    
                                } label: {
                                    Text("Forget Password").foregroundColor(.gray).font(.caption)
                                }
                                .alert("Please contact Administrator to reset", isPresented: $showForgetPasswordPopup) {
                                    Button("OK", role: .cancel) { }
                                }
                            }
                            Divider()
                            Toggle(isOn: $rememberPassword){
                                    Text("Remember Password")
                            }
                        }
                        
                    }
                    if daycare.errorMsg1 != ""{
                        //Text(daycare.errorMsg1).font(.caption2)
                        Text("")
                            .onAppear {
                                showErrorMsg1 = true

                            }
                    }
                    
                    Button {
                        // sign in
                        daycare.signIn(email: email, password: password)
                        
                        
                        // update appstorage property, update email and password
                        email = email
                        rememberPassword = rememberPassword
                        // add a button to allow user to choose remember password or not.
                        if rememberPassword == true {
                            password = password
                        }
                        else {
                            password = ""
                        }
                    } label: {
                        Text("SIGN IN")
                        
                    }
                    .padding()
                    .foregroundColor(.white)
                    .background(Color.teal)
                    .clipShape(RoundedRectangle(cornerRadius: 10))

                    
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
                                .keyboardType(.emailAddress)
                                .disableAutocorrection(true)
                                .textCase(.lowercase)
                                .submitLabel(.next)
                                .focused($focusedField, equals: .email2)
                                .onSubmit {
                                    focusedField = .password2
                                }
                            Divider()
                            Text("PASSWORD").foregroundColor(.gray).bold()
                            SecureField("please enter your password", text: $password).keyboardType(.default).submitLabel(.next)
                                .focused($focusedField, equals: .password2)
                                .onSubmit {
                                    focusedField = .UID
                                }
                            Divider()
                            Text("UID").foregroundColor(.gray).bold()
                            TextField("Contact Admin to get an UID", text: $UID).submitLabel(.go)
                                .disableAutocorrection(true)
                                .focused($focusedField, equals: .UID)
                                .onSubmit {
                                    if self.acceptTerms == true{
                                        daycare.signUp(email: email, password: password, UID: UID)
                                    }
                                }
                            Divider()
                        }
                        
                        
                    }
                    if daycare.errorMsg2 != ""{
                        //Text(daycare.errorMsg2).font(.caption2)
                        Text("")
                            .onAppear {
                                showErrorMsg2 = true
                            }
                    }
                    Toggle("Accept privacy policy", isOn: $acceptTerms)
                    Toggle(isOn: $rememberPassword){
                            Text("Remember Password")
                    }
                    Button {
                        // sign up
                        if self.acceptTerms == true{
                            daycare.signUp(email: email, password: password, UID: UID)
                            
                            // update appstorage property, update email and password
                            email = email
                            rememberPassword = rememberPassword
                            // add a button to allow user to choose remember password or not.
                            if rememberPassword == true {
                                password = password
                            }
                            else {
                                password = ""
                            }
                        }
                        
                    } label: {
                        Text("SIGN UP")
                    }
                    .padding()
                    .foregroundColor(.white)
                    .background(Color.teal)
                    .clipShape(RoundedRectangle(cornerRadius: 10))

                    
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
            .padding(.horizontal)
            .frame(maxWidth : .infinity)
            .alert(daycare.errorMsg1, isPresented: $showErrorMsg1) {
                Button("OK", role : .cancel){
                    password = ""
                }
            }
            .alert(daycare.errorMsg2, isPresented: $showErrorMsg2) {
                Button("OK", role : .cancel){
                    password = ""
                    UID = ""
                }
            }
        }
        
    }
    
    enum FormField {
        case email, password, email2, password2, UID
      }
}

struct launchingScreen_Previews: PreviewProvider {
    static var previews: some View {
        launchingScreen()
    }
}
