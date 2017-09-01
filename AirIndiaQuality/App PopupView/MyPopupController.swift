//
//  MyPopupController.swift
//  SnowMowr
//
//  Created by Lokesh Dudhat on 20/11/15.
//  Copyright © 2015 com.letsnurture. All rights reserved.
//

import Foundation
import UIKit

class MyPopupController: UIViewController {
    var pressOK : (()-> ())?
    var pressCancel : (()-> ())?
    
    override func viewDidLoad() {
        appDelegate.window?.endEditing(true)
        super.viewDidLoad()
        self.view.layer.cornerRadius = 10
        self.view.layer.masksToBounds = true
        self.view.frame = {
            var frm = self.view.frame
            frm.size.width = UIScreen.mainScreen().bounds.width - 30
            return frm
        }()
    }
}