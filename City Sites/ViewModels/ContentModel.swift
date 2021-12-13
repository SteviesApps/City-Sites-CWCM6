//
//  ContentModel.swift
//  City Sites
//
//  Created by Steven Kaiser on 12/12/21.
//

import Foundation

// The core location framework contains all of the classes we need to located the user. The main class used is the location manager.
import CoreLocation

// In order for the view model to publish its changes and the view code to access those changes the ContentModel class must comform to the ObserableObject protocal. Besure to add the environment object modifer to the launch view. The Contentmodel class also must comform to the CLLocationManagerDelegate protocal in order to be the location manager. Only NSObjects can comform to the CLLocationManagerDelegate. The ContentModel class must also comform to the NSObject protocal.

class ContentModel: NSObject, CLLocationManagerDelegate, ObservableObject {
 
//    This property is the instance of the core location's location manger class.
    var locationManager = CLLocationManager()
    
//    The init method is called on everytime a new instance of the view model is created. NSObject has its own init methods. To run our own init method we need to use the override key word. The super key word allows the NSObject class to run its own init methods then the app's custom init method is ran.
    
    override init() {
        
//        Init method of NSObject.
        super.init()
        
//        Set content model as the delegate of the location manager. This done for the view model to handle the function that has been called           on when the user gives or denies permission.
        locationManager.delegate = self
        
//        Request permission from the user. Besure sure to add the key for permission to the info.p list with a request permission message.
        locationManager.requestWhenInUseAuthorization()
        
    }
    
//    The ContentModel class after all the protocals and init methods are in place it is set up to handle the methods the location manger may call on.
    
//    MARK: Location Manager Delegate Methods
    
//    When the status of the location manager changes and this method is called it will do one of two tasks 1. if the user gives permission it starts updating the user's location, 2. if permission is denied ???
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        
        if locationManager.authorizationStatus == .authorizedAlways || locationManager.authorizationStatus == .authorizedWhenInUse {
            
//            We have permission. Start geolocating the user.
            locationManager.startUpdatingLocation()
            
        }
//        We do not have permission.
        else if locationManager.authorizationStatus == .denied {
            
        }
    }
    
//    This method is where the location of the user is stored. Then stops requesting the user's location.
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
//        Give us the location of the user.
        print(locations.first ?? "no location")
        
//        Stop requesting the location after we get it once.
        locationManager.stopUpdatingLocation()
        
//        TODO: If we have coordinates of the user, send to Yelp API
        
        
    }
    
}

