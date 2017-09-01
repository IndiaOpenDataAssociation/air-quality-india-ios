//
//  JBTextView.swift
//
//
//  Created by Lokesh Dudhat on 25/12/15.
//  Copyright © 2015 letsnurture. All rights reserved.
//
import UIKit
public class LetsTextView : UITextView {
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "refreshPlaceholder", name: UITextViewTextDidChangeNotification, object: self)
    }
    
    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "refreshPlaceholder", name: UITextViewTextDidChangeNotification, object: self)
    }
    
    override public func awakeFromNib() {
        super.awakeFromNib()
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "refreshPlaceholder", name: UITextViewTextDidChangeNotification, object: self)
    }
    
    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    private var placeholderLabel: UILabel?
//    @IBInspectable  public var placeholderColor : UIColor? {
//        get {
//            return placeholderColor == nil ? self.textColor : placeholderColor!
//        }
//        set {
//            if placeholderLabel != nil {
//                
//            }
//        }
//    }
    /** @abstract To set textView's placeholder text. Default is ni.    */
    @IBInspectable  public var placeholder : String? {
        
        get {
            return placeholderLabel?.text
        }
        
        set {
            
            if placeholderLabel == nil {
                var frm = CGRectInset(self.bounds, 5, 6)
                frm.size.height = 20
                placeholderLabel = UILabel(frame:frm)
                
                if let unwrappedPlaceholderLabel = placeholderLabel {
                    
                    unwrappedPlaceholderLabel.autoresizingMask = [.FlexibleWidth, .FlexibleHeight]
                    unwrappedPlaceholderLabel.lineBreakMode = .ByWordWrapping
                    unwrappedPlaceholderLabel.numberOfLines = 0
                    unwrappedPlaceholderLabel.font = self.font
                    unwrappedPlaceholderLabel.backgroundColor = UIColor.clearColor()
                    unwrappedPlaceholderLabel.textColor = UIColor.lightGrayColor()
                    unwrappedPlaceholderLabel.alpha = 0
                    addSubview(unwrappedPlaceholderLabel)
                }
            }
            
            placeholderLabel?.text = newValue
            refreshPlaceholder()
        }
    }
    
    func refreshPlaceholder() {
        
        if text.characters.count != 0 {
            placeholderLabel?.alpha = 0
        } else {
            placeholderLabel?.alpha = 1
        }
    }
    
    override public var text: String! {
        
        didSet {
            
            refreshPlaceholder()
            
        }
    }
    
    override public var font : UIFont? {
        
        didSet {
            
            if let unwrappedFont = font {
                placeholderLabel?.font = unwrappedFont
            } else {
                placeholderLabel?.font = UIFont.systemFontOfSize(12)
            }
        }
    }
    
    override public var delegate : UITextViewDelegate? {
        
        get {
            refreshPlaceholder()
            return super.delegate
        }
        
        set {
            
        }
    }
}
