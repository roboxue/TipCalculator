//
//  TipsViewController.swift
//  TipCalculator
//
//  Created by Robert Xue on 9/28/15.
//  Copyright (c) 2015 roboxue. All rights reserved.
//

import UIKit
import SnapKit

class TipsViewController: UIViewController {
    private var _amountInput: UITextField!
    private var _tipsOutput: UILabel!
    private var _tipPercentInput: UITextField!
    private var _tipPercentage: Double!
    private let keyboardHeight = 216
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(amountInput)
        view.addSubview(tipPercentInput)
        view.addSubview(tipsOutput)
        
        amountInput.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(snp_topLayoutGuideBottom)
            make.left.equalTo(view)
            make.right.equalTo(view)
        }
        tipPercentInput.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(amountInput.snp_bottom)
            make.left.equalTo(view)
            make.right.equalTo(view)
        }
        tipsOutput.snp_makeConstraints { (make) -> Void in
            make.left.equalTo(view)
            make.right.equalTo(view)
            make.bottom.equalTo(view).offset(-keyboardHeight)
        }
        
        title = "Tip Calculator"
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        tipPercentage = defaultTipsPercentage
        amountInput.becomeFirstResponder()
    }
}

extension TipsViewController {
    func amountDidChanged(sender: UITextField!) {
        if let amount = NSNumberFormatter().numberFromString(sender.text)?.doubleValue {
            tipsOutput.text = String(format: "$%0.2f", amount * (1 + tipPercentage / 100.0))
        } else {
            tipsOutput.text = "n/a"
        }
    }
}

extension TipsViewController: UITextFieldDelegate {
    
}

extension TipsViewController {
    var amountInput: UITextField {
        if _amountInput == nil {
            let textField = UITextField()
            textField.font = TUIFontHuge
            textField.backgroundColor = TUITintColor
            textField.textColor = TUIBackgroundColor
            textField.keyboardType = UIKeyboardType.DecimalPad
            textField.textAlignment = .Right
            textField.placeholder = "$"
            textField.clearButtonMode = .WhileEditing
            textField.addTarget(self, action: "amountDidChanged:", forControlEvents: .EditingChanged)
            _amountInput = textField
        }
        return _amountInput
    }
    
    var tipsOutput: UILabel {
        if _tipsOutput == nil {
            let label = UILabel()
            label.font = TUIFontHuge
            label.textAlignment = .Right
            label.adjustsFontSizeToFitWidth = true
            label.textColor = TUITintColor
            _tipsOutput = label
        }
        return _tipsOutput
    }
    
    var tipPercentInput: UITextField {
        if _tipPercentInput == nil {
            let textField = UITextField()
            textField.font = TUIFontLarge
            textField.backgroundColor = TUITintColor
            textField.textColor = TUIBackgroundColor
            textField.textAlignment = .Right
            _tipPercentInput = textField
        }
        return _tipPercentInput
    }
    
    var tipPercentage: Double {
        get {
            return _tipPercentage
        }
        set {
            _tipPercentage = newValue
            tipPercentInput.text = String(format: "%0.2f%%", _tipPercentage)
        }
    }
}