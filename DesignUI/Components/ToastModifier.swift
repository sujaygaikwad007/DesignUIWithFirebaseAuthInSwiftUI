//
//  ToastModifier.swift
//  DesignUI
//
//  Created by Aniket Patil on 15/05/24.
//

import SwiftUI

struct ToastModifier: ViewModifier {
    @Binding var isPresented: Bool
    let message: String
    
    func body(content: Content) -> some View {
        content
            .overlay(
                VStack {
                    if isPresented {
                        Text(message)
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.black.opacity(0.75))
                            .cornerRadius(10)
                    }
                }
                .padding(.horizontal, 30)
                .transition(.opacity)
                .animation(.easeInOut)
            )
    }
}
