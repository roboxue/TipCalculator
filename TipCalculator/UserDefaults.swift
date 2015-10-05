//
//  UserDefaults.swift
//  TipCalculator
//
//  Created by Robert Xue on 10/4/15.
//  Copyright (c) 2015 roboxue. All rights reserved.
//

import Foundation

class UserDefaults {
    private let defaultTipPercentageDefaultsKey = "defaultTipPercentage"
    private let lastUsageDateDefaultsKey = "lastUsageDate"
    private let lastBillAmountDefaultsKey = "lastBillAmount"
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
}
let Defaults = UserDefaults()