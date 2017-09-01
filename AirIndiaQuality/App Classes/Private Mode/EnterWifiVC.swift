//
//  EnterWifiVC.swift
//  AirQualityIndia
//
//  Created by Shivang Dave on 26/09/16.
//  Copyright © 2016 Shivang Dave. All rights reserved.
//

import UIKit

class EnterWifiVC: UIViewController {
    
    var prodName = ""
    var imgName = ""
    var proId = ""
    
    @IBOutlet weak var lblProductName : UILabel!
    @IBOutlet weak var txtUserId : UITextField!
    @IBOutlet weak var txtPassword : UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Add device"
    }
    
    override func viewWillDisappear(animated: Bool) {
        self.navigationItem.title = ""
    }
    
    override func viewWillAppear(animated: Bool) {
        
        switch imgName {
        case "pol":
            self.lblProductName.text = "Polludrone"
            initActivityLoader("Assets All_Loader_Polludrone", LableName: "LOADING", color: true)
            break
        case "bre":
            self.lblProductName.text = "Breathe i"
            initActivityLoader("Assets All_Loader_Breath i", LableName: "LOADING", color: true)
            break
        case "3g":
            self.lblProductName.text = "AirOwl 3G"
            
            initActivityLoader("Assets All_Loader_Airowl", LableName: "LOADING", color: true)
            break
        case "wi":
            self.lblProductName.text = "AirOwl Wi"
            initActivityLoader("Assets All_Loader_Airowl", LableName: "LOADING", color: true)
            break
        default:
            break
        }

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func btnNextClicked(sender:AnyObject)
    {
        if checkInternate() && validation()
        {
            callWifiReg()
        }
    }
    
    @IBAction func btnSkipClicked(sender:AnyObject)
    {
        if checkInternate()
        {
            let obj = privateStoryBoard.instantiateViewControllerWithIdentifier("ConfirmHomeNetworkVC") as! ConfirmHomeNetworkVC
            obj.proId = self.proId
            self.navigationController?.pushViewController(obj, animated: true)
        }
    }

    func validation() -> Bool
    {
        if isEmptyString(txtUserId.text!)
        {
            showAlert("Please enter wifi SSID")
            return false
        }
        else if isEmptyString(txtPassword.text!)
        {
            showAlert("Please enter wifi password")
            return false
        }
        else
        {
            return true
        }
    }
}
