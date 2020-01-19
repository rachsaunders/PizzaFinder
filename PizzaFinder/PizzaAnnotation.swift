//
//  PizzaAnnotation.swift
//  PizzaFinder
//
//  Created by Rachel Saunders on 12/01/2020.
//  Copyright © 2020 Rachel Saunders. All rights reserved.
//

import UIKit
import MapKit

class PizzaAnnotation: NSObject, MKAnnotation {
    var coordinate: CLLocationCoordinate2D
    var title: String?
    var subtitle: String?
    var identifier = "Pin"
    var informationText = ""
    var pizzaPhoto:UIImage! = nil
    init(coordinate:CLLocationCoordinate2D, title:String?,subtitle:String?){
        self.coordinate = coordinate
        self.title = title
        self.subtitle = subtitle
    }
}
