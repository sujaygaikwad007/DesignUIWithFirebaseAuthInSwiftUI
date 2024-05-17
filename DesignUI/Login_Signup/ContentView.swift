//
//  ContentView.swift
//  DesignUI
//
//  Created by Aniket Patil on 14/05/24.
// Bundle Id: Reapmind.DesignUI


import SwiftUI

struct ContentView: View {
    // Constants
    let primaryColor = Color("button-color")
    let logoSize: CGFloat = 150
    let illustrateSize: CGFloat = 200
    let paddingValue: CGFloat = 10
    
    var body: some View {
        ScrollView {
            VStack {
                Image("Logo")
                    .resizable()
                    .scaledToFill()
                    .frame(width: logoSize, height: logoSize)
                    .padding(.top, 0)
                
                Image("illustrate")
                    .resizable()
                    .scaledToFill()
                    .frame(width: illustrateSize, height: illustrateSize)
                    .padding(.top, paddingValue)
                
                Text("Welcome")
                    .font(.largeTitle)
                    .fontWeight(.semibold)
                    .padding(.top, 50)
                
                Text("Create an account and access thousand of cool stuffs")
                    .font(.subheadline)
                    .foregroundColor(.gray)
                    .multilineTextAlignment(.center)
                    .padding(.top, 1)
                    .padding(.horizontal, 40)
                    .padding(.bottom,80)
                
                NavigationLink(destination: LoginScreen(email: "", password:"")) {
                    Text("Getting Started")
                        .font(.headline)
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                        .padding(.vertical, 20)
                        .frame(maxWidth: .infinity)
                        .background(primaryColor.cornerRadius(10))
                        .padding(.horizontal, 10)
                }
                
                HStack {
                    Text("Already have an account?")
                        .font(.headline)
                        .foregroundColor(Color.gray)
                    
                    NavigationLink(destination: LoginScreen(email: "", password: "")) {
                        Text("Log In")
                            .foregroundColor(primaryColor)
                    }
                }
                .padding(.vertical, 5)
            }
            .background(Color.white)
            .padding()
        }
        .background(Color.white.edgesIgnoringSafeArea(.all))
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
