//
//  LoginScreen.swift
//  DesignUI
//
//  Created by Aniket Patil on 14/05/24.
//

import SwiftUI

struct LoginScreen: View {
    // Constants
    let primaryColor = Color("button-color")
    let logoSize: CGFloat = 150
    let paddingValue: CGFloat = 20
    let cornerRadius: CGFloat = 10
    
    // State variables
    @State private var email: String
    @State private var password: String
    @State private var isPasswordSecure = true
    @State private var toastMessage = ""
    @State private var showToast = false
    @State private var isLoginSuccess = false
    
    // Initializer to accept email and password
    init(email: String, password: String) {
        self._email = State(initialValue: email)
        self._password = State(initialValue: password)
    }
    
    var body: some View {
        ZStack {
            ScrollView(showsIndicators: false) {
                VStack(spacing: paddingValue) {
                    Image("Logo")
                        .resizable()
                        .scaledToFill()
                        .frame(width: logoSize, height: logoSize)
                        .padding(.top, 40)
                    
                    Text("Log In Now")
                        .font(.largeTitle)
                        .fontWeight(.semibold)
                        .padding(.top, 40)
                    
                    Text("Please login to continue using our app")
                        .font(.headline)
                        .foregroundColor(.gray)
                        .multilineTextAlignment(.center)
                        .padding(.bottom, 5)
                    
                    VStack(spacing: 20) {
                        CustomTextField(text: $email, placeholder: "Email", keyboardType: .emailAddress)
                            .autocapitalization(.none)
                        
                        CustomSecureField(text: $password, placeholder: "Password", isSecure: $isPasswordSecure)
                        
                        
                        
                        Text("Forgot Password?")
                            .font(.subheadline)
                            .foregroundColor(Color.gray)
                            .frame(maxWidth: .infinity, alignment: .trailing)
                            .onTapGesture {
                                forgotPasswordAction()
                            }
                        
                        
                        
                    }
                    .padding()
                    
                    Button(action: loginAction) {
                        Text("Log In")
                            .font(.headline)
                            .fontWeight(.semibold)
                            .foregroundColor(.white)
                            .padding(.vertical, 20)
                            .frame(maxWidth: .infinity)
                            .background(primaryColor.cornerRadius(cornerRadius))
                            .padding(.horizontal, 10)
                    }
                    
                    HStack {
                        Text("Didn't have any account?")
                            .font(.headline)
                            .foregroundColor(Color.gray)
                        
                        NavigationLink(destination: SignUpScreen()) {
                            Text("Sign Up")
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
            NavigationLink(destination: LoginSuccess(), isActive: $isLoginSuccess) {
                EmptyView()
            }
        }
    }
    
    // Login Action
    private func loginAction() {
        
        Task{
            do{
                if email.isEmpty || password.isEmpty {
                    showToast(message: "Please fill all fields")
                } else {
                    
                    
                    let authResult = try await AuthManager.shared.signInWithEmail(email: email, password: password)
                    
                    DispatchQueue.main.async {
                        showToast(message: "Login Successful!")
                        isLoginSuccess = true
                    }
                }
            }
            catch{
                DispatchQueue.main.async {
                    showToast(message: error.localizedDescription)
                }
            }
        }
        
        
    }
    
    
    //Forgot password
    private func forgotPasswordAction() {
        guard !email.isEmpty else {
            showToast(message: "Please enter your email address")
            return
        }
        
        Task {
            do {
                showToast(message: "Sending password reset email...")
                try await AuthManager.shared.sendPasswordResetEmail(email: email)
                showToast(message: "Password reset email sent successfully. Please check your email inbox.")
               
            } catch {
                showToast(message: error.localizedDescription)
            }
        }
    }
    
    
    // Show Toast Message
    private func showToast(message: String) {
        toastMessage = message
        showToast = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            showToast = false
        }
    }
    
}

struct LoginScreen_Previews: PreviewProvider {
    static var previews: some View {
        LoginScreen(email: "", password: "")
    }
}
