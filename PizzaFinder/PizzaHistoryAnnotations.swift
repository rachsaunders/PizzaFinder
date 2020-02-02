//
//  PizzaAnnotation.swift
//  PizzaFinder
//
//  Created by Rachel Saunders on 12/01/2020.
//  Copyright © 2020 Rachel Saunders. All rights reserved.
//

import UIKit
import CoreLocation

class PizzaHistoryAnnotations{
    var annotations:[PizzaAnnotation] = []
    init(){
        //Leeds
        var annotation = PizzaAnnotation( coordinate: CLLocationCoordinate2DMake(53.797572, -1.545371), title: "Mod Pizza", subtitle: "Vegan Pizza!")
        annotation.pizzaPhoto = #imageLiteral(resourceName: "Leeds")
        annotation.deliveryRadius = 30.0
        annotation.informationText = "Dairy free cheese Yay!"
        self.annotations.append(annotation)
        
        //Manc
        annotation = PizzaAnnotation( coordinate: CLLocationCoordinate2DMake(53.478622, -2.245945), title: "Pizza Express", subtitle: "Vegan Pizza!")
        annotation.pizzaPhoto = #imageLiteral(resourceName: "Manc")
          annotation.deliveryRadius = 60.0
        annotation.informationText = "Dairy free cheese Yay!"
        annotations.append(annotation)
        
    }
}
