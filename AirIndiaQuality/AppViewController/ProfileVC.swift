//
//  ProfileVC.swift
//  AirIndiaQuality
//
//  Created by Shivang Dave on 25/08/16.
//  Copyright © 2016 Shivang Dave. All rights reserved.
//

import UIKit

class ProfileCell : UITableViewCell
{
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var imgView: UIImageView!
}

class ProfileVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    //PRIVATE
    //    let arrayTitle = ["Basic profile","Devices","Activities","Notifications","About us"]
    let arrayTitle = ["Basic profile","Devices","About us"]
    
    //    let arrayNav = ["BasicProfileVC","ManageDevicesVC","ActivitesVC","NotificationsVC","AboutUsVC"]
    let arrayNav = ["BasicProfileVC","ManageDevicesVC","AboutUsVC"]
    
    //    let imgArray = ["Assets All_Profile_Basic Profile","Assets All_Profile_manage device","Assets All_Profile_Activity","Assets All_Profile_Notifications","Assets All_Profile_About Oizom"]
    let imgArray = ["Assets All_Profile_Basic Profile","Assets All_Profile_manage device","Assets All_Profile_About Oizom"]
    
    //GLOBAL
    let arrayTitle1 = ["Basic profile","About us"]
    let arrayNav1 = ["BasicProfileVC","AboutUsVC"]
    let imgArray1 = ["Assets All_Profile_Basic Profile","Assets All_Profile_About Oizom"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

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
        var count = 0
        if appDelegate.isPrivate
        {
            count = 3
        }
        else
        {
            count = 2
        }
        return count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("ProfileCell") as! ProfileCell
        
        if appDelegate.isPrivate
        {
            cell.lblTitle.text = arrayTitle[indexPath.row]
            cell.imgView.image = UIImage(named: imgArray[indexPath.row])
        }
        else
        {
            cell.lblTitle.text = arrayTitle1[indexPath.row]
            cell.imgView.image = UIImage(named: imgArray1[indexPath.row])
        }
        
        return cell
    }
    
    func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if appDelegate.isPrivate
        {
            self.tableView.deselectRowAtIndexPath(indexPath, animated: true)
            let controll = mainStoryBoard.instantiateViewControllerWithIdentifier(arrayNav[indexPath.row])
            if arrayNav[indexPath.row] == "PrivateCitiesVC"
            {
                
            }
            self.navigationController?.pushViewController(controll, animated: true)
        }
        else
        {
            self.tableView.deselectRowAtIndexPath(indexPath, animated: true)
            let controll = mainStoryBoard.instantiateViewControllerWithIdentifier(arrayNav1[indexPath.row])
            if arrayNav1[indexPath.row] == "BasicProfileVC" && appDelegate.userEmail == ""
            {
                self.navigationController?.popToRootViewControllerAnimated(true)
                appDelegate.switchPrivateMode()
                tableView.reloadData()
            }
            else
            {
                self.navigationController?.pushViewController(controll, animated: true)
            }
        }
    }
    

}
