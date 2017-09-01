//
//  LoginVC.swift
//  AirQualityIndia
//
//  Created by Shivang Dave on 04/09/16.
//  Copyright © 2016 Shivang Dave. All rights reserved.
//

import UIKit
import FBSDKCoreKit
import FBSDKLoginKit

class LoginVC: UIViewController, GIDSignInDelegate, GIDSignInUIDelegate {
    
    @IBOutlet weak var txtUserName : UITextField!
    @IBOutlet weak var txtPassword : UITextField!
    
    @IBOutlet weak var checkBox : UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        GIDSignIn.sharedInstance().scopes.append("https://www.googleapis.com/auth/plus.login")
        GIDSignIn.sharedInstance().scopes.append("https://www.googleapis.com/auth/plus.me")
        GIDSignIn.sharedInstance().clientID = "423580570208-chqoftl0ccof6198lejrr3thhlbgjcb3.apps.googleusercontent.com"
    }
    
    override func viewWillAppear(animated: Bool) {
        initActivityLoader("Assets All_Loader_Oizom", LableName: "LOADING", color: false)
        self.navigationController?.navigationBar.hidden = true
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    func signIn(signIn: GIDSignIn!, didSignInForUser user: GIDGoogleUser!, withError error: NSError!) {
        if error != nil {
            print(error)
        }
        else {
            googLogin(user.userID, email: user.profile.email)
        }
    }
    
    @IBAction func btnSignInClicked(sender:AnyObject)
    {
        self.view.endEditing(true)
        if checkInternate() && validation()
        {
            callLoginWeb()
        }
    }
    
    @IBAction func btnCloseWindow(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func btnCheckBoxClicked(sender: AnyObject) {
        checkBox.selected = !checkBox.selected
        
        if checkBox.selected
        {
            txtPassword.secureTextEntry = false
        }
        else
        {
            txtPassword.secureTextEntry = true
        }
    }
    
    @IBAction func btnForgotPassWord(sender:AnyObject)
    {
        
    }
    
    @IBAction func btnSignInWithFaceBook(sender:AnyObject)
    {
        let login = FBSDKLoginManager()
        
        login.logInWithReadPermissions(["email"], fromViewController: self) { (result, error) in
            
            if (error != nil)
            {
                print(error)
            }
            else
            {
                //let x = result.token
                let fbreq = FBSDKGraphRequest(graphPath: "me", parameters: ["fields":"email"])
                fbreq.startWithCompletionHandler({ (connection, result, error) in
                    
                    if ((error) != nil)
                    {
                        // Process error
                        print("Error: \(error)")
                    }
                    else
                    {
                        let email = result.objectForKey("email") as! String
                        let id = result.objectForKey("id") as! String
                        
                        self.googLogin(id, email: email)
                    }
                    
                })
            }
            
        }
    }
    
    @IBAction func btnSignInWithGPlus(sender:AnyObject)
    {
        GIDSignIn.sharedInstance().delegate = self
        GIDSignIn.sharedInstance().uiDelegate = self
        GIDSignIn.sharedInstance().signIn()
    }
    
    func signIn(signIn: GIDSignIn!,
                presentViewController viewController: UIViewController!) {
        self.presentViewController(viewController, animated: true, completion: nil)
        
        print("Sign in presented")
        
    }
    
    func signIn(signIn: GIDSignIn!,
                dismissViewController viewController: UIViewController!) {
        self.dismissViewControllerAnimated(true, completion: nil)
        
        print("Sign in dismissed")
    }
    
    @IBAction func btnSignUpClicked(sender:AnyObject)
    {
        let obj = privateStoryBoard.instantiateViewControllerWithIdentifier("SignUpVC") as! SignUpVC
        self.navigationController?.pushViewController(obj, animated: true)
    }
    
    func validation() -> Bool
    {
        if isEmptyString(txtUserName.text!)
        {
            showAlert(popUpMessage.emptyUsername.rawValue)
            return false
        }
        else if isEmptyString(txtPassword.text!)
        {
            showAlert(popUpMessage.emptyPassword.rawValue)
            return false
        }
        return true
    }
}
