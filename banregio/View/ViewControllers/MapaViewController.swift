//
//  MapaViewController.swift
//  banregio
//
//  Created by Benjamin on 05/01/18.
//  Copyright © 2018 rodo. All rights reserved.
//

import UIKit
import MapKit

class MapaViewController: UIViewController, UISearchBarDelegate{

    // Outlets
    @IBOutlet weak var map: MKMapView!
    @IBOutlet weak var buscarButton: UIButton!
    @IBOutlet weak var regresarButton: UIButton!
    
    // Auxiliar places
    var list = [String]()
    var lat = [Float]()
    var long = [Float]()
    
    //Auxiliar to show only one place
    var status = false
    var latitudeObject: Float?
    var longitudeObject: Float?
    var nameObject: String?
    
    @IBAction func buscarAction(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let busqueda = storyboard.instantiateViewController(withIdentifier: "NormalViewController") as! TableSearchViewController
        busqueda.list = list
        busqueda.latitude = lat
        busqueda.longitude = long
        self.show(busqueda, sender: self)
    }
    
    @IBAction func regresarAction(_ sender: Any) {
        print("regresar presed")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        list.removeAll()
        lat.removeAll()
        long.removeAll()
        
        //Setting points
        SucursalesService.getSucursales(callback:{
            sucursales in
            
            for item in sucursales {
                Map.setPoint(item: item, map: self.map)
                self.list.append(item.domicilio)
                self.lat.append(item.latitud)
                self.long.append(item.longitud)
            }
        })
        
        prepareElements()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if status {
            
            //Getting data
            let latitude = latitudeObject
            let longitude = longitudeObject
            
            //Zooming in on annotation
            let coordinate: CLLocationCoordinate2D = CLLocationCoordinate2DMake(CLLocationDegrees(latitude!), CLLocationDegrees(longitude!))
            let span = MKCoordinateSpanMake(0.1, 0.1)
            let region = MKCoordinateRegionMake(coordinate, span)
            self.map.setRegion(region, animated: true)
            
            status = false
        } else {
            
            list.removeAll()
            lat.removeAll()
            long.removeAll()
            
            //Setting points
            SucursalesService.getSucursales(callback:{
                sucursales in
                
                for item in sucursales {
                    Map.setPoint(item: item, map: self.map)
                    self.list.append(item.domicilio)
                    self.lat.append(item.latitud)
                    self.long.append(item.longitud)
                }
            })
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        //Ingnoring user
        UIApplication.shared.beginIgnoringInteractionEvents()
        
        //Activity Indicatior
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
        activityIndicator.center = self.view.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.startAnimating()
        
        self.view.addSubview(activityIndicator)
        
        //Hide search bar
        searchBar.resignFirstResponder()
        dismiss(animated: true, completion: nil)
        
        //Create the search request
        let searchRequest = MKLocalSearchRequest()
        searchRequest.naturalLanguageQuery = searchBar.text
        let activeSearch = MKLocalSearch(request: searchRequest)
        activeSearch.start { (response, error) in
            
            activityIndicator.stopAnimating()
            UIApplication.shared.endIgnoringInteractionEvents()
            
            if response ==  nil{
                print("Error")
            } else {
                
                
                //Getting data
                let latitude = response?.boundingRegion.center.latitude
                let longitude = response?.boundingRegion.center.longitude
                
                //Create annotation
                let annotation = MKPointAnnotation()
                annotation.title = searchBar.text
                annotation.coordinate = CLLocationCoordinate2DMake(latitude!, longitude!)
                self.map.addAnnotation(annotation)
                
                //Zooming in on annotation
                let coordinate: CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude!, longitude!)
                let span = MKCoordinateSpanMake(0.1, 0.1)
                let region = MKCoordinateRegionMake(coordinate, span)
                self.map.setRegion(region, animated: true)
            }
            
            
        }
    }
    
    func prepareElements(){
        buscarButton.layer.cornerRadius = 9
        regresarButton.layer.cornerRadius = 9
    }

}
