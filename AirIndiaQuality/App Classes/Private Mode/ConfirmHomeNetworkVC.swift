//
//  ConfirmHomeNetworkVC.swift
//  AirQualityIndia
//
//  Created by Shivang Dave on 26/09/16.
//  Copyright © 2016 Shivang Dave. All rights reserved.
//

import UIKit

class ConfirmHomeNetworkVC: UIViewController {
    
    @IBOutlet weak var imgProduct : UIImageView!
    @IBOutlet weak var lblProdName: UILabel!
    var imgName = ""
    var proId = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        
        switch imgName {
        case "pol":
            imgProduct.image = UIImage(named: "Assets_Add Device_Polludrone")
            lblProdName.text = "Polludrone"
            break
        case "bre":
            imgProduct.image = UIImage(named: "Assets_Add Device_Breath i")
            lblProdName.text = "Breathe i"
            break
        case "3g":
            imgProduct.image = UIImage(named: "Assets_Add Device_AirOwl")
            lblProdName.text = "AirOwl 3G"
            break
        case "wi":
            imgProduct.image = UIImage(named: "Assets_Add Device_AirOwl")
            lblProdName.text = "AirOwl Wi"
            break
        default:
            imgProduct.image = UIImage(named: "Assets_Add Device_AirOwl")
        }

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func btnDoneClicked(sender:AnyObject)
    {
        //appDelegate.deviceId = self.proId
        appDelegate.switchPrivateMode()
    }
}
