//
//  UserDefaults.swift
//  TipCalculator
//
//  Created by Robert Xue on 10/4/15.
//  Copyright (c) 2015 roboxue. All rights reserved.
//

import Foundation
import UIKit

class UserDefaults {
    private let defaultTipPercentageDefaultsKey = "defaultTipPercentage"
    private let lastUsageDateDefaultsKey = "lastUsageDate"
    private let lastBillAmountDefaultsKey = "lastBillAmount"
    private let themeDefaultsKey = "theme"
    let defaults = NSUserDefaults.standardUserDefaults()
    
    var defaultTipPercentage: Int {
        get {
            return defaults.integerForKey(defaultTipPercentageDefaultsKey)
        }
        set {
            defaults.setInteger(newValue, forKey: defaultTipPercentageDefaultsKey)
            defaults.synchronize()
        }
    }
    
    var lastBillAmount: Float {
        get {
            let lastBillAmount = defaults.floatForKey(lastBillAmountDefaultsKey)
            if let lastUsageDate = defaults.objectForKey(lastUsageDateDefaultsKey) as? NSDate where NSDate().timeIntervalSinceDate(lastUsageDate) < rememberSeconds {
                return lastBillAmount
            } else {
                return 0
            }
        }
        set {
            defaults.setObject(NSDate(), forKey: lastUsageDateDefaultsKey)
            defaults.setFloat(newValue, forKey: lastBillAmountDefaultsKey)
            defaults.synchronize()
        }
    }
    
    var visualTheme: VisualTheme {
        get {
            let themeToUse: VisualTheme
            if let themeName = defaults.stringForKey(themeDefaultsKey), theme = VisualTheme(rawValue: themeName) {
                themeToUse = theme
            } else {
                // Default to light
                themeToUse = .Light
            }
            let window = UIApplication.sharedApplication().keyWindow
            window?.tintColor = themeToUse.tintColor
            window?.backgroundColor = themeToUse.backgroundColor
            return themeToUse
        }
        set {
            defaults.setObject(newValue.rawValue, forKey: themeDefaultsKey)
        }
    }
}
let Defaults = UserDefaults()