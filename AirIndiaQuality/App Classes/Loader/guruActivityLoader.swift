//
//  guruActivityLoader.swift
//  Version 0.1
//
//  Created by Guruji on 29/07/16.
//  Copyright © 2016 Guruji. All rights reserved.


import UIKit

// background view for loader - main/parent view
let curtainView: UIView = UIView(frame: CGRectMake(0, 0, UIScreen.mainScreen().bounds.size.width, (appDelegate.window?.screen.bounds.size.height)!))
// view for loader - parent view for loader image
let activityView: UIView = UIView(frame: CGRectMake(0,0, 130, 130))
let activityImage: UIImageView = UIImageView(frame: CGRectMake(0, 0, 60, 60))
//let imgView : UIImageView = UIImageView(frame: CGRectMake(0, 0, 30, 30))
let imgView : UIImageView = UIImageView(frame: CGRectMake(0, 0, 50, 50))
//let loadingLabel: UILabel = UILabel(frame: CGRectMake(0,0,60,20))
let loadingLabel: UILabel = UILabel(frame: CGRectMake(0,0,0,0))

//let activityLoaderSpeed = 5
var show = false

extension UIViewController
{
//initializing a loader for view controller
    func initActivityLoader(imgName: String, LableName: String, color: Bool)
    {
        
        if color
        {
            activityView.center.x = curtainView.center.x
            activityView.center.y = curtainView.center.y - 50
            
            activityImage.center = activityView.center
        }
        else
        {
            activityView.center.x = curtainView.center.x
            activityView.center.y = curtainView.center.y
            
            activityImage.center = activityView.center
        }
        
        
        //loadingLabel.center = curtainView.center
        loadingLabel.frame.origin.y = activityImage.center.y - 5
        loadingLabel.frame.origin.x = activityImage.center.x - 30
        
        imgView.frame.origin.y = loadingLabel.frame.origin.y - 55
        imgView.frame.origin.x = loadingLabel.frame.origin.x + 5
        
        
        // Properties of Loader
        activityImage.frame.origin.y = activityView.frame.origin.y
        loadingLabel.text = LableName
        loadingLabel.textAlignment = .Center
        loadingLabel.textColor = UIColor.blackColor()
        loadingLabel.adjustsFontSizeToFitWidth = true
        loadingLabel.font = UIFont(name: "futura_medium_bt-webfont", size: 5)

        imgView.image = UIImage(named: imgName)?.imageWithRenderingMode(.AlwaysTemplate)
        if color
        {
            imgView.tintColor = UIColor.blackColor()
        }
        else
        {
            imgView.tintColor = UIColor.whiteColor()
        }
        
        // Changing color of Image
        activityImage.image = UIImage(named: "round4g")?.imageWithRenderingMode(.AlwaysTemplate)
        if color
        {
            activityImage.tintColor = UIColor.blackColor()
        }
        else
        {
            activityImage.tintColor = UIColor.whiteColor()
        }
        
        activityView.alpha = 0
        curtainView.alpha = 0
        activityImage.alpha = 0
        loadingLabel.alpha = 0
        imgView.alpha = 0
        
        view.addSubview(curtainView)
        view.addSubview(activityImage)
        view.addSubview(loadingLabel)
        view.addSubview(imgView)
        
        curtainView.backgroundColor = UIColor(netHex: 0xF0F0F0)
    }


    func activityLoader(isOn: Bool)
    {
        show = isOn
        if show
        {
            curtainView.alpha = 0
            activityView.alpha = 0.6
            activityImage.alpha = 1
            loadingLabel.alpha = 1
            imgView.alpha = 1
            
            rotateThis360()
        }
        else
        {
            UIView.animateWithDuration(0.6, animations: {
                curtainView.alpha = 0
                activityView.alpha = 0
                activityImage.alpha = 0
                loadingLabel.alpha = 0
                imgView.alpha = 0
            })
            activityImage.layer.removeAllAnimations()
        }
    }

    func rotateThis360()
    {
        
        UIView.animateWithDuration(1.8, delay: 0, options: .CurveLinear, animations: {
            activityImage.transform = CGAffineTransformMakeRotation(CGFloat(M_PI_2))
            }, completion: nil)
        UIView.animateWithDuration(1.8, delay: 0, options: .CurveLinear, animations: {
            activityImage.transform = CGAffineTransformMakeRotation(-CGFloat(M_PI_2))
            }, completion: nil)
        UIView.animateWithDuration(1.8, delay: 0, options: .CurveLinear, animations: {
            activityImage.transform = CGAffineTransformMakeRotation(CGFloat(0))
            }, completion: {_ in
                
                self.activityLoader(show)
                
        })
    }
}

// use this code for hexacode of colors

extension UIColor {
    convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
    
    convenience init(netHex:Int) {
        self.init(red:(netHex >> 16) & 0xff, green:(netHex >> 8) & 0xff, blue:netHex & 0xff)
    }
}
