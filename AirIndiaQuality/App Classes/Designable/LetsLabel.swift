//
//  LetsLabel
//  LetsLabel
//
//  Created by Ketan Raval on 28/09/15.
//  Copyright (c) 2015 Ketan Raval. All rights reserved.
//

import UIKit

@IBDesignable
class LetsLabel : UILabel {
    var topBorder: UIView?
    var bottomBorder: UIView?
    var leftBorder: UIView?
    var rightBorder: UIView?
    @IBInspectable var isResizeFont : Bool = false {
        didSet {
            if isResizeFont {
                if let ft = self.font {
//                    let font = ft.fontWithSize((self.font.pointSize) * SCALE_IPHONE)
                    self.font = font
                }
            }
        }
    }
    @IBInspectable var ULText: Bool = false {
        didSet {
            let textRange = NSMakeRange(0, (self.text?.characters.count)!)
            let attributedText = NSMutableAttributedString(string: (self.text)!)
            attributedText.addAttribute(NSUnderlineStyleAttributeName , value:NSUnderlineStyle.StyleSingle.rawValue, range: textRange)
            // Add other attributes if needed
            
            self.attributedText = attributedText
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
    
    @IBInspectable var isCircle: Bool = false {
        didSet {
            layer.cornerRadius = frame.width/2
            layer.masksToBounds = true
        }
    }
    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet {
            layer.cornerRadius = cornerRadius
            layer.masksToBounds = true
        }
    }
    @IBInspectable var fitToWidth: Bool = false {
        didSet {
            adjustsFontSizeToFitWidth = fitToWidth
        }
    }
    
    @IBInspectable var paddingLeft: CGFloat = 0
    //@IBInspectable var paddingRight: CGFloat = 0
    
    override func drawTextInRect(rect: CGRect) {
        let newRect = CGRectOffset(rect, paddingLeft, 0) // move text 10 points to the right
        super.drawTextInRect(newRect)
        if isResizeFont
        {
            if let ft = self.font
            {
//                let font = ft.fontWithSize((self.font.pointSize) * SCALE_IPHONE)
                self.font = font
            }
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
    

}
