//
//  LocationManager.swift
//  Za Hunter
//
//  Created by Student on 3/16/21.
//

import Foundation
import CoreLocation

class LocationManager: NSObject, CLLocationManagerDelegate, ObservableObject
{
    var locationManager = CLLocationManager()
    
    override init()
    {
        super.init()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
}
