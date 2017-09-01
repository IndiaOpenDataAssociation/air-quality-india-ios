//
//  BasicProfileVC.swift
//  AirIndiaQuality
//
//  Created by Shivang Dave on 04/09/16.
//  Copyright © 2016 Shivang Dave. All rights reserved.
//

import UIKit

class BasicProfileVC: UIViewController {
    
    @IBOutlet weak var txtEmail : UITextField!
    @IBOutlet weak var txtPassword : UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        backButton()
        title = "Basic Profile"
       
    }
    
    @IBAction func btnChangePw(sender: AnyObject) {
        let obj = mainStoryBoard.instantiateViewControllerWithIdentifier("ChangePasswordVC") as! ChangePasswordVC
        self.navigationController?.pushViewController(obj, animated: true)
    }
    
    override func viewWillAppear(animated: Bool) {
        txtEmail.text = appDelegate.userEmail
        txtPassword.text = appDelegate.userPassword
        
        txtEmail.userInteractionEnabled = false
        txtPassword.userInteractionEnabled = false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func btnLogout(sender: AnyObject) {
        appDelegate.logout()
        appDelegate.switchGlobalMode(1)
    }
}
