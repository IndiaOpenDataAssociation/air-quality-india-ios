//
//  ThemeColor.swift
//  SnowMowr
//
//  Created by Lokesh Dudhat on 23/11/15.
//  Copyright © 2015 com.letsnurture. All rights reserved.
//

import Foundation
import UIKit



extension UILabel  {
}
extension UIColor {
    class func navigationTitleColor() -> UIColor {
        return UIColor.whiteColor()
    }
    
    class func navigationBarColor() -> UIColor {
        return UIColor(red: 36/255, green: 42/255, blue: 51/255, alpha: 1.0)
    }
    
    class func greenChartColor() -> UIColor
    {
        return UIColor(red: 0/255, green: 179/255, blue: 191/255, alpha: 1.0)
    }
    
    class func blueChartColor() -> UIColor
    {
        return UIColor(red: 0/255, green: 179/255, blue: 191/255, alpha: 1.0)
    }
    
    
}

extension UIViewController
{
    func calcHours() -> [String]
    {
        var array = [String]()
        //        for i in 0...23
        //        {
        //            array.append("\(i):00")
        //        }
        
        for i in 0...23
        {
            let earlyDate = NSDate(timeIntervalSinceNow: Double(((i*3600))))
            df.dateFormat = "ha"
            df.AMSymbol = "am"
            df.PMSymbol = "pm"
            let current = df.stringFromDate(earlyDate)
            //print(current)
            array.append(current)
        }
        
        //print(array)
        return array
    }
    
    func calcDays() -> [String]
    {
        
        df.dateFormat = "EEE"
        let now = NSDate()
        var results = [String]()
        
        for i in 0...6
        {
            let date = NSDate(timeInterval: Double((i * (60*60*24))), sinceDate: now)
            results.append(df.stringFromDate(date))
        }
        //print(results)
        return results
    }
}

