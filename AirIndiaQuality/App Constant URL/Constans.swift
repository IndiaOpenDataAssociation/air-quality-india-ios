//
//  Constans.swift
//  SnowMowr
//
//  Created by Lokesh Dudhat on 18/11/15.
//  Copyright © 2015 com.letsnurture. All rights reserved.
//

import Foundation
import UIKit

typealias blockComplition = () -> ()

struct ScreenSize
{
    static let SCREEN_WIDTH         = UIScreen.mainScreen().bounds.size.width
    static let SCREEN_HEIGHT        = UIScreen.mainScreen().bounds.size.height
    static let SCREEN_MAX_LENGTH    = max(ScreenSize.SCREEN_WIDTH, ScreenSize.SCREEN_HEIGHT)
    static let SCREEN_MIN_LENGTH    = min(ScreenSize.SCREEN_WIDTH, ScreenSize.SCREEN_HEIGHT)
}

struct DeviceType
{
    static let IS_IPHONE_4_OR_LESS  = UIDevice.currentDevice().userInterfaceIdiom == .Phone && ScreenSize.SCREEN_MAX_LENGTH < 568.0
    static let IS_IPHONE_5          = UIDevice.currentDevice().userInterfaceIdiom == .Phone && ScreenSize.SCREEN_MAX_LENGTH == 568.0
    static let IS_IPHONE_6          = UIDevice.currentDevice().userInterfaceIdiom == .Phone && ScreenSize.SCREEN_MAX_LENGTH == 667.0
    static let IS_IPHONE_6P         = UIDevice.currentDevice().userInterfaceIdiom == .Phone && ScreenSize.SCREEN_MAX_LENGTH == 736.0
    static let IS_IPAD              = UIDevice.currentDevice().userInterfaceIdiom == .Pad && ScreenSize.SCREEN_MAX_LENGTH == 1024.0
    static let IS_IPAD_PRO          = UIDevice.currentDevice().userInterfaceIdiom == .Pad && ScreenSize.SCREEN_MAX_LENGTH == 1366.0
}

let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate

let popupStoryBoard = UIStoryboard(name: "Popup", bundle: nil)
let mainStoryBoard = UIStoryboard(name: "Main", bundle: nil)
let privateStoryBoard = UIStoryboard(name: "Private", bundle: nil)

let nf = NSNumberFormatter()

func showAlert(message: String)
{
    appDelegate.window!.makeToast(message: message , duration: 2, position: HRToastPositionCenter)
}

func checkInternate() -> Bool
{
    let status = Reach().connectionStatus()
    switch status {
    case .Unknown, .Offline:
        
        let alert = UIAlertController(title: "No Internet Connection", message: "Make sure your device is connected to the internet.", preferredStyle: .Alert)
        let okay = UIAlertAction(title: "Okay", style: .Default, handler: { (action) in
            appDelegate.window?.rootViewController?.dismissViewControllerAnimated(true, completion: nil)
        })
        alert.addAction(okay)
        appDelegate.window?.rootViewController?.presentViewController(alert, animated: true, completion: nil)
        return false
        
    case .Online(.WWAN), .Online(.WiFi):
        return true
    }
}

func validePhoneNumber(text : NSString)->Bool
{
    if text.length < 8 || text.length > 15
    {
        return true
    }
    else
    {
        return false
    }
}

func validePassword(text : NSString) ->Bool
{
    
    if text.length < 6 || text.length > 21
    {
        return true
    }
    else if text.length != 0
    {
        let emailRegEx = ".*[^A-Za-z0-9].*"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return !emailTest.evaluateWithObject(text)
    }
    else{
        return false
    }
}

extension UIViewController {
    
    func backButton() {
        
        let barButton = UIBarButtonItem()
        barButton.title = ""
        barButton.tintColor = UIColor.navigationTitleColor()
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = barButton
    }
    
    func leftMenuButton()
    {
        let btn = UIButton(frame: CGRectMake(0, 0, 30, 30))
        btn.setImage(UIImage(named: "Assets_Oizom Icon"), forState: .Normal)
        btn.addTarget(self, action: #selector(UIViewController.btnDidTapOpen as (UIViewController) -> () -> ()), forControlEvents: .TouchUpInside)
        let barbutton = UIBarButtonItem(customView: btn)
        self.navigationItem.leftBarButtonItem = barbutton
        
    }
    
    func btnDidTapOpen()
    {
        //showAlert("Oizom")
    }
    
    func rightMenuButton()
    {
        let btn = UIButton(frame: CGRectMake(0,0,30,30))
        btn.setImage(UIImage(named: "Assets_My Device-71"), forState: .Normal)
        btn.addTarget(self, action: #selector(UIViewController.btnGlobeClicked as (UIViewController) -> () -> ()), forControlEvents: .TouchUpInside)
        let barbutton = UIBarButtonItem(customView: btn)
        self.navigationItem.rightBarButtonItems = [barbutton]
    }
    
    func btnGlobeClicked()
    {
        appDelegate.switchGlobalMode(1)
    }
    
    func myDeviceButton()
    {
        let btn = UIButton(frame: CGRectMake(0,0,30,30))
        btn.setImage(UIImage(named: "community"), forState: .Normal)
        btn.addTarget(self, action: #selector(UIViewController.btnPrivateClicked as (UIViewController) -> () -> ()), forControlEvents: .TouchUpInside)
        let barbutton = UIBarButtonItem(customView: btn)
        self.navigationItem.rightBarButtonItems = [barbutton]
    }
    
    func btnPrivateClicked()
    {
        appDelegate.switchPrivateMode()
    }
}

func isEmptyString(text : NSString) -> Bool
{
    if text .isEqualToString("") || text.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet()) .isEmpty
    {
        return true
    }
    else
    {
        return false
    }
    
}

func validateEmailWithString(Email: NSString) -> Bool {
    let emailRegEx = "^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$"
    
    let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
    return !emailTest.evaluateWithObject(Email)
}

func verifyUrl (urlString: String?) -> Bool {
    //Check for nil
    if let urlString = urlString {
        // create NSURL instance
        if let url = NSURL(string: urlString) {
            // check if your application can open the NSURL instance
            return UIApplication.sharedApplication().canOpenURL(url)
        }
    }
    return false
}

func AlertShowWithOK(title : String, message : String) {
    let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
    alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Cancel, handler: nil))
    appDelegate.window?.rootViewController!.presentViewController(alert, animated: true, completion: nil)
}

func displayViewController(animationType: SLpopupViewAnimationType,nibName : String, blockOK : (() -> ())?,blockCancel : (() -> ())?) {
    let myPopupViewController:MyPopupController = popupStoryBoard.instantiateViewControllerWithIdentifier(nibName) as! MyPopupController
    myPopupViewController.pressOK = blockOK
    myPopupViewController.pressCancel = blockCancel
    appDelegate.window?.rootViewController!.presentpopupViewController(myPopupViewController, animationType: animationType, completion: { () -> Void in
        
    })
}



enum popUpMessage : String {
    case emptyString = "Please fill all the fild"
    case emptyFirstName =  "First name should not be blank"
    case emptyLastName =  "Last name should not be blank"
    case emptyPassword =  "Please enter password"
    case empttConPassword = "Please enter confirm password"
    case emptyEmailId =  "Please enter email ID"
    case emptyPhoneNo = "Phone number should not be blank"
    case emptyUsername = "Please enter valid username"
    case FirstName = "First name must have less than 31 characters"
    case LastName = "Last name must have less than 31 characters"
    case EmailId = "Oops! Invalid email. Please try again"
    case PhoneNo = "Please enter valid contact number"
    case Password = "Password must have more than 6 and less than 16 characters & should also contain special character!"
    case ConPassword = "Password and confirmed password must be the same"
}


//func viewShedowGreadient(cell : LetsView) -> LetsView
//{
//    cell.layer.masksToBounds = false
//    cell.layer.shadowOffset = CGSizeMake(-0.5, 0.5)
//    cell.layer.shadowRadius = 5
//    cell.layer.shadowOpacity = 0.3
//    
//    return cell
//}

