//
//  URLServices.swift
//  Banregio
//
//  Created by Benjamin on 03/01/18.
//  Copyright © 2018 rodolfo. All rights reserved.
//

import Foundation
import Alamofire

class URLService {
    static let NAME_SERVER = "json.banregio.io"
    static let HTTP = "http://"
    static let M_POST = "post"
    static let M_GET = "get"
    
    //Web services
    static let URL_LOGIN = HTTP + NAME_SERVER + "/login"
    static let URL_SUCURSALES = HTTP + NAME_SERVER + "/sucursales"
    
    
    //Obtención de headers
    class func getHeaders() -> HTTPHeaders {
        var headers : HTTPHeaders = [:]
        
        if let authorizationHeader = Request.authorizationHeader(user: "", password: "") {
            headers[authorizationHeader.key] = authorizationHeader.value
        }
        
        return headers
    }
}
