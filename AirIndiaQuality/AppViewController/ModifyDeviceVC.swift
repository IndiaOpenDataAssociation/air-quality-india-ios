//
//  ModifyDeviceVC.swift
//  AirQualityIndia
//
//  Created by Shivang Dave on 07/11/16.
//  Copyright © 2016 Alpesh. All rights reserved.
//

import UIKit

class ModifyDeviceVC: UIViewController {
    
    var deviceName = ""
    var deviceId = ""
    var latitude = ""
    var longi = ""
    var city = ""
    var country = ""
    var type = ""
    
    @IBOutlet weak var txtDeviceName : UITextField!
    @IBOutlet weak var lblLatValue : UILabel!
    @IBOutlet weak var lblLongValue : UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = "Manage"
        
        txtDeviceName.text = deviceName
        lblLatValue.text = latitude
        lblLongValue.text = longi
        
        backButton()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        initActivityLoader("Assets All_Loader_Oizom", LableName: "LOADING", color: true)
    }
    
    @IBAction func btnSaveClicked(sender: AnyObject)
    {
        if checkInternate() && validation()
        {
            callChangeName()
        }
    }
    
    @IBAction func btnChangeWifiClicked(sender: AnyObject)
    {
        callChangeWifi()
    }
    
    func validation() -> Bool
    {
        if isEmptyString(self.txtDeviceName.text!)
        {
            showAlert("Device name is empty!")
            return false
        }
        return true
    }
    
}
