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
    
    var coordinate2D = CLLocationCoordinate2DMake(53.807543, -1.548784)
    
    var camera = MKMapCamera()
    var pitch = 0
    
    //MARK:- OUTLETS
    
    @IBOutlet weak var changeMapType: UIButton!
    
    @IBOutlet weak var changePitch: UIButton!
    
    @IBOutlet weak var mapView: MKMapView!
    
    
    //MARK:- FUNCTIONS
    
    @IBAction func changeMapType(_ sender: UIButton) {
    }
    
    @IBAction func changePitch(_ sender: UIButton) {
       pitch = (pitch + 15) % 90
        sender.setTitle("\(pitch)º", for: .normal)
        mapView.camera.pitch = CGFloat(pitch)
    }
    
    @IBAction func toggleMapFeatures(_ sender: UIButton) {
    }
    
    @IBAction func findHere(_ sender: UIButton) {
    }
    
    @IBAction func findPizza(_ sender: UIButton) {
    }
    
    @IBAction func locationPicker(_ sender: UISegmentedControl) {
        let index = sender.selectedSegmentIndex
        switch index {
        case 0: // Leeds
            coordinate2D = CLLocationCoordinate2DMake(53.807543, -1.548784)
        case 1: // Manchester
            coordinate2D = CLLocationCoordinate2DMake(53.485506, -2.240287)
            updateMapCamera(heading: 245, altitude: 250)
            return
        case 2: // Liverpool
            coordinate2D = CLLocationCoordinate2DMake(053.408269, -2.989188)
            updateMapCamera(heading: 12.0, altitude: 700)
            return
        case 3: // York
            coordinate2D = CLLocationCoordinate2DMake(53.960394, -1.087460)
            updateMapCamera(heading: 180, altitude: 1000)
            return
        case 4: // Sheffield
            coordinate2D = CLLocationCoordinate2DMake(53.386706, -1.470058)
        default:
            coordinate2D = CLLocationCoordinate2DMake(53.807543, -1.548784)
        }
        updateMapRegion(rangeSpan: 100)
        
    }
    
    func updateMapRegion(rangeSpan:CLLocationDistance){
        let region = MKCoordinateRegion(center: coordinate2D, latitudinalMeters: rangeSpan, longitudinalMeters: rangeSpan)
        mapView.region = region
    }
    
    func updateMapCamera(heading:CLLocationDirection, altitude:CLLocationDistance){
        camera.centerCoordinate = coordinate2D
        camera.heading = heading
        camera.altitude = altitude
        camera.pitch = 30.0
        mapView.camera = camera
        
    }
    
    //MARK:- OVERRIDE FUNC VIEWDIDLOAD
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateMapRegion(rangeSpan: 100)
    }


}

