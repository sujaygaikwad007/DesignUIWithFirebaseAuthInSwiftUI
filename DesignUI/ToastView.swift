//
//  ToastView.swift
//  DesignUI
//
//  Created by Aniket Patil on 15/05/24.
//

import SwiftUI

struct ToastView: View {
    let message: String
    @Binding var isPresented: Bool
    
    var body: some View {
        VStack {
            Text(message)
                .padding()
                .foregroundColor(.white)
                .background(Color.red)
                .cornerRadius(10)
                .shadow(radius: 5)
                .transition(.move(edge: .top))
                .animation(.easeInOut)
                .onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                        withAnimation {
                            isPresented = false
                        }
                    }
                }
        }
        .padding(.horizontal)
        .padding(.top, UIApplication.shared.windows.first?.safeAreaInsets.top)
        .frame(maxWidth: .infinity, alignment: .top)
        .background(
            Color.black.opacity(0.001)
                .onTapGesture {
                    withAnimation {
                        isPresented = false
                    }
                }
        )
    }
}


