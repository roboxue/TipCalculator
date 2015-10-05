//
//  LayoutConstants.swift
//  TipCalculator
//
//  Created by Robert Xue on 9/28/15.
//  Copyright (c) 2015 roboxue. All rights reserved.
//

import Foundation
import UIKit

let TUISpanSize = 15

// Font
let TUIFontHuge = UIFont(name: "Helvetica", size: 60.0)!
let TUIFontLarge = UIFont(name: "Helvetica", size: 30.0)!
let TUIFontRegular = UIFont(name: "Helvetica", size: 17.0)!

enum VisualTheme: String {
    case Light = "light"
    case Dark = "dark"
    
    var primaryTextColor: UIColor {
        switch self {
        case .Light:
            return UIColor.blackColor()
        case .Dark:
            return UIColor(red: 189/255, green: 195/255, blue: 199/255, alpha: 1.0)
        }
    }
    
    var backgroundColor: UIColor {
        switch self {
        case .Light:
            return UIColor.whiteColor()
        case .Dark:
            return UIColor(red: 44/255, green: 62/255, blue: 80/255, alpha: 1.0)
        }
    }
    
    var tintColor: UIColor {
        switch self {
        case .Light:
            return UIColor(red: 155/255, green: 89/255, blue: 182/255, alpha: 1.0)
        case .Dark:
            return UIColor(red: 243/255, green: 156/255, blue: 18/255, alpha: 1.0)
        }
    }
    
    var keyboardAppearance: UIKeyboardAppearance {
        switch self {
        case .Light:
            return .Light
        case .Dark:
            return .Dark
        }
    }
}