//
//  CommunityVC.swift
//  AirIndiaQuality
//
//  Created by Shivang Dave on 25/08/16.
//  Copyright © 2016 Shivang Dave. All rights reserved.
//

import UIKit

class CommunityVC: UIViewController {

    var knowledge : ComKnowladgeVC?
    var funFacts : ComFunFactsVC?
    var blogs : ComBlogVC?
    var devices : ComDevicesVC?
    
    var childView     : UIView!
    
    @IBOutlet weak var containerView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        knowledge = mainStoryBoard.instantiateViewControllerWithIdentifier("ComKnowladgeVC") as? ComKnowladgeVC
        blogs = mainStoryBoard.instantiateViewControllerWithIdentifier("ComBlogVC") as? ComBlogVC
        devices = mainStoryBoard.instantiateViewControllerWithIdentifier("ComDevicesVC") as? ComDevicesVC
        
        addViewControllerWith(knowledge!)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func btnSegmentClicked(sender: UISegmentedControl) {
        
        switch sender.selectedSegmentIndex {
        case 0:
            addViewControllerWith(knowledge!)
            break
        case 1:
            addViewControllerWith(blogs!)
            break
        case 2:
            addViewControllerWith(devices!)
            break
        default:
            break
        }
    }
    
    
    func addViewControllerWith(vc:UIViewController){
        if childView != nil{
            childView.removeFromSuperview()
        }
        vc.view.frame = containerView.bounds
        containerView.addSubview(vc.view)
        addChildViewController(vc)
        vc.didMoveToParentViewController(self)
        childView = vc.view
    }

}
