//
//  CustomAnnotationView.swift
//  AirQualityIndia
//
//  Created by Shivang Dave on 02/11/16.
//  Copyright © 2016 Alpesh. All rights reserved.
//

import UIKit
import MapKit

import UIKit
import MapKit

class Annotation:NSObject, MKAnnotation {
    
    var coordinate:CLLocationCoordinate2D
    var title:String?
    var subtitle:String?
//    var distance:Float?
//    var locationType:String?

    var imageName: String!
    var aqi : Int!
    var lastUpdate : String!
    var name : String!
    
    init(coord:CLLocationCoordinate2D) {
        
        //super.init(coord:CLLocationCoordinate2D)
        
        self.coordinate = coord
    }
    
    func setCoordiante(newCoordinate:CLLocationCoordinate2D)->Void{
        
        coordinate = newCoordinate
    }
    
    
}

class CustomAnnotationView: MKAnnotationView {
    
    var map:MKMapView!
    var calloutView:UIImageView!
    
    var callOutVisible = Bool()
    var hitTestBuffer = Bool()
    
    var addBtn = UIButton()
    /*
     // Only override drawRect: if you perform custom drawing.
     // An empty implementation adversely affects performance during animation.
     override func drawRect(rect: CGRect) {
     // Drawing code
     }
     */
    
    // Defaults to NO. Becomes YES when tapped/clicked on in the map view.
    override func setSelected(selected: Bool, animated: Bool)
    {
        
        super.setSelected(selected, animated: animated)
        
        if(selected)
        {
            drawOuterView()
            
            callOutVisible = true
            hitTestBuffer = false
            
            self.calloutView.frame = CGRectMake(-70, -80, 0, 0)
            self.calloutView.sizeToFit()
            animateCalloutAppearance()
        
        }else{
            //Remove your custom view...
            callOutVisible = false
            calloutView.removeFromSuperview()
        }
    }
    
    //MARK: Custom Annottaion View
    func drawOuterView(){
        
        let ann:Annotation = self.annotation as! Annotation
        
        let contentWidth:CGFloat = 135.0
        let contentPad:CGFloat = 10.0
        
        self.calloutView = UIImageView(image: UIImage(named:"mapPopup.png"))
        
        let titleLabel:UILabel = UILabel(frame: CGRectMake(contentPad, 1.0, contentWidth, 30.0))
        titleLabel.text = ann.title
        titleLabel.backgroundColor = UIColor.clearColor()
        titleLabel.textColor = UIColor.whiteColor()
        titleLabel.numberOfLines = 0
        titleLabel.lineBreakMode = .ByWordWrapping
        titleLabel.font = UIFont(name:"Helvetica-Bold", size: 12.0)
        calloutView.addSubview(titleLabel)
        
        let imageview:UIImageView = UIImageView(frame: CGRectMake(contentPad,28.0,138.0,1))
        imageview.backgroundColor = UIColor.whiteColor()
        calloutView.addSubview(imageview)
        
        
        let descriptionLabel:UILabel = UILabel(frame: CGRectMake(contentPad, 36.0, contentWidth-5, 30.0))
        descriptionLabel.numberOfLines = 0
        descriptionLabel.textColor = UIColor.whiteColor()
        descriptionLabel.backgroundColor = UIColor.clearColor()
        descriptionLabel.font = UIFont(name:"Helvetica", size: 12.0)
        descriptionLabel.text = "Last updated: \n\(ann.lastUpdate)"
        calloutView.addSubview(descriptionLabel)
        
        addBtn = UIButton(frame: CGRectMake(120.0, 36.0, 30.0, 30.0))
        addBtn.setImage(UIImage(named: "Assets_Add City"), forState: .Normal)
        addBtn.addTarget(self, action: #selector(CustomAnnotationView.callDeviceAdd), forControlEvents: .TouchUpInside)
        self.addSubview(self.calloutView)
        self.calloutView.addSubview(addBtn)
        self.calloutView.bringSubviewToFront(addBtn)
    }
    
    override func hitTest(point: CGPoint, withEvent event: UIEvent?) -> UIView? {
        if (callOutVisible)
        {
            let hitPoint = calloutView.convertPoint(point, toView: addBtn)
            let newPoint = CGPoint(x: hitPoint.x+65.0, y: hitPoint.y+80.0)
            //print(hitPoint)
            if calloutView.pointInside(newPoint, withEvent: event)
            {
                if(!hitTestBuffer)
                {
                    self.callDeviceAdd()
                    hitTestBuffer = true
                }
                return addBtn.hitTest(point, withEvent: event)
            }
            else
            {
                hitTestBuffer = false
            }
        }
        return super.hitTest(point, withEvent: event)
    }
    
    func callDeviceAdd()
    {
        let ann:Annotation = self.annotation as! Annotation
        
        appDelegate.gDeviceId = ann.subtitle!
        NSUserDefaults.standardUserDefaults().setValue(appDelegate.gDeviceId, forKey: "gdevId")
        let info = DeviceInfo()
        info.device_name = ann.title!
        info.device_id = appDelegate.gDeviceId
        info.id = 120
        info.aqi = ann.aqi
        info.lastUpdate = ann.lastUpdate
        ModelManager.getInstance().addNewDevice(info)
        appDelegate.switchGlobalMode(0)
    }
    
    //MARK:Animate CallOut
    func animateCalloutAppearance(){
        
        let scale:CGFloat = 0.001
        self.calloutView.transform = CGAffineTransformMake(scale, 0.0, 0.0, scale, 0, -50.0)
        
        
        UIView.animateWithDuration(NSTimeInterval(0.15),
                                   delay: NSTimeInterval(0.0),
                                   options: UIViewAnimationOptions.CurveEaseOut,
                                   animations:
            {
                let scale:CGFloat = 1.1
                self.calloutView.transform = CGAffineTransformMake(scale, 0.0, 0.0, scale, 0, 2.0)
            },
                                   completion:
            {
                //This code gets called when the first animation finished.
                (value: Bool ) in
                
                UIView.animateWithDuration(NSTimeInterval(0.1),
                    delay: NSTimeInterval(0.0),
                    options: UIViewAnimationOptions.CurveEaseInOut,
                    animations:
                    {
                        let scale:CGFloat = 0.95
                        self.calloutView.transform = CGAffineTransformMake(scale, 0.0, 0.0, scale, 0, -2.0)
                    },
                    completion:
                    {
                        //This code gets called when the first animation finished.
                        (value: Bool ) in
                        
                        UIView.animateWithDuration(NSTimeInterval(0.075),
                            delay: NSTimeInterval(0.0),
                            options: UIViewAnimationOptions.CurveEaseInOut,
                            animations:
                            {
                                let scale:CGFloat = 1
                                self.calloutView.transform = CGAffineTransformMake(scale, 0.0, 0.0, scale, 0.0, 0.0)
                            },
                            completion:
                            {
                                //This code gets called when the first animation finished.
                                (value: Bool ) in
                                
                        })
                        
                })
                
        })
    }
    
}

