//
//  SucursalesService.swift
//  banregio
//
//  Created by Benjamin on 05/01/18.
//  Copyright © 2018 rodo. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class SucursalesService {
    
    class func getSucursales(callback: @escaping ([SucursalModel]) -> Void){
        let headers = URLService.getHeaders()
        let error : String = "Error al intentar conectar con el servidor"
        var sucursales = [SucursalModel]()
        
        Alamofire.request(URLService.URL_SUCURSALES, method: .get, headers: headers).responseJSON{
            response in
            
            //print("Request: \(String(describing: response.request))")
            //print("Response: \(String(describing: response.response))")
            //print("Result: \(response.result)")
            
            
            
            guard let respValue = response.result.value else {
                print(error)
                return
            }
            
            let json = JSON(respValue).array
            
            for sucursal in json! {
                let sucursalObject : SucursalModel = SucursalModel(json: sucursal)
                sucursales.append(sucursalObject)
            }
            
            callback(sucursales)
            
            
        }
    }
    
    
}
