//
//  MainViewController.swift
//  Banregio
//
//  Created by Benjamin on 02/01/18.
//  Copyright © 2018 rodolfo. All rights reserved.
//

import UIKit
import CoreData

class MainViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    
    
    //results
    var users = [UsuarioModel]()
    
    // Auxiliar var
    var stateMenu = false
    
    // Pull to refresh
    var refresher: UIRefreshControl!
    
    // Outlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var menuView: UIView!
    @IBOutlet weak var menuTrailingConstraint: NSLayoutConstraint!
    @IBOutlet weak var conatinerCell: UIView!
    @IBOutlet weak var nombreMenuLabel: UILabel!
    
    @IBAction func hamburgerMenuItemBar(_ sender: Any) {
        stateMenu = Menu.actionMenu(estadoDelMenu: stateMenu, constraint: menuTrailingConstraint, view: self.view)
    }
    
    @IBAction func altaUsuario(_ sender: Any) {
        stateMenu = Menu.actionMenu(estadoDelMenu: stateMenu, constraint: menuTrailingConstraint, view: self.view)
    }
    
    @IBAction func cerrarSesion(_ sender: Any) {
        
        //Delete Name
        UserDefaults.standard.removeObject(forKey: "nombre")
        
        let vistaInicio = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "InicioViewController") as! InicioViewController
        self.present( vistaInicio, animated: true, completion: nil )
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareElements()
        getDataUsers()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getDataUsers()
        tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    
    func getDataUsers(){
        // Setting coreData
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Users")
        request.returnsObjectsAsFaults = false
        
        //Clean array
        users.removeAll()
        
        do{
            let results = try context.fetch(request)
            if results.count > 0 {
                for result in results as! [NSManagedObject] {
                    
                    //Create and append objects from CoreData
                    //let testUser = UsuarioModel(nombre: "Rodolfo", apellido: "Alcantara", direccion: "Esquina 2", fechaNacimiento: "10-10-10", img: "dkjsniousfd")
                    
                    let nombreUsuario = result.value(forKey: "nombre") as! String
                    let apellidoUsuario = result.value(forKey: "apellido") as! String
                    let direccionUsuario = result.value(forKey: "direccion") as! String
                    let fechaUsuario = result.value(forKey: "fechaNacimiento") as! String
                    let imagenUsuario = result.value(forKey: "imagen") as! String
                    
                    let userModel = UsuarioModel(nombre: nombreUsuario, apellido: apellidoUsuario, direccion: direccionUsuario, fechaNacimiento: fechaUsuario, img: imagenUsuario)
                    
                    users.append(userModel)
                }
            } 
        } catch {
            Alert.createAlert(titulo: "No tenemos usuarios registrados", mensaje: "Puedes registrar uno en la sección Alta de usuarios", vista: self)
        }
        
        print(users.count)
    }
    
    func prepareElements(){
        //First view hide menu
        Menu.hidedMenu(constraintMenu: menuTrailingConstraint)
        Menu.shadowed(viewShadowed: menuView, width: -1, height: 10, op: 1, radius: 5)
        
        // Style clear for TableView
        tableView.backgroundColor = UIColor.clear
        tableView.separatorStyle = .none
        
        //Pull to refresh
        refresher = UIRefreshControl()
        refresher.attributedTitle = NSAttributedString(string: " ")
        refresher.addTarget(self, action: #selector(self.refreshData), for: UIControlEvents.valueChanged)
        tableView.addSubview(refresher)
        self.refresher.tintColor = UIColor.white
        self.refresher.backgroundColor = UIColor.clear
        
        //Get the name
        let name = UserDefaults.standard.string(forKey: "nombre")
        nombreMenuLabel.text = name
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! UsuarioTableViewCell
        
        //style
        //cell.layer.cornerRadius = 8
        cell.selectionStyle = .none
        cell.backgroundColor = UIColor.clear
        cell.containerView.layer.cornerRadius = 8
        
        //Data
        cell.fechaUsuario.text = users[indexPath.row].fechaNacimiento
        cell.nombreUsuario.text = "\(users[indexPath.row].nombre) \(users[indexPath.row].apellido) "
        cell.direccionUsuario.text = users[indexPath.row].direccion
        
        //Base64 to Image
        let dataDecoded : Data = Data(base64Encoded: users[indexPath.row].img , options: .ignoreUnknownCharacters)!
        let decodedimage = UIImage(data: dataDecoded)
        cell.imagenUsuario.image = decodedimage
        
        return cell
    }
    
    @objc func refreshData(){
        print("Refreshed")
        
        //Delay 1 second
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
            self.refresher.endRefreshing()
        }
    }
    
}
