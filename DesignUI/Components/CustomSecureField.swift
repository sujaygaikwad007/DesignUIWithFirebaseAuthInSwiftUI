//
//  CustomSecureField.swift
//  DesignUI
//
//  Created by Aniket Patil on 15/05/24.
//

import SwiftUI

struct CustomSecureField: View {
    
    @Binding var text: String
    var placeholder: String
    @Binding var isSecure: Bool
    
    var body: some View {
        ZStack(alignment: .trailing) {
            if isSecure {
                SecureField(placeholder, text: $text)
                    .foregroundColor(.black)
                    .padding(.leading)
                    .padding(.vertical)
                    .background(Color.white)
                    .cornerRadius(10)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.gray, lineWidth: 0.2)
                    )
            } else {
                TextField(placeholder, text: $text)
                    .foregroundColor(.black)
                    .padding(.leading)
                    .padding(.vertical)
                    .background(Color.white)
                    .cornerRadius(10)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.gray, lineWidth: 0.2)
                    )
            }
            Button(action: {
                isSecure.toggle()
            }) {
                Image(systemName: isSecure ? "eye.slash" : "eye")
                    .padding(.trailing, 8)
                    .foregroundColor(.gray)
            }
        }
    }
    
    
    
    
}


struct CustomSecureField_Previews: PreviewProvider {
    @State static var text: String = ""
    @State static var isSecure: Bool = true 
    
    static var previews: some View {
        CustomSecureField(text: $text, placeholder: "Password", isSecure: $isSecure)
    }
}
