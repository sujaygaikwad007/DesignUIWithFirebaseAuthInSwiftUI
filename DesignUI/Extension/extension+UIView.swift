//
//  extension+UIView.swift
//  DesignUI
//
//  Created by Aniket Patil on 14/05/24.
//

import Foundation
import SwiftUI

extension View {
    

    //Custom Toast
    func customToast(isPresented: Binding<Bool>, message: String) -> some View {
        self.modifier(ToastModifier(isPresented: isPresented, message: message))
    }
    
    //Hide keyboard
    func hideKeyboardOnTap() -> some View {
        self.onTapGesture {
            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
        }
    }
 
}
