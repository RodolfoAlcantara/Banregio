//
//  LoginService.swift
//  Banregio
//
//  Created by Benjamin on 03/01/18.
//  Copyright © 2018 rodolfo. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class LoginService {
    
    static func login(user: String, password: String, callback: @escaping (Bool) -> Void) {
        let headers = URLService.getHeaders()
        let error : String = "Error al intentar conectar con el servidor"
        var status = Bool()
        
        Alamofire.request(URLService.URL_LOGIN, method: .get, headers: headers).responseJSON{
            response in
            
            
            //print("Request: \(String(describing: response.request))")
            //print("Response: \(String(describing: response.response))")
            //print("Result: \(response.result)")
            
            guard let respValue = response.result.value else {
                print(error)
                status = false
                callback(status)
                return 
            }
            
            let json = JSON( respValue )
            
            if user == json["correo"].string && password == json["password"].string{
                    status = true
                    UserDefaults.standard.set(json["correo"].string, forKey: "nombre")
                    callback(status)
            } else {
                    status = false
                    callback(status)
            }
            
        }
        
    }
    
    
}
