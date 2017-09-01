//
//  LetsView.swift
//  LetsView
//
//  Created by Ketan Raval on 07/10/15.
//  Copyright © 2015 Ketan Raval. All rights reserved.
//

import UIKit
@IBDesignable
class LetsView : UIImageView {
    var topBorder: UIView?
    var bottomBorder: UIView?
    var leftBorder: UIView?
    var rightBorder: UIView?
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
    override func layoutSubviews() {
        if topBorder != nil{
            topBorder?.frame = CGRectMake(0, 0, self.frame.width, topBorderHeight)
        }
        if bottomBorder != nil{
            bottomBorder?.frame = CGRectMake(0, self.frame.height - bottomBorderHeight, self.frame.size.width, bottomBorderHeight)
        }
    }
    override func drawRect(rect: CGRect) {
        if topBorder != nil{
            topBorder?.frame = CGRectMake(0, 0, rect.width, topBorderHeight)
        }
        if bottomBorder != nil{
            bottomBorder?.frame = CGRectMake(0, rect.height - bottomBorderHeight, rect.size.width, bottomBorderHeight)
        }
    }
    
}
