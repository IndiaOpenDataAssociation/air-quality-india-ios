//
//  ChangePasswordVC.swift
//  AirIndiaQuality
//
//  Created by Shivang Dave on 04/09/16.
//  Copyright © 2016 Shivang Dave. All rights reserved.
//

import UIKit

class ChangePasswordVC: UIViewController {

    @IBOutlet weak var txtOldPassword : UITextField!
    @IBOutlet weak var txtNewPassword : UITextField!
    @IBOutlet weak var txtConPassword : UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        backButton()
        title = "Change Password"
        // Do any additional setup after loading the view.
    }

    @IBAction func btnConfirmChangePw(sender: AnyObject) {
        if validation()
        {
            print("valid")
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func validation() -> Bool
    {
        if isEmptyString(txtOldPassword.text!) || isEmptyString(txtNewPassword.text!) || isEmptyString(txtConPassword.text!)
        {
            showAlert(popUpMessage.emptyPassword.rawValue)
            return false
        }
        else if txtOldPassword.text != appDelegate.userPassword
        {
            showAlert("Old password is wrong! Try again.")
            return false
        }
        else if txtNewPassword.text != txtConPassword.text
        {
            showAlert("Password do not match.")
            return false
        }
        return true
    }

}
