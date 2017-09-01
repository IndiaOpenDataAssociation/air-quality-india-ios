//
//  WebService.swift
//  waramusic
//
//  Created by Shivang Dave on 18/08/16.
//  Copyright © 2016 Shivang Dave. All rights reserved.
//

import Foundation

let header = ["x-mashape-key":"kEBlw5M6UkmshH5Y1j38QnSPeqtRp1Qeoeljsn0OtzThd93Yeh"]

let df = NSDateFormatter()

extension ModifyDeviceVC
{
    func callChangeName()
    {
        activityLoader(true)
        
        let url = PRIVATE_URL_BASE + "/" + appDelegate.userId + "/devices" + "/\(deviceId)"
        //print(url)
        
        //let tempHead = ["air-quality-india-app":"no-auth"]
        
        let parameters = ["deviceId":deviceId,"label":txtDeviceName.text!,"latitude":latitude,"longitude":longi,"city":city,"country":country,"loc":city,"type":type]
        
        print(parameters)
        
        request(.PUT, url, parameters: parameters, encoding: .JSON, headers: nil).responseJSON { (response : Response<AnyObject, NSError>) -> Void in
            
            self.activityLoader(false)
            
            if (response.result.value != nil)
            {
                //print(response.result.value)
                
                if let devName = response.result.value!["label"] as? String
                {
                    if devName != self.txtDeviceName.text
                    {
                        showAlert("Renaming failed")
                        self.navigationController?.popToRootViewControllerAnimated(true)
                    }
                    else
                    {
                        showAlert("Successfully Renamed")
                        self.navigationController?.popToRootViewControllerAnimated(true)
                    }
                }
                else
                {
                    showAlert("Renaming failed")
                    self.navigationController?.popToRootViewControllerAnimated(true)
                }
            }
            else
            {
                showAlert("Renaming failed")
                self.navigationController?.popToRootViewControllerAnimated(true)
            }
        }
    }
    
    func callChangeWifi()
    {
        let obj = privateStoryBoard.instantiateViewControllerWithIdentifier("EnterWifiVC") as! EnterWifiVC
        self.navigationController?.pushViewController(obj, animated: true)
    }
}

extension ManageDevicesVC
{
    func callDeviceLog(x : String, y : Int)
    {
        
        self.activityLoader(true)
        let url = PRIVATE_URL_BASE+"/\(x)"+"/app/private/devices"
        print(url)
        
        request(.GET, url, parameters: nil, encoding: .JSON, headers: header).responseJSON { (response : Response<AnyObject, NSError>) -> Void in
            
            //SVProgressHUD.dismiss()
            self.activityLoader(false)
            
            if (response.result.value != nil)
            {
                //print(response.result.value)
                
                if response.result.value is NSDictionary
                {
                    showAlert("Can't fetch data. Try again later")
                    self.tableView.hidden = true
                }
                else
                {
                    let dic = response.result.value as! NSArray
                    self.deviceArray = NSMutableArray(array: dic)
                    self.tableView.reloadData()
                }
            }
            else
            {
                showAlert("Can't fetch data. Try again later")
                self.tableView.hidden = true
            }
        }
    }
}

extension PrivateAnalyticsVC
{
    func callWeekData()
    {
        print(URL_device_data_week+appDelegate.deviceId)
        
        //SVProgressHUD.showWithStatus("Loading...")
        activityLoader(true)
        
        request(.GET, URL_device_data_week+appDelegate.deviceId, parameters: nil, encoding: .JSON, headers: header).responseJSON { (response : Response<AnyObject, NSError>) -> Void in
            
            ////SVProgressHUD.dismiss()
            self.activityLoader(false)
            
            if (response.result.value != nil)
            {
                //print(response.result.value)
                
                if response.result.value is NSDictionary
                {
                    showAlert("No Data")
                }
                else
                {
                    let array = response.result.value as! NSArray
                    self.allDataArray = NSMutableArray(array: array)
                    
                    //print(self.allDataArray)
                    
                    /*
                     for i in 0...167
                     {
                         if 0...23 ~= i
                         {
                             let obj = array[i]["aqi"] as! NSNumber
                             self.dataArray.addObject(obj)
                         }
                         else if 0...167 ~= i
                         {
                             let obj = array[i]["aqi"] as! NSNumber
                             self.monthArray.addObject(obj)
                         }
                     }
                     */
                    
                    for i in 0...array.count-1
                    {
                        if 0...23 ~= i
                        {
                            let obj = array[i]["aqi"] as! NSNumber
                            self.dataArray.addObject(obj)
                        }
                        else if 0...array.count-1 ~= i
                        {
                            let obj = array[i]["aqi"] as! NSNumber
                            self.monthArray.addObject(obj)
                        }
                    }
                    
                    if array.count != 0
                    {
                        let obj = NSMutableDictionary(dictionary: array[0]["payload"]!["d"] as! NSDictionary)
                        obj.removeObjectForKey("t")
                        
                        if obj.valueForKey("hum") != nil
                        {
                            let string : String = nf.stringFromNumber(obj.valueForKey("hum") as! NSNumber)!
                            NSNotificationCenter.defaultCenter().postNotificationName("hum2", object: nil, userInfo: ["per":string])
                            obj.removeObjectForKey("hum")
                        }
                        
                        if obj.valueForKey("temp") != nil
                        {
                            let string : String = nf.stringFromNumber(obj.valueForKey("temp") as! NSNumber)!
                            NSNotificationCenter.defaultCenter().postNotificationName("temp2", object: nil, userInfo: ["per":string])
                            obj.removeObjectForKey("temp")
                        }
                        
                        if obj.valueForKey("noise") != nil
                        {
                            obj.removeObjectForKey("noise")
                        }
                        
                        self.bottomData = obj
                        //print(self.bottomData)
                        //print(self.bottomData.count)
                        self.collevtionView.reloadData()
                    }

                    
                    self.chartViewProperty(0)
                    self.lineChartViewProperty(0)
                    
                    self.collevtionView.reloadData()
                }
            }

                }
                
                
            }
}


extension AnalyticsVC
{
    func callWeekData()
    {
        print(URL_device_data_week+appDelegate.gDeviceId)
        
        //SVProgressHUD.showWithStatus("Loading...")
        activityLoader(true)
        request(.GET, URL_device_data_week+appDelegate.gDeviceId, parameters: nil, encoding: .JSON, headers: header).responseJSON { (response : Response<AnyObject, NSError>) -> Void in
            
            //SVProgressHUD.dismiss()
            self.activityLoader(false)
            
            if (response.result.value != nil)
            {
                
                if response.result.value is NSDictionary
                {
                   
                }
                else
                {
                    //print(response.result.value)
                    
                    let array = response.result.value as! NSArray
                    self.allDataArray = NSMutableArray(array: array)
                    
                    //print(self.allDataArray)
                    
                    if array.count-1 > 11
                    {
                        for i in 0...array.count-1
                        {
                            if 0...23 ~= i
                            {
                                let obj = array[i]["aqi"] as! NSNumber
                                self.dataArray.addObject(obj)

                            }
                            else if 0...array.count-1 ~= i
                            {
                                let obj = array[i]["aqi"] as! NSNumber
                                self.monthArray.addObject(obj)
                            }
                        }
                    }
                    else
                    {
                        self.switchFlag = true
                    }
                    
                    self.chartViewProperty(0)
                    self.lineChartViewProperty(0)
                }
            }
        }
    }
}

extension PrivateHomeVC
{
    func refreshDevice(){
        
        print(URL_device_data_current+appDelegate.deviceId)
        
        //SVProgressHUD.showWithStatus("Loading...")
        activityLoader(true)
        request(.GET, URL_device_data_current+appDelegate.deviceId, parameters: nil, encoding: .JSON, headers: header).responseJSON { (response : Response<AnyObject, NSError>) -> Void in
            
            //SVProgressHUD.dismiss()
            self.activityLoader(false)
            
            if (response.result.value != nil)
            {
                
                //print(response.result.value)
                
                if response.result.value is NSDictionary
                {
                    showAlert("No records found")
                }
                else
                {
                    let array = response.result.value as! NSArray
                    
                    userArray = array
                    self.aqi = nf.stringFromNumber(array[0]["aqi"] as! NSNumber)!
                    self.reloadUI(0)
                    self.lblCityName.text = array[0]["label"] as? String
                }
                
            }
        }
    }
}

extension EnterWifiVC
{
    func callWifiReg()
    {
        //SVProgressHUD.showWithStatus("Loading...")
        activityLoader(true)
        
        let url = "http://192.168.12.1:8090/data?ssid=\(txtUserId.text!)&pass=\(txtPassword.text!)"
        let str = url.stringByReplacingOccurrencesOfString(" ", withString: "%20")
        //print(str)
        
        request(.POST, str, parameters: nil, encoding: .JSON, headers: header).responseJSON { (response : Response<AnyObject, NSError>) -> Void in
            
            //SVProgressHUD.dismiss()
            self.activityLoader(false)
            
            if (response.result.value != nil)
            {
                print(response.result.value)
            }
            else
            {
                let obj = privateStoryBoard.instantiateViewControllerWithIdentifier("ConfirmHomeNetworkVC") as! ConfirmHomeNetworkVC
                obj.imgName = self.imgName
                obj.proId = self.proId
                self.navigationController?.pushViewController(obj, animated: true)
            }
        }
    }
}

extension SignUpVC
{
    func callSignUpWeb()
    {
        //SVProgressHUD.showWithStatus("Loading...")
        activityLoader(true)
        
        let parameter = ["username":txtUserName.text!,"email":txtEmail.text!,"password":txtPassword.text!]
        
        request(.POST, URL_Signup, parameters: parameter, encoding: .JSON, headers: header).responseJSON { (response : Response<AnyObject, NSError>) -> Void in
            
            //SVProgressHUD.dismiss()
            self.activityLoader(false)
            
            if (response.result.value != nil)
            {
                print(response.result.value)
            }
        }
    }

}


extension LoginVC
{
    func callLoginWeb()
    {
        //SVProgressHUD.showWithStatus("Loading...")
        activityLoader(true)
        
        let parameter = ["email":txtUserName.text!,"password":txtPassword.text!]
        
        request(.POST, URL_Login, parameters: parameter, encoding: .JSON, headers: header).responseJSON { (response : Response<AnyObject, NSError>) -> Void in
            
            if (response.result.value != nil)
            {
                let dic = response.result.value as! NSDictionary
                
                let status = nf.stringFromNumber(dic["status"] as! NSNumber)
                
                if status != "200"
                {
                    //SVProgressHUD.dismiss()
                    self.activityLoader(false)
                    showAlert(dic["message"] as! String)
                }
                else
                {
                    //print(dic)
                appDelegate.isPrivate = true
                appDelegate.userEmail = self.txtUserName.text!
                appDelegate.userPassword = self.txtPassword.text!
                    
                NSUserDefaults.standardUserDefaults().setValue(appDelegate.userEmail, forKey: "userEmail")
                NSUserDefaults.standardUserDefaults().setValue(appDelegate.userPassword, forKey: "userPass")
                    appDelegate.userId = dic["userId"] as! String
                NSUserDefaults.standardUserDefaults().setValue(appDelegate.userId, forKey: "userId")
                
                self.callDeviceLog(appDelegate.userId,y: 0)
                }
            }
        }
    }
    
    func googLogin(id:String,email:String)
    {
        
        activityLoader(true)
        
        appDelegate.userEmail = email
        appDelegate.userId = id
        appDelegate.userPassword = ""
        
        NSUserDefaults.standardUserDefaults().setValue(appDelegate.userEmail, forKey: "userEmail")
        NSUserDefaults.standardUserDefaults().setValue(appDelegate.userPassword, forKey: "userPass")
        NSUserDefaults.standardUserDefaults().setValue(appDelegate.userId, forKey: "userId")
        
        self.callDeviceLog(appDelegate.userId,y: 0)
    }
    
    func switchFailed(x:String,y:String)
    {
        self.activityLoader(true)
        let url = PRIVATE_URL_BASE+"/\(x)"+"/app/private/devices"
        print(url)
        
        request(.GET, url, parameters: nil, encoding: .JSON, headers: header).responseJSON { (response : Response<AnyObject, NSError>) -> Void in
            
            //SVProgressHUD.dismiss()
            self.activityLoader(false)
            
            if (response.result.value != nil)
            {
                if response.result.value is NSDictionary
                {
                    showAlert("Switch failed")
                }
                else
                {
                    let array = NSMutableArray(array: response.result.value as! NSArray)
                    
                    print(array)
                    
                    for i in 0...array.count-1
                    {
                        let dic = array[i] as! NSDictionary
                        print(dic)
                        
                        if dic.valueForKey("deviceId") as! String == y
                        {
                            appDelegate.deviceId = y
                            
                            let obj = privateStoryBoard.instantiateViewControllerWithIdentifier("MainNavigationController")
                            UIView.transitionWithView(appDelegate.window!, duration: 1, options: UIViewAnimationOptions.TransitionNone, animations: {
                                appDelegate.window?.rootViewController = obj
                                }, completion: nil)
                            
                            oneDevice = NSArray(object: dic)
                            appDelegate.oneDev = true
                            userArray = array
                        }
                        else
                        {
                            
                        }
                    }
                }
            }
        }
    }
    
    func switchDevice(devId: String)
    {
        //let url = URL_device_data_current+appDelegate.deviceId
        let url = URL_device_data_current+devId
        activityLoader(true)
        
        request(.GET, url, parameters: nil, encoding: .JSON, headers: header).responseJSON { (response : Response<AnyObject, NSError>) -> Void in
            
            self.activityLoader(false)
            
            if (response.result.value != nil)
            {
                //print(response.result.value)
                
                if response.result.value is NSDictionary
                {
                    //showAlert(response.result.value!["message"] as! String)
                    self.switchFailed(appDelegate.userId, y: devId)
                }
                else
                {
                    appDelegate.oneDev = false
                    appDelegate.deviceId = devId
                    let dic = response.result.value as! NSArray
                    
                    let obj = privateStoryBoard.instantiateViewControllerWithIdentifier("MainNavigationController")
                    
                    userArray = dic
                    
                    UIView.transitionWithView(appDelegate.window!, duration: 1, options: UIViewAnimationOptions.TransitionNone, animations: {
                        appDelegate.window?.rootViewController = obj
                        }, completion: nil)
                    
                    self.callDeviceLog(appDelegate.userId, y: 1)
                }
            }
            else
            {
                
            }
        }
    }
    
    func callDeviceLog(x : String, y : Int)
    {
        
        self.activityLoader(true)
        let url = PRIVATE_URL_BASE+"/\(x)"+"/app/private/devices"
        print(url)
        
        request(.GET, url, parameters: nil, encoding: .JSON, headers: header).responseJSON { (response : Response<AnyObject, NSError>) -> Void in
            
            //SVProgressHUD.dismiss()
            self.activityLoader(false)
            
            if (response.result.value != nil)
            {
                print(response.result.value)
                let dic = response.result.value as! NSArray
                
                if dic.count != 0
                {
                    if y != 1
                    {
                        SVProgressHUD.dismiss()
                        let obj = privateStoryBoard.instantiateViewControllerWithIdentifier("MainNavigationController")
                        
                        userArray = dic
                        
                        UIView.transitionWithView(appDelegate.window!, duration: 1, options: UIViewAnimationOptions.TransitionFlipFromRight, animations: {
                            appDelegate.window?.rootViewController = obj
                            }, completion: nil)
                    }
                    else
                    {
                        privateDev = dic
                        appDelegate.flag = false
                    }
                }
                else
                {
                    let obj = privateStoryBoard.instantiateViewControllerWithIdentifier("proNav")
                    UIView.transitionWithView(appDelegate.window!, duration: 1, options: UIViewAnimationOptions.TransitionFlipFromRight, animations: {
                        appDelegate.window?.rootViewController = obj
                        }, completion: nil)
                }
            }
            else
            {
                showAlert("Can't fetch user data. Try again later")
                appDelegate.isPrivate = false
                appDelegate.switchGlobalMode(1)
            }
        }
    }
}

extension HomeVC
{
    func getDeviceData(){
        
        print(URL_device_data_current+appDelegate.gDeviceId)
        
        //SVProgressHUD.showWithStatus("Loading...")
        activityLoader(true)
        request(.GET, URL_device_data_current+appDelegate.gDeviceId, parameters: nil, encoding: .JSON, headers: header).responseJSON { (response : Response<AnyObject, NSError>) -> Void in
            
            //SVProgressHUD.dismiss()
            self.activityLoader(false)
            
            if (response.result.value != nil)
            {
                //print(response.result.value)
                if response.result.value is NSDictionary
                {
                    showAlert("No data found. Try again later!")
                }
                else
                {
                    let array = response.result.value as! NSArray
                    self.aqi = nf.stringFromNumber(array[0]["aqi"] as! NSNumber)!
                    self.reloadUI((nf.numberFromString(self.aqi)?.integerValue)!)
                    self.lblCityName.text = array[0]["label"] as? String
                    
                    let abc = nf.numberFromString(array[0]["payload"]!?["d"]!?["t"] as! String)?.doubleValue
                    let fullDate = NSDate(timeIntervalSince1970: abc!)
                    
                    df.dateFormat = "dd MMM"
                    self.date = df.stringFromDate(fullDate)
                    df.dateFormat = "HH:mm"
                    self.time = df.stringFromDate(fullDate)
                    
                    self.btnDate.setTitle(self.time, forState: .Normal)
                    self.btnTime.setTitle(self.date, forState: .Normal)
                    
                    appDelegate.city = (array[0]["label"] as? String)!
                }
            }
            else
            {
                let deviceArray = ModelManager.getInstance().getAllData()
                //print(deviceArray)
                showAlert("Check internet connection & try again!")
                
                if deviceArray.count != 0
                {
                    for i in 0...deviceArray.count-1
                    {
                        let obj = deviceArray[i] as! DeviceInfo
                        
                        if appDelegate.gDeviceId == obj.device_id
                        {
                            self.reloadUI(obj.aqi)
                            self.aqi = nf.stringFromNumber(obj.aqi)!
                            self.lblCityName.text = obj.device_name
                            appDelegate.city = obj.device_name
                            
                            self.btnTime.setTitle("N/A", forState: .Normal)
                            self.btnDate.setTitle("N/A", forState: .Normal)
                        }
                        /*
                         self.aqi = nf.stringFromNumber(array[0]["aqi"] as! NSNumber)!
                         self.reloadUI((nf.numberFromString(self.aqi)?.integerValue)!)
                         self.lblCityName.text = array[0]["label"] as? String
                         
                         let abc = nf.numberFromString(array[0]["payload"]!?["d"]!?["t"] as! String)?.doubleValue
                         let fullDate = NSDate(timeIntervalSince1970: abc!)
                         
                         df.dateFormat = "dd MMM"
                         self.date = df.stringFromDate(fullDate)
                         df.dateFormat = "HH:mm"
                         self.time = df.stringFromDate(fullDate)
                         
                         self.btnDate.setTitle(self.time, forState: .Normal)
                         self.btnTime.setTitle(self.date, forState: .Normal)
                         
                         appDelegate.city = (array[0]["label"] as? String)!
                         */
                    }
                }
                else
                {
                
                }
            }
        }
    }
}

extension CitiesVC
{
    func getAllDeviceData(){
        
        //SVProgressHUD.showWithStatus("Loading...")
        activityLoader(true)
        request(.GET, URL_ALLDevice, parameters: nil, encoding: .JSON, headers: header).responseJSON { (response : Response<AnyObject, NSError>) -> Void in
            
            //SVProgressHUD.dismiss()
            self.activityLoader(false)
            
            if (response.result.value != nil)
            {
                aqiArrayHelper = response.result.value as! NSArray
                self.tableView.reloadData()
            }
        }
    }
}

extension AddCityMapVC
{
    func getAllDeviceData(){
        
        //SVProgressHUD.showWithStatus("Loading...")
        activityLoader(true)
        request(.GET, URL_ALLDevice, parameters: nil, encoding: .JSON, headers: header).responseJSON { (response : Response<AnyObject, NSError>) -> Void in
            
            ////SVProgressHUD.dismiss()
            self.activityLoader(false)
            
            if (response.result.value != nil)
            {
                self.arrayAllDevice = response.result.value as! NSArray
                self.updateUI()
                self.getAllCitiesWithDevices()
                
                aqiArrayHelper = self.arrayAllDevice 
            }
        }
    }
    
    func getAllCitiesWithDevices()
    {
        
        //SVProgressHUD.showWithStatus("Loading")
        activityLoader(true)
        request(.GET, URL_AllCities, parameters: nil, encoding: .JSON, headers: header).responseJSON { (response : Response<AnyObject, NSError>) -> Void in
            
            ////SVProgressHUD.dismiss()
            self.activityLoader(false)
            
            if (response.result.value != nil)
            {
                let array = response.result.value!
                
                if array is NSDictionary
                {
                    showAlert("Tree view failed. No response!")
                }
                else
                {
                    self.arrayAllCities = NSArray(array: array as! [AnyObject])
                    self.listAllCities()
                }
            }
        }
        
        
    }
    
}

extension EnterSerialVC
{
    func callDeviceReg()
    {
        activityLoader(true)
        
        let url = PRIVATE_URL_BASE + "/" + appDelegate.userId + "/devices"
        print(url)
        
        let tempHead = ["air-quality-india-app":"no-auth"]
        
        let parameters = ["deviceId":txtSerialId.text!,"label":lblProduct.text!+"_"+txtSerialId.text!,"latitude":self.lat,"longitude":self.long,"city":self.city,"country":self.country,"loc":self.city,"type":proType]

        print(parameters)
        
        request(.POST, url, parameters: parameters, encoding: .JSON, headers: tempHead).responseJSON { (response : Response<AnyObject, NSError>) -> Void in
            
            self.activityLoader(false)
            
            if (response.result.value != nil)
            {
                //print(response.result.value)
                
                if let status = response.result.value!["status"] as? Int
                {
                    if status != 201
                    {
                        showAlert((response.result.value!["message"] as? String)!)
                    }
                    else
                    {
                        let obj = privateStoryBoard.instantiateViewControllerWithIdentifier("EnterWifiVC") as! EnterWifiVC
                        obj.prodName = self.lblProduct.text!
                        obj.imgName = self.imgName
                        obj.proId = self.lblProduct.text!+"_"+self.txtSerialId.text!
                        self.navigationController?.pushViewController(obj, animated: true)
                    }
                }
                else
                {
                    showAlert((response.result.value!["message"] as? String)!)
                }
            }
            else
            {
                
            }
        }
    }

}
