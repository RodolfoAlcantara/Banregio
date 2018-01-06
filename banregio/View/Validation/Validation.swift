//
//  Validation.swift
//  Banregio
//
//  Created by Benjamin on 03/01/18.
//  Copyright © 2018 rodolfo. All rights reserved.
//

import UIKit
import Foundation

class Validation{
    class func isNotEmptyField(_ testStr: String) -> Bool {
        if testStr.count == 0 || testStr == "" || testStr == "\n" {
            return false
        }
        return true
    }
    
    
    class func isValidEmail(_ testStr: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        let result = emailTest.evaluate(with: testStr)
        return result
    }
    
    class func showPassword(isHide: Bool, textField: UITextField, button: UIButton) -> Bool{
        if(isHide == true) {
            textField.isSecureTextEntry = false
            button.setImage(UIImage(named: "verContrasenaOn"), for: .normal)
            return false
        } else {
            textField.isSecureTextEntry = true
            button.setImage(UIImage(named: "verContrasenaOff"), for: .normal)
            return true
        }
    }
    
    
}
