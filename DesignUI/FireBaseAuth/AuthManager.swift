//
//  AuthManager.swift
//  DesignUI
//
//  Created by Aniket Patil on 16/05/24.
//

import FirebaseAuth
import GoogleSignIn
import GoogleSignInSwift
import AuthenticationServices


struct AuthDataResultModel {
    let uid : String?
    let email : String?
    
    init(user:User){
        
        self.uid = user.uid
        self.email = user.email
        
    }
}

import FirebaseAuth

final class AuthManager {
    
    static let shared = AuthManager()
    private init() {}
    
    
    // Sign In With Email and Password
    func signInWithEmail(email: String, password: String) async throws -> AuthDataResultModel {
        let authDataResult = try await Auth.auth().signIn(withEmail: email, password: password)
        return AuthDataResultModel(user: authDataResult.user)
    }
    
    // Sign Up With Email and Password
    func signUpWithEmail(email: String, password: String) async throws -> AuthDataResultModel {
        let authDataResult = try await Auth.auth().createUser(withEmail: email, password: password)
        return AuthDataResultModel(user: authDataResult.user)
    }
    
    
    
    
    //Sign In With Google
    func signInWithGoogle(tokens: GoogleSignInResultModel) async throws -> AuthDataResultModel {
        let credential = GoogleAuthProvider.credential(withIDToken: tokens.idToken, accessToken: tokens.accessToken)
        
        return try await signInWithCredential(credential: credential)
    }
    
    //Sign In With Apple
    func signInWithApple(tokens: AppleSignInResultModel) async throws -> AuthDataResultModel {
        let credential = OAuthProvider.credential(withProviderID: "apple.com", idToken: tokens.token, rawNonce: tokens.nonce)
        return try await signInWithCredential(credential: credential)
    }
    
    private func signInWithCredential(credential: AuthCredential) async throws -> AuthDataResultModel {
        let authDataResult = try await Auth.auth().signIn(with: credential)
        return AuthDataResultModel(user: authDataResult.user)
    }
    
    //Reset password
    func sendPasswordResetEmail(email: String) async throws {
        try await Auth.auth().sendPasswordReset(withEmail: email)
    }
    
    
    //Sign Out
    func signOut() throws {
        try Auth.auth().signOut()
    }
}
