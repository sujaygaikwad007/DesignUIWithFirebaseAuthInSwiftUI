//
//  CustomTextField.swift
//  DesignUI
//
//  Created by Aniket Patil on 15/05/24.
//

import SwiftUI

struct CustomTextField: View {
    
    @Binding var text: String
    var placeholder: String
    var keyboardType: UIKeyboardType
    
    var body: some View {
        
        TextField(placeholder, text: $text)
            .keyboardType(keyboardType)
            .foregroundColor(.black)
            .padding()
            .background(Color.white)
            .cornerRadius(10)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.gray, lineWidth: 0.2)
            )
        

        
    }
}

struct CustomTextField_Previews: PreviewProvider {
    @State static var text: String = ""
    
    static var previews: some View {
        CustomTextField(text: $text, placeholder: "Placeholder", keyboardType: .default)
    }
}
