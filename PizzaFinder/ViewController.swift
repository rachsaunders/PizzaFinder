//
//  ViewController.swift
//  PizzaFinder
//
//  Created by Rachel Saunders on 12/01/2020.
//  Copyright © 2020 Rachel Saunders. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController {
    
    
    //MARK:- OUTLETS
    
    @IBOutlet weak var changeMapType: UIButton!
    
    @IBOutlet weak var changePitch: UIButton!
    
    @IBOutlet weak var mapView: MKMapView!
    
    
    //MARK:- FUNCTIONS
    
    @IBAction func changeMapType(_ sender: Any) {
    }
    
    @IBAction func changePitch(_ sender: Any) {
    }
    
    @IBAction func toggleMapFeatures(_ sender: Any) {
    }
    
    @IBAction func findHere(_ sender: Any) {
    }
    
    
    @IBAction func findPizza(_ sender: Any) {
    }
    
    
    @IBAction func locationPicker(_ sender: UISegmentedControl) {
    }
    
    //MARK:- OVERRIDE FUNC VIEWDIDLOAD
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

