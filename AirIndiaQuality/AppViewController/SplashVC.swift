//
//  SplashVC.swift
//  AirQualityIndia
//
//  Created by Shivang Dave on 05/09/16.
//  Copyright © 2016 Shivang Dave. All rights reserved.
//

import UIKit

class SplashVC: UIViewController {
    
    @IBOutlet weak var bottomConst : NSLayoutConstraint!
    @IBOutlet weak var centerConst : NSLayoutConstraint!
    @IBOutlet weak var imgView : UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
              NSTimer.scheduledTimerWithTimeInterval(1.5, target: self, selector: #selector(SplashVC.moveToNext), userInfo: nil, repeats: false)
        initActivityLoader("Assets All_Loader_Oizom", LableName: "LOADING", color: false)
    }
    
    override func viewWillAppear(animated: Bool) {
        UIView.animateWithDuration(1.5) { 
            self.bottomConst.priority = 999
            self.centerConst.priority = 1000
            self.view.setNeedsUpdateConstraints()
            self.imgView.superview?.layoutIfNeeded()
        }
    }
    
    func moveToNext()
    {
        if let lastMode = NSUserDefaults.standardUserDefaults().valueForKey("lastMode") as? String
        {
            if lastMode != ""
            {
                if lastMode == "0"
                {
                    if NSUserDefaults.standardUserDefaults().valueForKey("gdevId") != nil
                    {
                        appDelegate.gDeviceId = (NSUserDefaults.standardUserDefaults().valueForKey("gdevId") as? String)!
                        appDelegate.switchGlobalMode(1)
                    }
                    else
                    {
                        appDelegate.switchMap()
                    }
                   
                }
                else
                {
                    appDelegate.gDeviceId = (NSUserDefaults.standardUserDefaults().valueForKey("gdevId") as? String)!
                    appDelegate.userEmail = (NSUserDefaults.standardUserDefaults().valueForKey("userEmail") as? String)!
                    appDelegate.userPassword = (NSUserDefaults.standardUserDefaults().valueForKey("userPass") as? String)!
                    activityLoader(true)
                    appDelegate.switchPrivateMode()
                }
            }
            else
            {
                appDelegate.switchMap()
            }
        }
        else
        {
            appDelegate.switchMap()
        }

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
