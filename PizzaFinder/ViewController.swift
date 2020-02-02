//
//  ViewController.swift
//  PizzaFinder
//
//  Created by Rachel Saunders on 12/01/2020.
//  Copyright © 2020 Rachel Saunders. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController, MKMapViewDelegate {
    
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
        mapView.showsBuildings = isOn
        isOn = !isOn
        mapView.pointOfInterestFilter = isOn ? MKPointOfInterestFilter.includingAll : MKPointOfInterestFilter.excludingAll
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
        // mapView.removeAnnotations(mapView.annotations)
        switch index {
        case 0: // Leeds
            coordinate2D = CLLocationCoordinate2DMake(53.807543, -1.548784)
        case 1: // Manchester
            coordinate2D = CLLocationCoordinate2DMake(53.485506, -2.240287)
            updateMapCamera(heading: 245, altitude: 250)
          //  let pizzaPin = PizzaAnnotation(coordinate: coordinate2D, title: "Manchester Pizza!", subtitle: "Pizza comes to Manc!")
           // mapView.addAnnotation(pizzaPin)
            return
        case 2: // Liverpool
            coordinate2D = CLLocationCoordinate2DMake(053.408269, -2.989188)
            updateMapCamera(heading: 0, altitude: 15000)
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
           // mapView.addAnnotation(pizzaPin)
            updateMapCamera(heading: 0, altitude: 10000)
            return
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
    
    func addDeliveryOverlay(){
       // let radius = 1600.0
        for location in mapView.annotations{
            if let radius = (location as! PizzaAnnotation).deliveryRadius{
            let circle = MKCircle(center: location.coordinate, radius: radius)
            // add was renamed to addOverlay FYI
                mapView.addOverlay(circle)
            }
        }
    }
    
    //MARK:- OVERRIDE FUNC VIEWDIDLOAD
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
        mapView.addAnnotations(PizzaHistoryAnnotations().annotations)
        addDeliveryOverlay()
        updateMapRegion(rangeSpan: 100)
    }
    
     //MARK:- ANNOTATIONS
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        var annotationView = MKAnnotationView()
        guard let annotation = annotation as? PizzaAnnotation
            else{
                return nil
        }
        if let dequedView = mapView.dequeueReusableAnnotationView(withIdentifier: annotation.identifier) {
            annotationView = dequedView
        } else {
            annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: annotation.identifier)
        }
        // annotationView.pinTintColor = UIColor.blue
        annotationView.image = UIImage(named: "pizza pin")
        annotationView.canShowCallout = true
        let paragraph = UILabel()
        paragraph.numberOfLines = 0
        paragraph.font = UIFont.preferredFont(forTextStyle: .caption1)
        paragraph.text = annotation.subtitle
        paragraph.numberOfLines = 1
        paragraph.adjustsFontSizeToFitWidth = true
        annotationView.detailCalloutAccessoryView = paragraph
        annotationView.leftCalloutAccessoryView = UIImageView(image: annotation.pizzaPhoto)
        annotationView.rightCalloutAccessoryView = UIButton(type: .infoLight)
        return annotationView
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        let vc = AnnotationDetailViewController(nibName: "AnnotationDetailViewController", bundle: nil)
        vc.annotation = view.annotation as! PizzaAnnotation
        present(vc, animated: true, completion: nil)
    }
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        if let circle = overlay as? MKCircle {
            let circleRenderer = MKCircleRenderer(circle: circle)
            circleRenderer.fillColor = UIColor(red: 0.0, green: 0.1, blue: 1.0, alpha: 0.1)
            circleRenderer.strokeColor = UIColor.blue
            circleRenderer.lineWidth = 1.0
            return circleRenderer
        }
        return MKOverlayRenderer(overlay: overlay)
    }


}

