//
//  PopupCurrentOrderController.swift
//  SnowMowr
//
//  Created by Lokesh Dudhat on 19/11/15.
//  Copyright © 2015 com.letsnurture. All rights reserved.
//

import UIKit


class PopupOPTCode: MyPopupController {

    @IBOutlet weak var txtVerifyOPT: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func btnCancelClick(sender: UIButton) {
        
        if (self.pressCancel != nil) {
            self.pressCancel!()
        }
    }
    
    @IBAction func btnEditClicked(sender: UIButton) {
        if (self.pressCancel != nil) {
            self.pressCancel!()
        }

    }

    @IBAction func btnOkClick(sender: UIButton) {
        if (self.pressOK != nil) {
            
            self.pressOK!()
        }
    }

    @IBAction func btnResendClicked(sender: UIButton) {
    }

}
