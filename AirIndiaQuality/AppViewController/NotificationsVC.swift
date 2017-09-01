//
//  NotificationsVC.swift
//  AirIndiaQuality
//
//  Created by Shivang Dave on 04/09/16.
//  Copyright © 2016 Shivang Dave. All rights reserved.
//

import UIKit

class notificationCell : UITableViewCell
{
    @IBOutlet weak var lblTitle: UILabel!
}

class NotificationsVC: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var sliderSensitivity: UISlider!
    @IBOutlet weak var tableView: UITableView!
    
    var titleArray = ["Indoor","Outdoor","Both","Smart Notification","Morning Report","Evening"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        backButton()
        title = "Notifications"
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titleArray.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("notificationCell") as! notificationCell
        cell.lblTitle.text = titleArray[indexPath.row]
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    }
    
    @IBAction func sliderSlides(sender: AnyObject) {
    }
    
    @IBAction func SwitchClick(sender: AnyObject) {
    }
    
    
}
