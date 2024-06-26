//
//  GoogleSignInAuth.swift
//  DesignUI
//
//  Created by Aniket Patil on 16/05/24.
//

import Foundation
import GoogleSignIn
import GoogleSignInSwift
import FirebaseAuth


struct GoogleSignInResultModel{
    let idToken:String
    let accessToken:String
    let name: String?
    let surname: String?
    
    init(idToken: String, accessToken: String, name: String?, surname: String?) {
        self.idToken = idToken
        self.accessToken = accessToken
        self.name = name
        self.surname = surname
    }
}


final class GoogleSignInAuthHelper: ObservableObject {
    
    @MainActor
    func GogleSignIn(completion: @escaping (String?) -> Void) async throws {
        
        guard let topVc = await Utilities.topViewController() else {
            completion(nil)
            throw URLError(.cannotFindHost)
        }
        
        let gidSignInResult = try await GIDSignIn.sharedInstance.signIn(withPresenting: topVc)
        
        guard let idToken = gidSignInResult.user.idToken?.tokenString else {
            throw URLError(.badServerResponse)
        }
        
        let accessToken = gidSignInResult.user.accessToken.tokenString
        let name = gidSignInResult.user.profile?.name
        let surname = gidSignInResult.user.profile?.familyName
        
        let tokens = GoogleSignInResultModel(idToken: idToken, accessToken: accessToken, name: name, surname: surname)
        try await AuthManager.shared.signInWithGoogle(tokens: tokens)
        completion(name) 
        
        if let name = name, let surname = surname {
            print("Name: \(name), Surname: \(surname)")
        } else {
            print("Name and/or Surname not provided by Google.")
        }
        
        
    }
    
}
