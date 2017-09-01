//
//  AboutUsVC.swift
//  AirIndiaQuality
//
//  Created by Shivang Dave on 04/09/16.
//  Copyright © 2016 Shivang Dave. All rights reserved.
//

import UIKit

class AboutUsVC: UIViewController {
    
    @IBOutlet weak var txtView : UITextView!

    override func viewDidLoad() {
        super.viewDidLoad()
        backButton()
        title = "About Us"
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(animated: Bool) {
        txtView.scrollRangeToVisible(NSMakeRange(0, 0))
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


}
