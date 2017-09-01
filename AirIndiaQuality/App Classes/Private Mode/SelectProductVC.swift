//
//  SelectProductVC.swift
//  AirQualityIndia
//
//  Created by Shivang Dave on 26/09/16.
//  Copyright © 2016 Shivang Dave. All rights reserved.
//

import UIKit

class SelectProductVC: UIViewController {
    
    @IBOutlet weak var btnOne : UIButton!
    @IBOutlet weak var btnTwo : UIButton!
    @IBOutlet weak var btnThree : UIButton!
    @IBOutlet weak var btnFour : UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        btnOne.imageView?.contentMode = .ScaleAspectFit
        btnTwo.imageView?.contentMode = .ScaleAspectFit
        btnThree.imageView?.contentMode = .ScaleAspectFit
        btnFour.imageView?.contentMode = .ScaleAspectFit
    }

    override func viewWillAppear(animated: Bool) {
        self.navigationItem.title = "Add Device"
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func btnFirstProductClicked(sender:AnyObject)
    {
        let obj = privateStoryBoard.instantiateViewControllerWithIdentifier("EnterSerialVC") as! EnterSerialVC
        obj.imgName = "pol"
        self.navigationController?.pushViewController(obj, animated: true)
    }
    
    @IBAction func btnSecondProductClicked(sender:AnyObject)
    {
        let obj = privateStoryBoard.instantiateViewControllerWithIdentifier("EnterSerialVC") as! EnterSerialVC
        obj.imgName = "bre"
        self.navigationController?.pushViewController(obj, animated: true)
    }
    
    @IBAction func btnThirdProductClicked(sender:AnyObject)
    {
        let obj = privateStoryBoard.instantiateViewControllerWithIdentifier("EnterSerialVC") as! EnterSerialVC
        obj.imgName = "3g"
        self.navigationController?.pushViewController(obj, animated: true)
    }
    
    @IBAction func btnFourthProductClicked(sender:AnyObject)
    {
        let obj = privateStoryBoard.instantiateViewControllerWithIdentifier("EnterSerialVC") as! EnterSerialVC
        obj.imgName = "wi"
        self.navigationController?.pushViewController(obj, animated: true)
    }
    
}
