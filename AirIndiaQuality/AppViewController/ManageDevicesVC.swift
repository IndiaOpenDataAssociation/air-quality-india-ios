//
//  DevicesVC.swift
//  AirIndiaQuality
//
//  Created by Shivang Dave on 04/09/16.
//  Copyright © 2016 Shivang Dave. All rights reserved.
//

import UIKit

class ManageDevicesVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var deviceArray = NSMutableArray()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        backButton()
        title = "Manage Devices"
    }
    
    override func viewWillAppear(animated: Bool) {
        initActivityLoader("Assets All_Loader_Oizom", LableName: "LOADING", color: true)
        callDeviceLog(appDelegate.userId,y: 0)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return deviceArray.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("CitiesCell") as! CitiesCell
        if deviceArray.count != 0
        {
            let obj = deviceArray[indexPath.row] as! NSDictionary
            
            if obj["type"] != nil
            {
                let devType = obj["type"] as! String
                switch devType
                {
                case "AIROWL3G":
                    cell.imgDev.image = UIImage(named: "Assets_My Device_Device list_Airowl")
                    break
                case "BREATHI":
                    cell.imgDev.image = UIImage(named: "Assets_My Device_Device list_Breath i")
                    break
                case "AIROWLWI":
                    cell.imgDev.image = UIImage(named: "Assets_My Device_Device list_Airowl")
                    break
                case "POLLUDRON_PRO":
                    cell.imgDev.image = UIImage(named: "Assets_My Device_Device list_Polludrone")
                    break
                case "ZIP":
                    cell.imgDev.image = UIImage(named: "Assets_My Device_Device list_Zip")
                default:
                    cell.imgDev.image = UIImage(named: "Assets_My Device_Device list_Airowl")
                    break
                }
            }
            else
            {
                cell.imgDev.image = UIImage(named: "Assets_My Device_Device list_Airowl")
            }
            
            cell.lblTitle.text = obj["label"] as? String
            cell.lblSubTitle.text = obj["city"] as? String
            cell.lblAqi.text = nf.stringFromNumber(obj["aqi"] as! NSNumber)
            let progress = obj["aqi"] as! CGFloat / 500.0
            //cell.viewProgress.updateProgress(CGFloat(progress))
            cell.viewProgress.updateProgress(CGFloat(progress), animated: true, initialDelay: 0, duration: 1, completion: nil)
        }
        
        return cell
    }
    
    func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let obj2 = deviceArray[indexPath.row] as! NSDictionary
        
        //print(deviceArray)
        
        let obj = privateStoryBoard.instantiateViewControllerWithIdentifier("ModifyDeviceVC") as! ModifyDeviceVC
        obj.deviceName = obj2.valueForKey("label") as! String
        obj.deviceId = obj2.valueForKey("deviceId") as! String
        
        if obj2.valueForKey("city") != nil
        {
            obj.city = obj2.valueForKey("city") as! String
        }
        if obj2.valueForKey("country") != nil
        {
            obj.country = obj2.valueForKey("country") as! String
        }
        if obj2.valueForKey("type") != nil
        {
            obj.type = obj2.valueForKey("type") as! String
        }
        if obj2.valueForKey("longitude") != nil
        {
            if obj2.valueForKey("longitude") is NSNumber
            {
                let x = (obj2.valueForKey("longitude") as! NSNumber).floatValue
                obj.longi = "\(x)"
            }
            else
            {
                obj.longi = obj2.valueForKey("longitude") as! String
            }
        }
        if obj2.valueForKey("latitude") != nil
        {
           if obj2.valueForKey("latitude") is NSNumber
           {
                let x = (obj2.valueForKey("latitude") as! NSNumber).floatValue
                obj.latitude = "\(x)"
           }
            else
           {
                obj.latitude = obj2.valueForKey("latitude") as! String
            }
        }
        self.navigationController?.pushViewController(obj, animated: true)
    }

}
