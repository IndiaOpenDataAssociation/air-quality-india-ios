//
//  ComDevicesVC.swift
//  AirIndiaQuality
//
//  Created by Shivang Dave on 28/08/16.
//  Copyright © 2016 Shivang Dave. All rights reserved.
//

import UIKit

class deviceCell: UITableViewCell {
    @IBOutlet weak var imgView : UIImageView!
}

class ComDevicesVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var webView: UIWebView!
    @IBOutlet weak var tblDeviceList : UITableView!
    
    let imgArray = ["img_device_airowl","img_device_breathi","img_device_polludron"]

    override func viewDidLoad() {
        super.viewDidLoad()

        initActivityLoader("Assets All_Loader_Oizom", LableName: "LOADING", color: true)
        
        let url = NSURLRequest(URL: NSURL(string: "http://oizom.com/devices")!)
        webView.loadRequest(url)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func webViewDidStartLoad(webView: UIWebView) {
        activityLoader(true)
    }
    
    func webViewDidFinishLoad(webView: UIWebView) {
        activityLoader(false)
    }

    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tblDeviceList.dequeueReusableCellWithIdentifier("deviceCell") as! deviceCell
        cell.imgView.image = UIImage(named: imgArray[indexPath.row])
        return cell
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 180.0
    }
    
    func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.row == 0
        {
            let alert = UIAlertController(title: "Are you sure?", message: "You are leaving the app.", preferredStyle: .Alert)
            let yes = UIAlertAction(title: "Yes", style: .Default, handler: { (action) in
                UIApplication.sharedApplication().openURL(NSURL(string: "http://openenvironment.indiaopendata.com/#/airowl/")!)
            })
            let no = UIAlertAction(title: "No", style: .Default, handler: { (action) in
                self.dismissViewControllerAnimated(true, completion: nil)
            })
            
            alert.addAction(no)
            alert.addAction(yes)
            
            self.presentViewController(alert, animated: true, completion: nil)
        }
        else if indexPath.row == 2
        {
            let alert = UIAlertController(title: "Are you sure?", message: "You are leaving the app.", preferredStyle: .Alert)
            let yes = UIAlertAction(title: "Yes", style: .Default, handler: { (action) in
                UIApplication.sharedApplication().openURL(NSURL(string: "https://oizom.com/polludrone-air-quality-monitoring")!)
            })
            let no = UIAlertAction(title: "No", style: .Default, handler: { (action) in
                self.dismissViewControllerAnimated(true, completion: nil)
            })
            alert.addAction(no)
            alert.addAction(yes)
            
            self.presentViewController(alert, animated: true, completion: nil)
            
        }
    }
    
}
