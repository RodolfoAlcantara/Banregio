//
//  UsuarioModel.swift
//  banregio
//
//  Created by Benjamin on 04/01/18.
//  Copyright © 2018 rodo. All rights reserved.
//

import UIKit

class UsuarioModel: NSObject {
    private var _nombre: String?
    private var _apellido: String?
    private var _direccion: String?
    private var _fechaNacimiento: String?
    private var _img: String?
    
    init(nombre: String, apellido: String, direccion: String, fechaNacimiento: String, img: String){
            self._nombre = nombre
            self._apellido = apellido
            self._direccion = direccion
            self._fechaNacimiento = fechaNacimiento
            self._img = img
    }
    
    var nombre : String {
        get {
            return self._nombre!
        }
        
        set {
            self._nombre = newValue
        }
    }
    
    var apellido : String {
        get {
            return self._apellido!
        }
        
        set {
            self._apellido = newValue
        }
    }
    
    
    var direccion : String {
        get {
            return self._direccion!
        }
        
        set {
            self._direccion = newValue
        }
    }
    
    var fechaNacimiento : String {
        get {
            return self._fechaNacimiento!
        }
        
        set {
            self._fechaNacimiento = newValue
        }
    }
    
    var img : String {
        get {
            return self._img!
        }
        
        set {
            self._img = newValue
        }
    }
    
    
}
