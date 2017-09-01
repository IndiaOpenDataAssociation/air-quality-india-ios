//
//  PrivateCitiesVC.swift
//  AirQualityIndia
//
//  Created by Shivang Dave on 04/09/16.
//  Copyright © 2016 Shivang Dave. All rights reserved.
//

import UIKit

class PrivateCitiesVC: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if appDelegate.flag
        {
            privateDev = userArray
        }
    }

    
    override func viewWillAppear(animated: Bool) {
        self.navigationItem.title = "My Devices"
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func btnAddCityClicked(sender: LetsButton) {
        self.navigationItem.title = ""
        let obj = privateStoryBoard.instantiateViewControllerWithIdentifier("SelectProductVC") as! SelectProductVC
        self.navigationController?.pushViewController(obj, animated: true)
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return privateDev.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("CitiesCell") as! CitiesCell
        if privateDev.count != 0
        {
            let obj = privateDev[indexPath.row] as! NSDictionary
            
            //print(obj)
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
            
            let x = (obj["aqi"] as! NSNumber).integerValue
            //print(x)
            if x > 0 && x <= 50
            {
                cell.viewProgress.progressTintColor = UIColor(red: 110/255, green: 204/255, blue: 88/255, alpha: 1.0)
            }
            else if x > 50 && x <= 100
            {
                cell.viewProgress.progressTintColor = UIColor(red: 187/255, green: 207/255, blue: 76/255, alpha: 1.0)
            }
            else if x > 100 && x <= 200
            {
                cell.viewProgress.progressTintColor = UIColor(red: 234/255, green: 199/255, blue: 54/255, alpha: 1.0)
            }
            else if x > 200 && x <= 300
            {
                cell.viewProgress.progressTintColor = UIColor(red: 237/255, green: 154/255, blue: 46/255, alpha: 1.0)
            }
            else if x > 300 && x <= 400
            {
                cell.viewProgress.progressTintColor = UIColor(red: 232/255, green: 99/255, blue: 58/255, alpha: 1.0)
            }
            else if x > 400 && x <= 500
            {
                cell.viewProgress.progressTintColor = UIColor(red: 214/255, green: 54/255, blue: 54/255, alpha: 1.0)
            }
            else
            {
                //                        cell.viewProgress.progressTintColor = UIColor(red: 110/255, green: 204/255, blue: 88/255, alpha: 1.0)
            }
            
            let progress = obj["aqi"] as! CGFloat / 500.0
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
        
        let obj = privateDev[indexPath.row] as! NSDictionary
        if obj["deviceId"] as! String != appDelegate.deviceId
        {
            //appDelegate.deviceId = obj["deviceId"] as! String
            let devId = obj["deviceId"] as! String
            appDelegate.switchDevice(devId)
        }
        else
        {
            tableView.deselectRowAtIndexPath(indexPath, animated: true)
        }
    }

}
