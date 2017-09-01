//
//  AppDelegate.swift
//  AirIndiaQuality
//
//  Created by Shivang Dave on 25/08/16.
//  Copyright © 2016 Shivang Dave. All rights reserved.
//

import UIKit
import FBSDKCoreKit
import FBSDKLoginKit
import Fabric
import Crashlytics

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var flag = true
    
    var deviceId = ""
    var gDeviceId = "" //Device ID for global
    var city = ""
    
    var userId = ""
    var isPrivate = false
    var oneDev = false
    
    var userEmail = ""
    var userPassword = ""

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        UIApplication.sharedApplication().statusBarStyle = .LightContent
        SVProgressHUD.setDefaultMaskType(.Black)
        IQKeyboardManager.sharedManager().enable = true
        Util.copyFile("Devices.sqlite")
        
        Fabric.sharedSDK().debug = true
        Fabric.with([Crashlytics.self])
        
        UINavigationBar.appearance().barTintColor = UIColor.navigationBarColor()
        UINavigationBar.appearance().translucent = false
        UINavigationBar.appearance().tintColor = UIColor.navigationTitleColor()
        if let font = UIFont(name: "Arial",size: 20.0) {
            UINavigationBar.appearance().titleTextAttributes = [NSForegroundColorAttributeName:UIColor.navigationTitleColor(),NSFontAttributeName: font]
        }
        
        return FBSDKApplicationDelegate.sharedInstance().application(application, didFinishLaunchingWithOptions: launchOptions)
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
        if self.isPrivate
        {
            NSUserDefaults.standardUserDefaults().setValue("1", forKey: "lastMode")
        }
        else
        {
            NSUserDefaults.standardUserDefaults().setValue("0", forKey: "lastMode")
        }
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }
    
    func application(application: UIApplication,
                     openURL url: NSURL, options: [String: AnyObject]) -> Bool {
        
        let googleDidHandle = GIDSignIn.sharedInstance().handleURL(url,
                                                                   sourceApplication: options[UIApplicationOpenURLOptionsSourceApplicationKey] as? String,
                                                                   annotation: options[UIApplicationOpenURLOptionsAnnotationKey])
        
        let facebookDidHandle = FBSDKApplicationDelegate.sharedInstance().application(
            application,
            openURL: url,
            sourceApplication: options[UIApplicationOpenURLOptionsSourceApplicationKey] as? String,
            annotation: options[UIApplicationOpenURLOptionsAnnotationKey])
        
        return googleDidHandle || facebookDidHandle
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    func shareActionSheet(image : String) ->(UIActivityViewController)
    {
        let activityItem1 : NSString = image
        
        let activityViewController : UIActivityViewController = UIActivityViewController(
            activityItems: [activityItem1], applicationActivities: nil)
        
        
        activityViewController.excludedActivityTypes = [
            UIActivityTypeAirDrop,
            UIActivityTypePostToWeibo,
            UIActivityTypePrint,
            UIActivityTypeAssignToContact,
            UIActivityTypeSaveToCameraRoll,
            UIActivityTypeAddToReadingList,
            UIActivityTypePostToFlickr,
            UIActivityTypePostToVimeo,
            UIActivityTypePostToTencentWeibo
        ]
        
        activityViewController.view.tintColor = UIColor.redColor()
        return activityViewController
    }
    
    func switchMap()
    {
        let obj = mainStoryBoard.instantiateViewControllerWithIdentifier("mainNavigation")
        appDelegate.window?.rootViewController = obj
    }
    
    func switchGlobalMode(x:Int)
    {
        userArray = []
        privateDev = []
        oneDevice = []
        
        let obj = mainStoryBoard.instantiateViewControllerWithIdentifier("MainNavigationController")
        appDelegate.isPrivate = false
        if let userId = NSUserDefaults.standardUserDefaults().valueForKey("userId") as? String
        {
            if userId != ""
            {
                if x == 1
                {
                    UIView.transitionWithView(self.window!, duration: 1, options: UIViewAnimationOptions.TransitionFlipFromLeft, animations: {
                        appDelegate.window?.rootViewController = obj
                        }, completion: nil)
                }
                else
                {
                    UIView.transitionWithView(self.window!, duration: 1, options: UIViewAnimationOptions.TransitionNone, animations: {
                        appDelegate.window?.rootViewController = obj
                        }, completion: nil)
                }
                
            }
            else
            {
                UIView.transitionWithView(self.window!, duration: 1, options: UIViewAnimationOptions.CurveEaseIn, animations: {
                    appDelegate.window?.rootViewController = obj
                    }, completion: nil)
            }

        }
        else
        {
            UIView.transitionWithView(self.window!, duration: 1, options: UIViewAnimationOptions.CurveEaseIn, animations: {
                appDelegate.window?.rootViewController = obj
                }, completion: nil)
        }
    }
    
    func goHome()
    {
        let obj = mainStoryBoard.instantiateViewControllerWithIdentifier("MainNavigationController")
        
        UIView.transitionWithView(self.window!, duration: 1,options: [], animations: {
            appDelegate.window?.rootViewController = obj
            }, completion: nil)

    }
    
    func switchPrivateMode()
    {
        
        if let uid = NSUserDefaults.standardUserDefaults().valueForKey("userId") as? String
        {
            if uid != ""
            {
                userId = uid
                appDelegate.gDeviceId = (NSUserDefaults.standardUserDefaults().valueForKey("gdevId") as? String)!
                appDelegate.userEmail = (NSUserDefaults.standardUserDefaults().valueForKey("userEmail") as? String)!
                appDelegate.userPassword = (NSUserDefaults.standardUserDefaults().valueForKey("userPass") as? String)!

                appDelegate.isPrivate = true
                NSTimer.scheduledTimerWithTimeInterval(1.5, target: self, selector: #selector(self.callDevice) , userInfo: nil, repeats: false)
            }
        }
        else
        {
            let obj = privateStoryBoard.instantiateViewControllerWithIdentifier("PrivateNavigation")
            appDelegate.window?.rootViewController?.presentViewController(obj, animated: true, completion: nil)

//            UIView.transitionWithView(self.window!, duration: 1, options: UIViewAnimationOptions.TransitionCurlUp, animations: {
//                //appDelegate.window?.rootViewController = obj
//                }, completion: nil)
        }
    }
    
    func callDevice()
    {
        let obj = privateStoryBoard.instantiateViewControllerWithIdentifier("LoginVC") as! LoginVC
        obj.callDeviceLog(userId,y: 0)
    }
    
    func switchDevice(devId: String)
    {
        let obj = privateStoryBoard.instantiateViewControllerWithIdentifier("LoginVC") as! LoginVC
        appDelegate.isPrivate = true
        obj.switchDevice(devId)
    }
    
    func logout()
    {
        let def = NSUserDefaults.standardUserDefaults()
        
        def.removeObjectForKey("userId")
        def.removeObjectForKey("userEmail")
        def.removeObjectForKey("userPass")
        def.synchronize()
        
        appDelegate.userEmail = ""
        appDelegate.userPassword = ""
        NSUserDefaults.standardUserDefaults().setValue("0", forKey: "lastMode")
    }
}

