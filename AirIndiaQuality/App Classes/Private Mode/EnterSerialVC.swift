//
//  EnterSerialVC.swift
//  AirQualityIndia
//
//  Created by Shivang Dave on 26/09/16.
//  Copyright © 2016 Shivang Dave. All rights reserved.
//

import UIKit
import CoreLocation

class EnterSerialVC: UIViewController, CLLocationManagerDelegate {
    
    var imgName = ""
    
    @IBOutlet weak var imgProduct : UIImageView!
    @IBOutlet weak var txtSerialId : UITextField!
    @IBOutlet weak var lblWrongText : UILabel!
    @IBOutlet weak var lblStep : UILabel!
    @IBOutlet weak var lblProduct : UILabel!
    
    var locManager = CLLocationManager()
    var lat = String()
    var long = String()
    var country = String()
    var city = String()
    var proType = String()
    
    override func viewWillAppear(animated: Bool) {
        lblWrongText.hidden = true

        self.navigationItem.title = "Add device"
    }
    
    override func viewDidDisappear(animated: Bool) {
        self.navigationItem.title = ""
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        locManager.delegate = self
        
        if CLLocationManager.locationServicesEnabled()
        {
            if CLLocationManager.authorizationStatus() == CLAuthorizationStatus.NotDetermined
            {
                locManager.requestWhenInUseAuthorization()
                locManager.startUpdatingLocation()
            }
            else
            {
                locManager.startUpdatingLocation()
            }

        }
        else
        {
            showAuthError()
        }
        
        switch imgName {
        case "pol":
            imgProduct.image = UIImage(named: "Assets_Add Device_Polludrone")
            lblStep.text = "Step 1: Connect to Polludrone"
            lblProduct.text = "Polludrone"
            proType = "POLLUDRONE"
            initActivityLoader("Assets All_Loader_Polludrone", LableName: "LOADING", color: true)
            break
        case "bre":
            imgProduct.image = UIImage(named: "Assets_Add Device_Breath i")
            lblStep.text = "Step 1: Connect to Breathe i"
            lblProduct.text = "Breathe i"
            proType = "BREATHEI"
            initActivityLoader("Assets All_Loader_Breath i", LableName: "LOADING", color: true)
            break
        case "3g":
            imgProduct.image = UIImage(named: "Assets_Add Device_AirOwl")
            lblStep.text = "Step 1: Connect to AirOwl 3G"
            lblProduct.text = "AirOwl 3G"
            proType = "AIROWL3G"
            initActivityLoader("Assets All_Loader_Airowl", LableName: "LOADING", color: true)
            break
        case "wi":
            imgProduct.image = UIImage(named: "Assets_Add Device_AirOwl")
            lblStep.text = "Step 1: Connect to AirOwl Wi"
            lblProduct.text = "AirOwl Wi"
            proType = "AIROWLWI"
            initActivityLoader("Assets All_Loader_Airowl", LableName: "LOADING", color: true)
            break
        default:
            imgProduct.image = UIImage(named: "Assets_Add Device_AirOwl")
            initActivityLoader("Assets All_Loader_Airowl", LableName: "LOADING", color: true)
        }
    }

    func showAuthError()
    {
        let alert = UIAlertController(title: "Sorry!", message: "Location service is required to register your device.", preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "Go to Settings now", style: UIAlertActionStyle.Default, handler: { (alert: UIAlertAction!) in
            
            UIApplication.sharedApplication().openURL(NSURL(string:UIApplicationOpenSettingsURLString)!)
        }))
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first
        {
            self.lat = String(format: "%f",location.coordinate.latitude)
            self.long = String(format: "%f",location.coordinate.longitude)
            
            let geoCoder = CLGeocoder()
            let location = CLLocation(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
            
            geoCoder.reverseGeocodeLocation(location, completionHandler: { (placemark, error) in
                
                let placeArray = placemark as [CLPlacemark]!
                var placeMark : CLPlacemark!
                
                placeMark = placeArray[0]
                if let cityName = placeMark.addressDictionary?["City"] as? NSString
                {
                    self.city = cityName as String
                }
                
                if let countryName = placeMark.addressDictionary?["Country"] as? NSString
                {
                    self.country = countryName as String
                }
            })
            
            locManager.stopUpdatingLocation()
        }
    }
    
    func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
        showAuthError()
    }
    
    @IBAction func btnNextClicked(sender:AnyObject)
    {
        if checkInternate() && validation()
        {
            callDeviceReg()
        }
    }
    
    func validation() -> Bool
    {
        if isEmptyString(txtSerialId.text!) || txtSerialId.text?.characters.count < 5
        {
            lblWrongText.hidden = false
            return false
        }
        if self.city == "" || self.country == "" || self.lat == "" || self.long == ""
        {
            if isEmptyString(self.lat) || isEmptyString(self.long)
            {
                showAlert("Couldn't get location. Try again.")
            }
            else
            {
                showAlert("Something is wrong. Try again later.")
            }
            return false
        }
        return true
    }
}
