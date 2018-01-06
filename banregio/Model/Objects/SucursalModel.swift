//
//  SucursalModel.swift
//  banregio
//
//  Created by Benjamin on 05/01/18.
//  Copyright © 2018 rodo. All rights reserved.
//

import Foundation
import SwiftyJSON

class SucursalModel: NSObject {
    private var _ciudad: String?
    private var _domicilio: String?
    private var _telefonoPortal: String?
    private var _vcHoras: String?
    private var _estado: String?
    private var _id: String?
    private var _sabados: String?
    private var _nombre: String?
    private var _latitud: Float?
    private var _longitud: Float?
    private var _horario: String?
    
    
    init(json: JSON){
        self._ciudad = json["CIUDAD"].stringValue
        self._domicilio = json["DOMICILIO"].stringValue
        self._telefonoPortal = json["TELEFONO_PORTAL"].stringValue
        self._vcHoras = json["24_HORAS"].stringValue
        self._estado = json["ESTADO"].stringValue
        self._id = json["ID"].stringValue
        self._sabados = json["SABADOS"].stringValue
        self._nombre = json["NOMBRE"].stringValue
        self._latitud = json["Latitud"].floatValue
        self._longitud = json["Longitud"].floatValue
        self._horario = json["HORARIO"].stringValue
    }
    
    var ciudad  : String {
        get {
            return self._ciudad!
        }
        
        set {
            _ciudad = newValue
        }
    }
    
    var domicilio  : String {
        get {
            return self._domicilio!
        }
        
        set {
            _domicilio = newValue
        }
    }
    
    var telefonoPortal  : String {
        get {
            return self._telefonoPortal!
        }
        
        set {
            _telefonoPortal = newValue
        }
    }
    
    var vcHoras : String {
        get {
            return self._vcHoras!
        }
        
        set {
            _vcHoras = newValue
        }
    }
    
    var estado  : String {
        get {
            return self._estado!
        }
        
        set {
            _estado = newValue
        }
    }
    
    var id  : String {
        get {
            return self._id!
        }
        
        set {
            _id = newValue
        }
    }
    
    var sabados  : String {
        get {
            return self._sabados!
        }
        
        set {
            _sabados = newValue
        }
    }
    
    var nombre  : String {
        get {
            return self._nombre!
        }
        
        set {
            _nombre = newValue
        }
    }
    
    var latitud  : Float {
        get {
            return self._latitud!
        }
        
        set {
            _latitud = newValue
        }
    }
    
    var longitud  : Float {
        get {
            return self._longitud!
        }
        
        set {
            _longitud = newValue
        }
    }
    
    var horario  : String {
        get {
            return self._horario!
        }
        
        set {
            _horario = newValue
        }
    }
    
}
