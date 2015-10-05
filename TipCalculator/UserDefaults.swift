//
//  UserDefaults.swift
//  TipCalculator
//
//  Created by Robert Xue on 10/4/15.
//  Copyright (c) 2015 roboxue. All rights reserved.
//

import Foundation

class UserDefaults {
    private let defaultTipPercentageDefaultsKey = "minTipPercentage"
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
}
let Defaults = UserDefaults()