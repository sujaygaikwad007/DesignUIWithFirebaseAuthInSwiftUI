//
//  LoginSuccess.swift
//  DesignUI
//
//  Created by Aniket Patil on 14/05/24.
//

import SwiftUI

struct LoginSuccess: View {
    
    @State var loginSuccess = false
    @State var loggedUserName = "User"
    var body: some View {
        
        
        ZStack
        {
            VStack (spacing:20){
                
        
                Text("Welcome \(self.loggedUserName)")
                    .font(.body)
                    .fontWeight(.semibold)
                    .padding(.vertical,30)
                
                
                
                Image("illustrate")
                    .resizable()
                    .padding(.top,30)
                    .scaledToFill()
                    .frame(width: 200, height: 200)
                
                Button  {
                    print("SignOut!!")
                    do {
                        try AuthManager.shared.signOut()
                        loginSuccess = true
                    } catch {
                        print("Error signing out:", error)
                    }
                } label: {
                    Text("Sign Out")
                        .font(.headline)
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                        .frame(height:55)
                        .frame(maxWidth: .infinity)
                        .background(Color("button-color").cornerRadius(10.0))
                        .padding()
                    
                }
                
            }
            
        }
        
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
        
        Color.clear.edgesIgnoringSafeArea(.all)
        NavigationLink(
            destination: ContentView(),
            isActive: $loginSuccess,
            label: {
                EmptyView()
            })
            .hidden()
    }
}

struct LoginSuccess_Previews: PreviewProvider {
    static var previews: some View {
        LoginSuccess()
    }
}
