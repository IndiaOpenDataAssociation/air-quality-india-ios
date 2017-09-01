//
//  UIView+Extension.swift
//  Pods
//
//  Created by Lokesh on 09/05/16.
//
//

import Foundation
import UIKit

public enum NLInnerShadowDirection : Int {
    case None = 0
    case Left = 1
    case Right = 2
    case Top = 3
    case Bottom = 4
    case All = 5
}
// MARK: - UIView Extension -
public extension UIView {
    public func removeSubviews (){
        subviews.forEach({ $0.removeFromSuperview() })
    }
    public func setConstraintConstant(constant: CGFloat, forAttribute attribute: NSLayoutAttribute) -> Bool {
        let constraint: NSLayoutConstraint? = self.constraintForAttribute(attribute)
        if constraint != nil {
            constraint!.constant = constant
            return true
        }
        else {
            self.superview!.addConstraint(NSLayoutConstraint(item: self, attribute: attribute, relatedBy: .Equal, toItem: nil, attribute: .NotAnAttribute, multiplier: 1.0, constant: constant))
            return false
        }
    }
    
    public func constraintConstantforAttribute(attribute: NSLayoutAttribute) -> CGFloat {
        let constraint: NSLayoutConstraint? = self.constraintForAttribute(attribute)
        if constraint != nil {
            return constraint!.constant
        }
        else {
            return nan("")
        }
    }
    
    public func constraintForAttribute(attribute: NSLayoutAttribute) -> NSLayoutConstraint? {
        let predicate: NSPredicate = NSPredicate(format: "firstAttribute = %d && firstItem = %@", attribute.rawValue, self)
        var fillteredArray: [NSLayoutConstraint]? = (self.superview!.constraints as [NSObject] as NSArray).filteredArrayUsingPredicate(predicate) as? [NSLayoutConstraint]
        if fillteredArray!.count == 0 {
            return nil
        }
        else {
            return fillteredArray![0]
        }
    }
    
    public func hideByHeight(hidden: Bool) {
        self.hideView(hidden, byAttribute: .Height)
    }
    
    public func hideByWidth(hidden: Bool) {
        self.hideView(hidden, byAttribute: .Width)
    }
    
    public func hideView(hidden: Bool, byAttribute attribute: NSLayoutAttribute) {
        if self.hidden != hidden {
            let constraintConstant: CGFloat = self.constraintConstantforAttribute(attribute)
            if hidden {
                if !isnan(constraintConstant) {
                    self.alpha = constraintConstant
                }
                else {
                    let size: CGSize = self.getSize()
                    self.alpha = (attribute == .Height) ? size.height : size.width
                }
                self.setConstraintConstant(0, forAttribute: attribute)
                self.hidden = true
            }
            else {
                if !isnan(constraintConstant) {
                    self.hidden = false
                    self.setConstraintConstant(self.alpha, forAttribute: attribute)
                    self.alpha = 1
                }
            }
        }
    }
    
    public func getSize() -> CGSize {
        self.updateSizes()
        return CGSizeMake(self.bounds.size.width, self.bounds.size.height)
    }
    
    public func updateSizes() {
        self.setNeedsLayout()
        self.layoutIfNeeded()
    }
    
    public func sizeToSubviews() {
        self.updateSizes()
        let fittingSize: CGSize = self.systemLayoutSizeFittingSize(UILayoutFittingCompressedSize)
        self.frame = CGRectMake(0, 0, UIScreen.width, fittingSize.height)
    }
    public class func fromNib(nibNameOrNil: String? = nil) -> Self {
        return fromNib(nibNameOrNil, type: self)
    }
    
    public class func fromNib<T : UIView>(nibNameOrNil: String? = nil, type: T.Type) -> T {
        let v: T? = fromNib(nibNameOrNil, type: T.self)
        return v!
    }
    
    public class func fromNib<T : UIView>(nibNameOrNil: String? = nil, type: T.Type) -> T? {
        var view: T?
        let name: String
        if let nibName = nibNameOrNil {
            name = nibName
        } else {
            // Most nibs are demangled by practice, if not, just declare string explicitly
            name = nibName
        }
        let nibViews = NSBundle.mainBundle().loadNibNamed(name, owner: nil, options: nil)
        for v in nibViews! {
            if let tog = v as? T {
                view = tog
            }
        }
        return view
    }
    
    public class var nibName: String {
        let name = "\(self)".componentsSeparatedByString(".").first ?? ""
        return name
    }
    public class var nib: UINib? {
        if let _ = NSBundle.mainBundle().pathForResource(nibName, ofType: "nib") {
            return UINib(nibName: nibName, bundle: nil)
        } else {
            return nil
        }
    }
    
    
    
    public func removeInnerShadow() {
        for view in self.subviews {
            if (view.tag == 2639) {
                view.removeFromSuperview()
                break
            }
        }
    }
    
    public func addInnerShadow() {
        let c = UIColor()
        let color = c.colorWithAlphaComponent(0.5)
        
        self.addInnerShadowWithRadius(3.0, color: color, inDirection: NLInnerShadowDirection.All)
    }
    
    public func addInnerShadowWithRadius(radius: CGFloat, andAlpha: CGFloat) {
        let c = UIColor()
        let color = c.colorWithAlphaComponent(alpha)
        
        self.addInnerShadowWithRadius(radius, color: color, inDirection: NLInnerShadowDirection.All)
    }
    
    public func addInnerShadowWithRadius(radius: CGFloat, andColor: UIColor) {
        self.addInnerShadowWithRadius(radius, color: andColor, inDirection: NLInnerShadowDirection.All)
    }
    
    public func addInnerShadowWithRadius(radius: CGFloat, color: UIColor, inDirection: NLInnerShadowDirection) {
        self.removeInnerShadow()
        
        let shadowView = self.createShadowViewWithRadius(radius, andColor: color, direction: inDirection)
        shadowView.userInteractionEnabled = false
        self.addSubview(shadowView)
    }
    
    public func createShadowViewWithRadius(radius: CGFloat, andColor: UIColor, direction: NLInnerShadowDirection) -> UIView {
        let shadowView = UIView(frame: CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height))
        shadowView.backgroundColor = UIColor.clearColor()
        shadowView.tag = 2639
        
        let colorsArray: Array = [ andColor.CGColor, UIColor.clearColor().CGColor ]
        
        if direction == .Top {
            let xOffset: CGFloat = 0.0
            let topWidth = self.bounds.size.width
            
            let shadow = CAGradientLayer()
            shadow.colors = colorsArray
            shadow.startPoint = CGPointMake(0.5, 0.0)
            shadow.endPoint = CGPointMake(0.5, 1.0)
            shadow.frame = CGRectMake(xOffset, 0, topWidth, radius)
            shadowView.layer.insertSublayer(shadow, atIndex: 0)
        }
        
        if direction == .Bottom {
            let xOffset: CGFloat = 0.0
            let bottomWidth = self.bounds.size.width
            
            let shadow = CAGradientLayer()
            shadow.colors = colorsArray
            shadow.startPoint = CGPointMake(0.5, 1.0)
            shadow.endPoint = CGPointMake(0.5, 0.0)
            shadow.frame = CGRectMake(xOffset, self.bounds.size.height - radius, bottomWidth, radius)
            shadowView.layer.insertSublayer(shadow, atIndex: 0)
        }
        
        if direction == .Left {
            let yOffset: CGFloat = 0.0
            let leftHeight = self.bounds.size.height
            
            let shadow = CAGradientLayer()
            shadow.colors = colorsArray
            shadow.frame = CGRectMake(0, yOffset, radius, leftHeight)
            shadow.startPoint = CGPointMake(0.0, 0.5)
            shadow.endPoint = CGPointMake(1.0, 0.5)
            shadowView.layer.insertSublayer(shadow, atIndex: 0)
        }
        
        if direction == .Right {
            let yOffset: CGFloat = 0.0
            let rightHeight = self.bounds.size.height
            
            let shadow = CAGradientLayer()
            shadow.colors = colorsArray
            shadow.frame = CGRectMake(self.bounds.size.width - radius, yOffset, radius, rightHeight)
            shadow.startPoint = CGPointMake(1.0, 0.5)
            shadow.endPoint = CGPointMake(0.0, 0.5)
            shadowView.layer.insertSublayer(shadow, atIndex: 0)
        }
        
        return shadowView
    }
    public func addshadow () {
        layer.cornerRadius = 0
        layer.masksToBounds = false
        layer.shadowOffset = CGSizeMake(0.5, -0.5)
        layer.shadowRadius = 5
        layer.shadowOpacity = 0.5
    }
}

public extension UIScreen {
    
    public class var size: CGSize {
        return UIScreen.mainScreen().bounds.size
    }
    
    public class var width: CGFloat {
        return size.width
    }
    
    public class var height: CGFloat {
        return size.height
    }
}
