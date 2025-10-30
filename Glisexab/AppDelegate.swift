//
//  AppDelegate.swift
//  Glisexab
//
//  Created by Techimmense Software Solutions on 29/10/25.
//

import Foundation
import IQKeyboardManagerSwift
import UIKit
import _LocationEssentials

let kAppDelegate = UIApplication.shared.delegate as! AppDelegate

class AppDelegate: NSObject, UIApplicationDelegate {
    
    var coordinate1 = CLLocation(latitude: 0.0, longitude: 0.0)
    var coordinate2 = CLLocation(latitude: 0.0, longitude: 0.0)
    var CURRENT_LAT = ""
    var CURRENT_LON = ""
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        IQKeyboardManager.shared.isEnabled = true

        return true
    }
}

//extension AppDelegate: LocationManagerDelegate {
//    
//    func didEnterInCircularArea() {
//        print("")
//    }
//    
//    func didExitCircularArea() {
//        print("")
//    }
//    
//    func tracingLocation(currentLocation: CLLocation) {
//        coordinate2 = currentLocation
//        print(coordinate2)
//        let distanceInMeters = coordinate1.distance(from: coordinate2) // result is in meters
//        if distanceInMeters > 250 {
//            CURRENT_LAT = String(currentLocation.coordinate.latitude)
//            CURRENT_LON = String(currentLocation.coordinate.longitude)
//            coordinate1 = currentLocation
//        }
//    }
//    
//    func tracingLocationDidFailWithError(error: NSError) {
//        print("tracing Location Error : \(error.description)")
//    }
//}
