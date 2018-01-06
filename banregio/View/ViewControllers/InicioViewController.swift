//
//  InicioViewController.swift
//  Banregio
//
//  Created by Benjamin on 02/01/18.
//  Copyright © 2018 rodolfo. All rights reserved.
//

import UIKit


class InicioViewController: UIViewController {
    
    // Auxiliar variables
    var hidePassword = true
    
    // Outlets
    @IBOutlet weak var correoTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var correoLabel: UILabel!
    @IBOutlet weak var ingresarButton: UIButton!
    @IBOutlet weak var sucursal: UIButton!
    
    @IBAction func sucursalAction(_ sender: Any) {
        print("Sucursal")
    }
    
    @IBAction func ingresar(_ sender: Any) {
        print("Ingresar presionado")
        
        if correoTF.text == "" || passwordTF.text == "" {
           Alert.createAlert(titulo: "Campos vacios", mensaje: "Por favor rellena todos los campos marcados", vista: self)
        }
        
        LoginService.login(user: correoTF.text!, password: passwordTF.text!, callback: {
            status in
    
            if status {
                //Present the tutorial
                let storyboard = UIStoryboard( name: "Main", bundle: nil )
                let vistaInicio = storyboard.instantiateViewController(withIdentifier: "PageViewController")
                self.present( vistaInicio, animated: true, completion: nil )
            } else {
                Alert.createAlert(titulo: "Datos incorrectos", mensaje: "Por favor revisa tu información", vista: self)
            }
            
        })
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        prepareElements()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        // To hide Keyboard
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard ))
        view.addGestureRecognizer(tap)
        
        if !CheckConnection.isConnectedToInternet() {
            Alert.createAlert(titulo: "Datos celulares desactivados", mensaje: "Para realizar esta acción activa los datos celulares o usa Wi-fi", vista: self)
        }
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
  

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func prepareElements(){
        ingresarButton.layer.cornerRadius = 8
        sucursal.layer.cornerRadius = 9
    }
    
    
}
