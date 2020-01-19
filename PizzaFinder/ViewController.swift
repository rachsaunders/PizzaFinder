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
    
    var isOn = false
    
    //MARK:- OUTLETS
    
    @IBOutlet weak var changeMapType: UIButton!
    
    @IBOutlet weak var changePitch: UIButton!
    
    @IBOutlet weak var mapView: MKMapView!
    
    //MARK:- ACTIONS
    
    @IBAction func changeMapType(_ sender: UIButton) {
        switch mapView.mapType{
        case .standard:
            mapView.mapType = .satellite
        case .satellite:
            mapView.mapType = .hybrid
        case .hybrid:
            mapView.mapType = .satelliteFlyover
        case .satelliteFlyover:
            mapView.mapType = .hybridFlyover
        case .hybridFlyover:
            mapView.mapType = .standard
        case .mutedStandard:
            mapView.mapType = .satellite
        @unknown default:
            mapView.mapType = .satellite
        }
    }
    
    @IBAction func changePitch(_ sender: UIButton) {
       pitch = (pitch + 15) % 90
        sender.setTitle("\(pitch)º", for: .normal)
        mapView.camera.pitch = CGFloat(pitch)
    }
    
    @IBAction func toggleMapFeatures(_ sender: UIButton) {
       // mapView.showsBuildings = isOn
       // isOn = !isOn
      //  isOn = !mapView.showsPointsOfInterest
       // mapView.showsPointsOfInterest = isOn
        mapView.showsScale = isOn
        mapView.showsCompass = isOn
        mapView.showsTraffic = isOn
    }
    
    @IBAction func findHere(_ sender: UIButton) {
    }
    
    @IBAction func findPizza(_ sender: UIButton) {
    }
    
    @IBAction func locationPicker(_ sender: UISegmentedControl) {
        let index = sender.selectedSegmentIndex
        mapView.removeAnnotations(mapView.annotations)
        switch index {
        case 0: // Leeds
            coordinate2D = CLLocationCoordinate2DMake(53.807543, -1.548784)
        case 1: // Manchester
            coordinate2D = CLLocationCoordinate2DMake(53.485506, -2.240287)
            updateMapCamera(heading: 245, altitude: 250)
            let pizzaPin = PizzaAnnotation(coordinate: coordinate2D, title: "Manchester Pizza!", subtitle: "Pizza comes to Manc!")
            mapView.addAnnotation(pizzaPin)
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
            let pizzaPin = MKPointAnnotation()
            pizzaPin.coordinate = coordinate2D
            pizzaPin.title = "Sheffield Pizza"
            pizzaPin.subtitle = "Also known as Sheffield Pizza"
            mapView.addAnnotation(pizzaPin)
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
        camera.pitch = 0.0
        changePitch.setTitle("0", for: .normal)
        mapView.camera = camera
        
    }
    
    //MARK:- OVERRIDE FUNC VIEWDIDLOAD
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateMapRegion(rangeSpan: 100)
    }


}

