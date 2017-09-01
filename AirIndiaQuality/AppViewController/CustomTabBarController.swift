//
//  CustomTabBarController.swift
//  ViaApp
//
//  Created by Lokesh on 27/07/16.
//  Copyright © 2016 LetsNurture. All rights reserved.
//

import UIKit

class CustomTabBarController: UITabBarController,UITabBarControllerDelegate
{
    override func viewDidLoad()
    {
        
        super.viewDidLoad()
        tabBar.addshadow()
        tabBar.translucent = false
        tabBar.barTintColor = UIColor.navigationBarColor()
        tabBar.tintColor = UIColor.whiteColor()
        tabBar.clipsToBounds = true
        self.delegate=self
        tabBar.backgroundImage = UIImage(named: "tab_bg")
        let width = CGFloat(UIScreen.mainScreen().bounds.size.width / tabBar.items!.count)
        let height = tabBar.frame.size.height
        tabBar.selectionIndicatorImage = getImageWithColor(UIColor.blackColor(), size: CGSizeMake(width, height))
        tabBar.addInnerShadow()
        
        for item in tabBar.items!
        {
            item.titlePositionAdjustment = UIOffsetMake(0, -5)
        }
        
        leftMenuButton()
        
        if appDelegate.isPrivate
        {
            rightMenuButton()
        }else
        {
            myDeviceButton()
        }
        
    }
    
    override func viewWillAppear(animated: Bool)
    {
        self.tabBar.itemPositioning = .Fill
        if appDelegate.isPrivate
        {
            self.navigationItem.title = "My Device"
        }
        else
        {
            self.navigationItem.title = "Global"
        }
    }
    
    func tabBarController(tabBarController: UITabBarController, didSelectViewController viewController: UIViewController)
    {
        if tabBarController.selectedIndex == 0 {
            if appDelegate.isPrivate
            {
                self.navigationItem.title = "My Device"
            }
            else
            {
                self.navigationItem.title = "Global"
            }
        }else if tabBarController.selectedIndex == 1 {
            self.navigationItem.title = "Analytics"
        }else if tabBarController.selectedIndex == 2 {
            if appDelegate.isPrivate
            {
                self.navigationItem.title = "Devices"
            }
            else
            {
                self.navigationItem.title = "Locations"
            }
        }else if tabBarController.selectedIndex == 3 {
            self.navigationItem.title = "Community"
        }else if tabBarController.selectedIndex == 4 {
            self.navigationItem.title = "Profile"
        }
    }
    
    func switchOne()
    {
        self.tabBarController?.selectedIndex = 0
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension UITabBar
{
    override public func sizeThatFits(size: CGSize) -> CGSize {
        super.sizeThatFits(size)
        var sizeThatFits = super.sizeThatFits(size)
        sizeThatFits.height = 55
        return sizeThatFits
    }
}
