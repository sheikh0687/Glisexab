//
//  Utility.swift
//  Glisexab
//
//  Created by Techimmense Software Solutions on 29/10/25.
//

import MapKit

class Utility {
    
    class func setCurrentLocation(_ mapView: MKMapView) {
        let region = MKCoordinateRegion(center: kAppDelegate.coordinate2.coordinate, span: MKCoordinateSpan(latitudeDelta: 0.002, longitudeDelta: 0.002))
        mapView.setRegion(region, animated: true)
    }
}
