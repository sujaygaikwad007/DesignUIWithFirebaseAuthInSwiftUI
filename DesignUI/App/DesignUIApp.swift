//
//  DesignUIApp.swift
//  DesignUI
//
//  Created by Aniket Patil on 14/05/24.
//

import SwiftUI
import Firebase
import GoogleSignIn

@main
struct DesignUIApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    var body: some Scene {
        WindowGroup {
            NavigationView{
                ContentView()
                
            }
            
        }
    }
}


class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()
      print("Firebase Success!!")

    return true
  }
}
