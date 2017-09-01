//
//  LetsButton.swift
//  LetsButton
//
//  Created by Ketan Raval on 28/09/15.
//  Copyright (c) 2015 Ketan Raval. All rights reserved.
//

import UIKit
@IBDesignable
class LetsButton : UIButton {
    var topBorder: UIView?
    var bottomBorder: UIView?
    var leftBorder: UIView?
    var rightBorder: UIView?
    @IBInspectable var highlightedBackgroundColor: UIColor = UIColor.clearColor() {
        didSet {
            setBackgroundImage(getImageWithColor(highlightedBackgroundColor, size: CGSizeMake(1, 1)), forState: .Highlighted)
        }
    }
    @IBInspectable var normalBackgroundColor: UIColor = UIColor.clearColor() {
        didSet {
            setBackgroundImage(getImageWithColor(normalBackgroundColor, size: CGSizeMake(1, 1)), forState: .Normal)
        }
    }
    @IBInspectable var borderColor: UIColor = UIColor.clearColor() {
        didSet {
            layer.borderColor = borderColor.CGColor
            layer.masksToBounds = true
        }
    }
    
    @IBInspectable var borderWidth: CGFloat = 0 {
        didSet {
            layer.borderWidth = borderWidth
            layer.masksToBounds = true
        }
    }
    
    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet {
            layer.cornerRadius = cornerRadius
            layer.masksToBounds = true
        }
    }
    @IBInspectable var isCircle: Bool = false {
        didSet {
            layer.cornerRadius = frame.width/2
            layer.masksToBounds = true
        }
    }
    @IBInspectable var topBorderColor : UIColor = UIColor.clearColor()
    @IBInspectable var topBorderHeight : CGFloat = 0 {
        didSet{
            if topBorder == nil{
                topBorder = UIView()
                topBorder?.backgroundColor=topBorderColor;
                topBorder?.frame = CGRectMake(0, 0, self.frame.size.width, topBorderHeight)
                addSubview(topBorder!)
            }
        }
    }
    @IBInspectable var bottomBorderColor : UIColor = UIColor.clearColor()
    @IBInspectable var bottomBorderHeight : CGFloat = 0 {
        didSet{
            if bottomBorder == nil{
                bottomBorder = UIView()
                bottomBorder?.backgroundColor=bottomBorderColor;
                bottomBorder?.frame = CGRectMake(0, self.frame.size.height - bottomBorderHeight, self.frame.size.width, bottomBorderHeight)
                addSubview(bottomBorder!)
            }
        }
    }
    
    @IBInspectable var leftBorderColor : UIColor = UIColor.clearColor()
    @IBInspectable var leftBorderHeight : CGFloat = 0 {
        didSet{
            if leftBorder == nil{
                leftBorder = UIView()
                leftBorder?.backgroundColor=leftBorderColor;
                leftBorder?.frame = CGRectMake(0, 0, leftBorderHeight, self.frame.size.height)
                addSubview(leftBorder!)
            }
        }
    }
    @IBInspectable var rightBorderColor : UIColor = UIColor.clearColor()
    @IBInspectable var rightBorderHeight : CGFloat = 0 {
        didSet{
            if rightBorder == nil{
                rightBorder = UIView()
                rightBorder?.backgroundColor=topBorderColor;
                rightBorder?.frame = CGRectMake(self.frame.size.width - rightBorderHeight, 0, rightBorderHeight, self.frame.size.height)
                addSubview(rightBorder!)
            }
        }
    }
    override func drawRect(rect: CGRect) {
        var edge = self.titleEdgeInsets
        edge.bottom = 0.0
        edge.top = 0.0
        self.titleEdgeInsets = edge
        if bottomBorder != nil{
            bottomBorder?.frame = CGRectMake(0, self.frame.size.height - bottomBorderHeight, self.frame.size.width, bottomBorderHeight)
        }
    }
    
}
func getImageWithColor(color: UIColor, size: CGSize) -> UIImage {
    let rect = CGRectMake(0, 0, size.width, size.height)
    UIGraphicsBeginImageContextWithOptions(size, false, 0)
    color.setFill()
    UIRectFill(rect)
    let image: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
    UIGraphicsEndImageContext()
    return image
}
