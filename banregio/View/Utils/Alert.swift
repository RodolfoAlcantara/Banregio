//
//  Alert.swift
//  banregio
//
//  Created by Benjamin on 04/01/18.
//  Copyright © 2018 rodo. All rights reserved.
//

import Foundation
import UIKit

class Alert {
    static private var alerta : UIAlertController? = nil
    
    class func createAlert( titulo: String, mensaje: String, vista: UIViewController ) {
        alerta = UIAlertController( title: titulo, message: mensaje, preferredStyle: UIAlertControllerStyle.alert )
        
        alerta!.addAction( UIAlertAction( title: "OK", style: UIAlertActionStyle.default, handler: nil ) )
        
        vista.present( alerta!, animated: true, completion: nil )
    }
    
    class func createAlertAction( titulo: String, mensaje: String, vista: UIViewController, accion : UIAlertAction ) {
        alerta = UIAlertController( title: titulo, message: mensaje, preferredStyle: UIAlertControllerStyle.alert )
        
        alerta!.addAction( accion )
        
        vista.present( alerta!, animated: true, completion: nil )
    }
    
    class func addAction( accion : UIAlertAction ) {
        self.alerta?.addAction( accion )
    }
}
