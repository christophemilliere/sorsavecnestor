//
//  Location.swift
//  nestor
//
//  Created by milliere on 24/09/2016.
//  Copyright © 2016 milliere. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit

class Location: NSObject, CLLocationManagerDelegate {
    
    var mapViewController: UIViewController!
    var locationManager: CLLocationManager = CLLocationManager()
    var startLocation: CLLocation!
    var userLocation = CLLocation()
    
    override init() {
        super.init()
    }
    
    func findUserLocation()->Void{
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    
    func distance(_ lat: Double, long: Double) -> String{
        
        let metre: String
        let myLocation = CLLocation(latitude:lat, longitude: long)
        let distance = userLocation.distance(from: myLocation)
        
        if distance > 1000 {
            let distance = distance / 1000
            metre = "\(round(distance)) km"
        }else{
            metre = "\(distance) m"
        }
        
        return metre
        
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        let location = locations.last
        //let userLocation: CLLocation = locations[0]
        let center = CLLocation(latitude: location!.coordinate.latitude, longitude: location!.coordinate.longitude)
        userLocation = center
        self.locationManager.stopUpdatingLocation()
    }
    
}

