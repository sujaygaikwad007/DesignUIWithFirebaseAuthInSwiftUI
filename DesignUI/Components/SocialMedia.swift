//
//  SocialMedia.swift
//  DesignUI
//
//  Created by Aniket Patil on 14/05/24.
//

import SwiftUI
import AuthenticationServices

struct SocialMedia: View {
    // Define an array of social media platforms
    let platforms = [
        ("facebook", "facebook-app"),
        ("apple", "apple-app"),
        ("google-plus", "google-plus-app")
    ]
    
    
    @StateObject private var gooogleViewModel = GoogleSignInAuthHelper()
    @StateObject private var appleViewModel = AppleSignInAuthHelper()
    @State  var loginSuccess = false
    @State private var loggedUserName: String = ""

    
    
    var body: some View {
        
        HStack(spacing: 20) {
            ForEach(platforms, id: \.0) { platform, image in
                Button(action: {
                    // Add action here
                    switch platform {
                    case "facebook":
                        print("Facebook button tapped")
                    case "apple":
                        Task{
                            do{
                                try await appleViewModel.appleSignIn()
                                
                            }
                            catch{
                                print(error)
                            }
                        }
                        
                        print("Apple button tapped")
                    case "google-plus":
                        
                        Task {
                                do {
                                    try await gooogleViewModel.GogleSignIn { name in
                                        if let name = name {
                                            self.loginSuccess = true
                                            self.loggedUserName = name
                                        }
                                    }
                                } catch {
                                    print(error)
                                }
                            }

                        
                        print("Google Plus button tapped")
                    default:
                        break
                    }
                }) {
                    Circle()
                        .fill(Color(platform))
                        .frame(width: 60, height: 60)
                        .overlay(
                            Image(image)
                                .resizable()
                                .scaledToFill()
                                .frame(width: 30, height: 30,alignment: .center)
                        )
                }
            }
        }
        
        .padding(.vertical, 20)
        
        .onChange(of: appleViewModel.didSignWithApple) { newValue in
            if newValue {
                self.loginSuccess = true
            }
        }
        
        NavigationLink(
            destination: LoginSuccess(loggedUserName: self.loggedUserName),
            isActive: $loginSuccess,
            label: {
                EmptyView()
            })
            .hidden()
    }
}

struct SocialMedia_Previews: PreviewProvider {
    static var previews: some View {
        SocialMedia()
    }
}
