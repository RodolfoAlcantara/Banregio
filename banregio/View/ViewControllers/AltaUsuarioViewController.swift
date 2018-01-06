//
//  AltaUsuarioViewController.swift
//  Banregio
//
//  Created by Benjamin on 02/01/18.
//  Copyright © 2018 rodolfo. All rights reserved.
//

import UIKit
import CoreData

class AltaUsuarioViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate{

    //Datepicker
    let picker = UIDatePicker()
    
    // Outlets
    @IBOutlet weak var perfilImageView: UIImageView!
    @IBOutlet weak var seleccionarButton: UIButton!
    @IBOutlet weak var nombreTF: UITextField!
    @IBOutlet weak var apellidosTF: UITextField!
    @IBOutlet weak var calendarioTF: UITextField!
    @IBOutlet weak var direccionTF: UITextField!
    @IBOutlet weak var guardarButton: UIButton!
    
    
    @IBAction func seleccionarImagen(_ sender: Any) {
        
        //Create the image picker
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = UIImagePickerControllerSourceType.photoLibrary
        
        //Display the image picker
        self.present(imagePicker, animated: true, completion: nil)
        
    }
    
    @IBAction func guardarUsuario(_ sender: Any) {
        print("guardar presioando")
        
        if nombreTF.text == "" || apellidosTF.text == "" || calendarioTF.text == "" || direccionTF.text == "" {
            Alert.createAlert(titulo: "Campos vacios", mensaje: "Por favor rellena todos los campos marcados", vista: self)
        }
        
        //Core data usage
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let newUser = NSEntityDescription.insertNewObject(forEntityName: "Users", into: context)
        newUser.setValue(nombreTF.text!, forKey:"nombre")
        newUser.setValue(apellidosTF.text!, forKey:"apellido")
        newUser.setValue(direccionTF.text!, forKey:"direccion")
        newUser.setValue(calendarioTF.text!, forKey:"fechaNacimiento")
        
        // image to Base64 String
        let imageData = UIImagePNGRepresentation(perfilImageView.image!)
        let strBase64 = imageData?.base64EncodedString(options: .lineLength64Characters)
        
        newUser.setValue(strBase64, forKey: "imagen")
        
        do {
            try context.save()
            Alert.createAlert(titulo: "Usuario dado de alta", mensaje: "El usuario \(nombreTF.text!) \(apellidosTF.text!) se ha dado de alta :)", vista: self)
            
            nombreTF.text = ""
            apellidosTF.text = ""
            direccionTF.text = ""
            calendarioTF.text = ""
            perfilImageView.image = UIImage(named: "perfil")
            
        } catch {
            Alert.createAlert(titulo: "Ha ocurrido un error", mensaje: "No hemos podido dar de alta a este usuario :( ", vista: self)
        }
        
    }
    
    //Pick and set image
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            perfilImageView.image = image
            
            // Close the picker
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareElements()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    func prepareElements(){

        VisualFX.setBottomBorder(textFields: nombreTF, color: UIColor.white)
        VisualFX.setBottomBorder(textFields: apellidosTF, color: UIColor.white)
        VisualFX.setBottomBorder(textFields: calendarioTF, color: UIColor.white)
        VisualFX.setBottomBorder(textFields: direccionTF, color: UIColor.white)
        
        let border = CALayer()
        let width = CGFloat(2.0)
        border.borderColor = UIColor.white.cgColor
        border.frame = CGRect(x: 0, y: nombreTF.frame.size.height - width, width:  nombreTF.frame.size.width, height: nombreTF.frame.size.height)
        
        border.borderWidth = width
        nombreTF.layer.addSublayer(border)
        nombreTF.layer.masksToBounds = true
        

        nombreTF.attributedPlaceholder = NSAttributedString(string: "Nombre",
                                                          attributes: [NSAttributedStringKey.foregroundColor: UIColor.white])
        apellidosTF.attributedPlaceholder = NSAttributedString(string: "Apellidos",
                                                            attributes: [NSAttributedStringKey.foregroundColor: UIColor.white])
        direccionTF.attributedPlaceholder = NSAttributedString(string: "Direccion",
                                                            attributes: [NSAttributedStringKey.foregroundColor: UIColor.white])
        calendarioTF.attributedPlaceholder = NSAttributedString(string: "Fecha de nacimiento",
                                                            attributes: [NSAttributedStringKey.foregroundColor: UIColor.white])
        
        guardarButton.layer.cornerRadius = 8
        seleccionarButton.layer.cornerRadius = 11
        
        
        // Picker
        createDatePicker()
        
        //Keyboard notification
        NotificationCenter.default.addObserver( self, selector: #selector( AltaUsuarioViewController.keyboardWillShow ), name: NSNotification.Name.UIKeyboardWillShow, object: nil )
        NotificationCenter.default.addObserver( self, selector: #selector( AltaUsuarioViewController.keyboardWillHide ), name: NSNotification.Name.UIKeyboardWillHide, object: nil )
    }
    
    
    @objc func keyboardWillShow( notification: NSNotification ) {
        
        // To move the view for each text field is editing
        if nombreTF.isEditing {
            self.view.frame.origin.y = -50
        } else if apellidosTF.isEditing {
            self.view.frame.origin.y = -100
        } else if calendarioTF.isEditing {
            self.view.frame.origin.y = -170
        } else if direccionTF.isEditing {
            self.view.frame.origin.y = -210
        } else {}
    }
    
    
    @objc func keyboardWillHide(notification: NSNotification) {
        self.view.frame.origin.y = 0
    }
    
    func createAlert(titleAlert: String, messageAlert: String){
        let alert = UIAlertController(title: titleAlert, message: messageAlert, preferredStyle: UIAlertControllerStyle.alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: {(action) in }))
        self.present(alert, animated: true, completion: nil)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        // To hide Keyboard
        let tap: UITapGestureRecognizer = UITapGestureRecognizer( target: self, action: #selector( self.dismissKeyboard ) )
        view.addGestureRecognizer( tap )
    }
    
    @objc func dismissKeyboard() {
        view.endEditing( true )
    }
    
    func createDatePicker() {
    
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let done = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(donePressed))
        toolbar.setItems([done], animated: false)
        calendarioTF.inputAccessoryView = toolbar
        calendarioTF.inputView = picker
        picker.datePickerMode = .date
    }
    
    @objc func donePressed() {
        // format date
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        let dateString = formatter.string(from: picker.date)
        
        calendarioTF.text = "\(dateString)"
        self.view.endEditing(true)
    }
    
    
}
