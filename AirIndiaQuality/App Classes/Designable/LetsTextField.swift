//
//  LetsTextField.swift
//  LetsTextField
//
//  Created by Ketan Raval on 28/09/15.
//  Copyright (c) 2015 Ketan Raval. All rights reserved.
//

import UIKit
@IBDesignable
class LetsTextField : UITextField {
    
    var topBorder: UIView?
    var bottomBorder: UIView?
    var leftBorder: UIView?
    var rightBorder: UIView?
    var leftimageview : UIImageView?
    
    override func layoutIfNeeded() {
        
        if leftImage != nil {
            let width = leftviewWidth > leftImage!.size.width + 10 ? leftviewWidth :  leftImage!.size.width + 10
            leftViewMode = UITextFieldViewMode.Always
            leftimageview!.frame=CGRectMake(self.frame.origin.x+10, self.frame.origin.y+2, width,self.frame.size.height-4)
            leftimageview!.image = leftImage;
            leftView = leftimageview;
            self.leftViewMode = .Always
            leftimageview!.contentMode = .Center
        }
        if leftimageview != nil{
            let width = leftviewWidth > leftImage!.size.width + 10 ? leftviewWidth :  leftImage!.size.width + 10
            leftimageview!.frame=CGRectMake(self.frame.origin.x+10, self.frame.origin.y+2, width,self.frame.size.height-4)
        }
        if topBorder != nil{
            topBorder?.frame = CGRectMake(0, 0, self.frame.size.width, topBorderHeight)
        }
        if bottomBorder != nil{
            bottomBorder?.frame = CGRectMake(0, self.frame.size.height - bottomBorderHeight, self.frame.size.width, bottomBorderHeight)
        }
        if leftBorder != nil{
            leftBorder?.frame = CGRectMake(0, 0, leftBorderHeight, self.frame.size.height)
        }
        if rightBorder != nil{
            rightBorder?.frame = CGRectMake(self.frame.size.width - rightBorderHeight, 0, rightBorderHeight, self.frame.size.height)
        }
    }
    
    @IBInspectable var borderColor: UIColor = UIColor.clearColor() {
        didSet {
            layer.borderColor = borderColor.CGColor
        }
    }
    
    @IBInspectable var borderWidth: CGFloat = 0 {
        didSet {
            layer.borderWidth = borderWidth
        }
    }
    
    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet {
            layer.cornerRadius = cornerRadius
        }
    }
    
    @IBInspectable var placeHolderColor : UIColor = UIColor.lightGrayColor(){
        didSet {
            setValue(placeHolderColor, forKeyPath: "_placeholderLabel.textColor")
        }
    }
    
    @IBInspectable var bottomLineWidth : CGFloat = 1 {
        didSet{
            let border: CALayer = CALayer()
            border.borderColor = UIColor.darkGrayColor().CGColor
            self.frame = CGRectMake(0, self.frame.size.height - bottomLineWidth, self.frame.size.width, self.frame.size.height)
            border.borderWidth = borderWidth
            self.layer.addSublayer(border)
            self.layer.masksToBounds = true
        }
    }
    
    @IBInspectable var bottomLineColor : UIColor = UIColor.lightGrayColor(){
        didSet {
            let border: CALayer = CALayer()
            border.borderColor = bottomLineColor.CGColor
        }
    }
    
    @IBInspectable var leftImage : UIImage? {
        didSet {
            if leftImage != nil {
                let width = leftviewWidth > leftImage!.size.width + 10 ? leftviewWidth :  leftImage!.size.width + 10
                leftViewMode = UITextFieldViewMode.Always
                leftimageview = UIImageView();
                leftimageview!.frame=CGRectMake(self.frame.origin.x+10, self.frame.origin.y+2, width,self.frame.size.height-4)
                leftimageview!.image = leftImage;
                leftView = leftimageview;
                self.leftViewMode = .Always
                leftimageview!.contentMode = .Center
            }
            
        }
    }
    @IBInspectable var leftviewWidth : CGFloat = 0 {
        didSet{
            if leftimageview != nil{
                let width = leftviewWidth > leftImage!.size.width + 10 ? leftviewWidth :  leftImage!.size.width + 10
                leftimageview!.frame=CGRectMake(self.frame.origin.x+10, self.frame.origin.y+2, width,self.frame.size.height-4)
            }
        }
    }
    @IBInspectable var paddingLeft: CGFloat = 0
    @IBInspectable var paddingRight: CGFloat = 0
    
    override func textRectForBounds(bounds: CGRect) -> CGRect {
        return CGRectMake(bounds.origin.x + paddingLeft, bounds.origin.y,
            bounds.size.width - paddingLeft - paddingRight, bounds.size.height);
    }
    
    override func editingRectForBounds(bounds: CGRect) -> CGRect {
        return textRectForBounds(bounds)
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
    
}
