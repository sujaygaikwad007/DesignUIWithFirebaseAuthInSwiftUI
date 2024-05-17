//
//  SignUpScreen.swift
//  DesignUI
//
//  Created by Aniket Patil on 14/05/24.
//

import SwiftUI

struct SignUpScreen: View {
    // Constants
    let primaryColor = Color("button-color")
    let logoSize: CGFloat = 150
    let paddingValue: CGFloat = 20
    let cornerRadius: CGFloat = 10
    
    // State variables
    @State private var email = ""
    @State private var password = ""
    @State private var fullname = ""
    @State private var isPasswordSecure = true
    @State private var showToast = false
    @State private var toastMessage = ""
    @State private var isSignUpSuccessful = false
    
    
    
    var body: some View {
        ZStack {
            ScrollView(showsIndicators: false) {
                VStack(spacing: paddingValue) {
                    Image("Logo")
                        .resizable()
                        .scaledToFill()
                        .frame(width: logoSize, height: logoSize)
                        .padding(.top, 40)
                    
                    Text("Sign Up Now")
                        .font(.largeTitle)
                        .fontWeight(.semibold)
                        .padding(.bottom, 5)
                    
                    Text("Please fill the details and create an account ")
                        .font(.headline)
                        .foregroundColor(.gray)
                        .multilineTextAlignment(.center)
                        .padding(.bottom, 5)
                    
                    VStack(spacing: 20) {
                        CustomTextField(text: $fullname, placeholder: "Full Name", keyboardType: .alphabet)
                        CustomTextField(text: $email, placeholder: "Email", keyboardType: .emailAddress)
                            .autocapitalization(.none)
                        CustomSecureField(text: $password, placeholder: "Password", isSecure: $isPasswordSecure)
                            .keyboardType(.default)
                        
                        Text("Password must be at least 6 characters")
                            .font(.subheadline)
                            .foregroundColor(Color.gray)
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                    .padding()
                    
                    Button(action: signUpButtonAction) {
                        Text("Sign Up")
                            .font(.headline)
                            .fontWeight(.semibold)
                            .foregroundColor(.white)
                            .padding(.vertical, 20)
                            .frame(maxWidth: .infinity)
                            .background(primaryColor.cornerRadius(cornerRadius))
                            .padding(.horizontal, 10)
                    }
                    
                    HStack {
                        Text("Already have an account?")
                            .font(.headline)
                            .foregroundColor(Color.gray)
                        
                        NavigationLink(destination: LoginScreen(email: email, password: password)) {
                            Text("Log In")
                                .foregroundColor(primaryColor)
                        }
                    }
                    .padding(.vertical, 5)
                    
                    Text("Or Connect with")
                        .font(.subheadline)
                        .foregroundColor(Color.gray)
                    
                    SocialMedia()
                }
                .hideKeyboardOnTap()
                .customToast(isPresented: $showToast, message: toastMessage)
            }
            .navigationBarHidden(true)
            .navigationBarBackButtonHidden(true)
            .ignoresSafeArea()
            NavigationLink(destination: LoginScreen(email: email, password: password), isActive: $isSignUpSuccessful) {
                EmptyView()
            }
        }
    }
    
    private func signUpButtonAction() {
        Task {
            do {
                if fullname.isEmpty || email.isEmpty || password.isEmpty {
                    showToast(message: "Please fill all fields")
                } else if !email.isValidEmail {
                    showToast(message: "Invalid email address")
                } else if !password.isValidPassword {
                    showToast(message: "Invalid password. Password must be at least 6 characters")
                } else {
                    showToast(message: "Signing Up...")
                    let authResult = try await AuthManager.shared.signUpWithEmail(email: email, password: password)
                    
                    DispatchQueue.main.async {
                        isSignUpSuccessful = true
                    }
                }
            } catch {
                
                    showToast(message: error.localizedDescription)
               
            }
        }
    }
    
    
    
    private func showToast(message: String) {
        toastMessage = message
        showToast = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            showToast = false
        }
    }
}

struct SignUpScreen_Previews: PreviewProvider {
    static var previews: some View {
        SignUpScreen()
    }
}
