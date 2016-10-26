//
//  ViewController.swift
//  ParkingOfRussia
//
//  Created by User on 24.10.16.
//  Copyright © 2016 User. All rights reserved.
//

import UIKit
import GoogleMaps
import MapKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate {
    let locationManager = CLLocationManager()
    @IBOutlet weak var mapView: GMSMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
        self.locationManager.distanceFilter = 100
        self.locationManager.requestWhenInUseAuthorization()
        
        let camera = GMSCameraPosition.camera(withLatitude: 58.013445,
                                                          longitude: 56.248701, zoom: 10)
        self.mapView.camera = camera
        //self.locationManager.startUpdatingLocation()
        
        //5
        self.mapView.isMyLocationEnabled = true
        self.mapView.settings.myLocationButton = true
        
        //self.mapView.frame = CGRect.zero
        //let mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        //mapView.isMultipleTouchEnabled = true
        //mapView.isMyLocationEnabled = true
        //self.view = mapView
        //self.view.layoutIfNeeded()
        
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2DMake(58.013445, 56.248701)
        marker.title = "Sydney"
        marker.snippet = "Australia"
        marker.map = mapView
    }
    
    // MARK: - CLLocationManagerDelegate
    private func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        // 3
        if status == .authorizedWhenInUse {
            
            // 4
            self.locationManager.startUpdatingLocation()
            
            //5
            self.mapView.isMyLocationEnabled = true
            self.mapView.settings.myLocationButton = true
        }
    }
    
    // 6
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            
            // 7
            mapView.camera = GMSCameraPosition(target: location.coordinate, zoom: 15, bearing: 0, viewingAngle: 0)
            
            // 8
            locationManager.stopUpdatingLocation()
        }
        
    }
}


