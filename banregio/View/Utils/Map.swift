//
//  Map.swift
//  banregio
//
//  Created by Benjamin on 05/01/18.
//  Copyright © 2018 rodo. All rights reserved.
//

import Foundation
import MapKit
import UIKit

class Map {
    class func setPoint(item: SucursalModel, map: MKMapView){
        //Set indicator
        let span : MKCoordinateSpan = MKCoordinateSpanMake(0.8, 0.8)
        let location: CLLocationCoordinate2D = CLLocationCoordinate2DMake(CLLocationDegrees(item.latitud), CLLocationDegrees(item.longitud))
        let region: MKCoordinateRegion = MKCoordinateRegionMake(location, span)
        map.setRegion(region, animated: true)
        
        //Set anotation
        let annotation = MKPointAnnotation()
        annotation.coordinate = location
        annotation.title = item.nombre
        annotation.subtitle = "\(item.domicilio) \(item.horario)"
        map.addAnnotation(annotation)
    }
}
