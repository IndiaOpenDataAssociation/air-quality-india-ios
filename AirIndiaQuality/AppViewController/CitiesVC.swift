//
//  CitiesVC.swift
//  AirIndiaQuality
//
//  Created by Shivang Dave on 25/08/16.
//  Copyright © 2016 Shivang Dave. All rights reserved.
//

import UIKit


class CitiesCell : UITableViewCell
{
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblSubTitle: UILabel!
    @IBOutlet weak var lblAqi : UILabel!
    @IBOutlet weak var viewProgress: RPCircularProgress!
    
    @IBOutlet weak var imgDev : UIImageView!
}

var aqiArrayHelper = NSArray()

class CitiesVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView : UITableView!
    var deviceArray = NSMutableArray()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        initActivityLoader("Assets All_Loader_Oizom", LableName: "LOADING", color: true)
        getAllDevices()
    }
    
    func getAllDevices()
    {
        deviceArray = ModelManager.getInstance().getAllData()
        tableView.reloadData()
        
        if aqiArrayHelper.count == 0
        {
            getAllDeviceData()
        }
    }
    
    @IBAction func btnAddCityClicked(sender: LetsButton) {
        let obj = mainStoryBoard.instantiateViewControllerWithIdentifier("AddCityMapVC") as! AddCityMapVC
        self.navigationController?.pushViewController(obj, animated: true)
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if aqiArrayHelper.count != 0
        {
            return deviceArray.count
        }
        else
        {
            return 0
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("CitiesCell") as! CitiesCell

        let obj : DeviceInfo = deviceArray[indexPath.row] as! DeviceInfo
        
        cell.lblTitle.text = obj.device_name
        
        if aqiArrayHelper.count != 0
        {
            for i in 0...aqiArrayHelper.count-1
            {
                let dic = aqiArrayHelper[i] as! NSDictionary
                //print(dic)
                
                if dic.valueForKey("deviceId") as! String == obj.device_id
                {
                    cell.lblAqi.text = nf.stringFromNumber(dic.valueForKey("aqi") as! NSNumber)
                    
                    let abc = nf.numberFromString(dic["payload"]!["d"]!?["t"] as! String)?.doubleValue
                    let fullDate = NSDate(timeIntervalSince1970: abc!)
                    df.dateFormat = "MMM dd, yyyy HH:mm"
                    
                    cell.lblSubTitle.text = "Updated at: " + df.stringFromDate(fullDate)
                    
                    let x = (dic.valueForKey("aqi") as! NSNumber).integerValue
                    
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
                        
                    }
                    let y = dic.valueForKey("aqi") as! CGFloat / 500.0
                    cell.viewProgress.updateProgress(CGFloat(y), animated: true, initialDelay: 0, duration: 1, completion: nil)
                }
                
                if cell.lblAqi.text == ""
                {
                    cell.lblAqi.text = nf.stringFromNumber(obj.aqi)
                }
                
                if cell.lblSubTitle.text == "Label"
                {
                    cell.lblSubTitle.text = "Updated at: " + obj.lastUpdate
                }
            }
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
        let cell = tableView.cellForRowAtIndexPath(indexPath) as! CitiesCell
        let obj : DeviceInfo = deviceArray[indexPath.row] as! DeviceInfo
        let devId = obj.device_id
        //let devId = cell.lblSubTitle.text!
        
        if cell.lblAqi.text == "N/A"
        {
            tableView.deselectRowAtIndexPath(indexPath, animated: true)
        }
        else
        {
            if appDelegate.gDeviceId != devId
            {
                appDelegate.gDeviceId = devId
                NSUserDefaults.standardUserDefaults().setValue(appDelegate.gDeviceId, forKey: "gdevId")
                appDelegate.switchGlobalMode(1)
            }
            else
            {
                tableView.deselectRowAtIndexPath(indexPath, animated: true)
            }
        }
    }

    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        var flag = Bool()
        if deviceArray.count != 1
        {
            flag = true
        }
        else
        {
            flag = false
        }
        return flag
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {

      if editingStyle == UITableViewCellEditingStyle.Delete {
            let cell = tableView.cellForRowAtIndexPath(indexPath) as! CitiesCell
            let obj : DeviceInfo = deviceArray[indexPath.row] as! DeviceInfo
        
            if appDelegate.gDeviceId == cell.lblSubTitle.text!
            {
                showAlert("Please switch city/device before deleting")
            }
            else
            {
                let alert = UIAlertController(title: "Are you sure?", message: "Are you sure you want to remove this city?", preferredStyle: .Alert)
                
                let yes = UIAlertAction(title: "Yes", style: .Default) { (yes) in
                
                    let info = DeviceInfo()
                    info.device_id = obj.device_id
                    ModelManager.getInstance().deleteDevice(info)
                    self.getAllDevices()
                }
                let no = UIAlertAction(title: "no", style: .Cancel) { (no) in
                    self.dismissViewControllerAnimated(true, completion: nil)
                }
                alert.addAction(yes)
                alert.addAction(no)
                self.presentViewController(alert, animated: true, completion: nil)
            }
        }
    }
}
