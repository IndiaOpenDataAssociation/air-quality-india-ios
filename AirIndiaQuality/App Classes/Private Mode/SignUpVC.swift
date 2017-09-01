//
//  SignUpVC.swift
//  AirQualityIndia
//
//  Created by Shivang Dave on 04/09/16.
//  Copyright © 2016 Shivang Dave. All rights reserved.
//

import UIKit
import FBSDKLoginKit
import FBSDKCoreKit

class SignUpVC: UIViewController, GIDSignInDelegate, GIDSignInUIDelegate {
    
    @IBOutlet weak var txtEmail : UITextField!
    @IBOutlet weak var txtUserName : UITextField!
    @IBOutlet weak var txtPassword : UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.hidden = false
        backButton()
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(animated: Bool) {
        initActivityLoader("Assets All_Loader_Oizom", LableName: "LOADING", color: false)
    }
    
    @IBAction func btnSignUpClicked(sender:AnyObject)
    {
        self.view.endEditing(true)
        if checkInternate() && validation()
        {
            callSignUpWeb()
        }
    }
    
    @IBAction func btnGPLusClicked(sender:AnyObject)
    {
        GIDSignIn.sharedInstance().delegate = self
        GIDSignIn.sharedInstance().uiDelegate = self
        GIDSignIn.sharedInstance().signIn()
    }
    
    func signIn(signIn: GIDSignIn!, didSignInForUser user: GIDGoogleUser!, withError error: NSError!) {
        if error != nil {
            print(error)
        }
        else {
            
            let obj = privateStoryBoard.instantiateViewControllerWithIdentifier("LoginVC") as! LoginVC
            obj.googLogin(user.userID, email: user.profile.email)
        }
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
    
    @IBAction func btnFBClicked(sender:AnyObject)
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
                        
                        let obj = privateStoryBoard.instantiateViewControllerWithIdentifier("LoginVC") as! LoginVC
                        
                        obj.googLogin(id, email: email)
                    }
                    
                })
            }
            
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
        else if validePassword(txtPassword.text!)
        {
            showAlert(popUpMessage.Password.rawValue)
            return false
        }
        else if txtUserName.text != txtPassword.text
        {
            showAlert("Password do not match.")
            return false
        }
        return true
    }

}
