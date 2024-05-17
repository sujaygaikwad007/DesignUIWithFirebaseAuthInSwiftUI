//
//  extension+Validation.swift
//  DesignUI
//
//  Created by Aniket Patil on 14/05/24.
//

import Foundation

extension String {
   
    var isValidEmail: Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,3}"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: self)
    }
    
    var isValidPassword: Bool {
        
        let passwordRegEx = NSPredicate(format: "SELF MATCHES %@", "^(?=.*[a-zA-Z])(?=.*[$@#!%*?&])[A-Za-z\\d$@$#!%*?&]{6,10}$")
        return passwordRegEx.evaluate(with: self)
    }


}


