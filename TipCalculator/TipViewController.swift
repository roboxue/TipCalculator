//
//  TipViewController.swift
//  TipCalculator
//
//  Created by Robert Xue on 9/28/15.
//  Copyright (c) 2015 roboxue. All rights reserved.
//

import UIKit
import SnapKit

class TipViewController: UIViewController {
    private var _inputWrapper: UIView!
    private var _amountInput: UITextField!
    private var _tipsOutput: UILabel!
    private var _tipTitle: UILabel!
    private var _tipPercentLabel: UILabel!
    private var _tipPercentage: Float!
    private var _tipPercentageSlider: UISlider!
    private var _settingsButton: UIBarButtonItem!
    private let keyboardHeight = 216
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(inputWrapper)
        view.addSubview(tipsOutput)
        view.addSubview(tipPercentageSlider)
        
        inputWrapper.snp_makeConstraints { (make) -> Void in
            make.left.equalTo(view)
            make.right.equalTo(view)
            make.top.equalTo(snp_topLayoutGuideBottom)
        }
        tipPercentageSlider.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(tipPercentLabel.snp_bottom)
            make.left.equalTo(view).offset(TUISpanSize)
            make.right.equalTo(view).offset(-TUISpanSize)
        }
        tipsOutput.snp_makeConstraints { (make) -> Void in
            make.left.equalTo(view).offset(TUISpanSize)
            make.right.equalTo(view).offset(-TUISpanSize)
            make.bottom.equalTo(view).offset(-keyboardHeight)
        }
        navigationItem.rightBarButtonItem = settingsButton
        tipPercentage = Float(Defaults.defaultTipPercentage)
        amountInput.text = String(format: "%0.2f", Defaults.lastBillAmount)
        
        title = "Tip Calculator"
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        refreshTheme()
        updateTips()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        amountInput.becomeFirstResponder()
    }
}

extension TipViewController {
    func refreshTheme() {
        let theme = Defaults.visualTheme
        inputWrapper.backgroundColor = theme.tintColor
        amountInput.backgroundColor = theme.tintColor
        amountInput.textColor = theme.backgroundColor
        amountInput.keyboardAppearance = theme.keyboardAppearance
        tipsOutput.textColor = theme.tintColor
        tipTitle.backgroundColor = theme.tintColor
        tipTitle.textColor = theme.backgroundColor
        tipPercentLabel.backgroundColor = theme.tintColor
        tipPercentLabel.textColor = theme.backgroundColor
    }
    

    func amountDidChanged(sender: UITextField!) {
        updateTips()
    }
    
    func tipSliderDidChanged(sender: UISlider!) {
        tipPercentage = sender.value
        updateTips()
    }
    
    func updateTips() {
        let tipsValue: String
        if let amount = NSNumberFormatter().numberFromString(amountInput.text)?.floatValue {
            tipsValue = numberFormatter.stringFromNumber(amount * (1 + Float(tipPercentage) / 100.0))!
            Defaults.lastBillAmount = amount
        } else {
            tipsValue = "n/a"
        }

        let theme = Defaults.visualTheme
        self.tipsOutput.textColor = theme.backgroundColor
        self.tipsOutput.alpha = 0
        UIView.animateWithDuration(0.3, animations: { () -> Void in
            self.tipsOutput.text = tipsValue
            self.tipsOutput.textColor = theme.tintColor
            self.tipsOutput.alpha = 1
        })
    }
    
    func didPressedSettingsButton() {
        let settingsScreen = SettingsViewController()
        navigationController?.pushViewController(settingsScreen, animated: true)
    }
}

extension TipViewController: UITextFieldDelegate {
    
}

extension TipViewController {
    var inputWrapper: UIView {
        if _inputWrapper == nil {
            let wrapper = UIView()
            wrapper.addSubview(amountInput)
            wrapper.addSubview(tipTitle)
            wrapper.addSubview(tipPercentLabel)
            amountInput.snp_makeConstraints { (make) -> Void in
                make.top.equalTo(wrapper)
                make.left.equalTo(wrapper).offset(TUISpanSize)
                make.right.equalTo(wrapper).offset(-TUISpanSize)
            }
            tipTitle.snp_makeConstraints { (make) -> Void in
                make.top.equalTo(amountInput.snp_bottom)
                make.left.equalTo(wrapper).offset(TUISpanSize)
            }
            tipPercentLabel.snp_makeConstraints { (make) -> Void in
                make.top.equalTo(amountInput.snp_bottom)
                make.left.equalTo(tipTitle.snp_right)
                make.right.equalTo(wrapper).offset(-TUISpanSize)
                make.bottom.equalTo(wrapper)
            }
            _inputWrapper = wrapper
        }
        return _inputWrapper
    }
    
    var amountInput: UITextField {
        if _amountInput == nil {
            let textField = UITextField()
            textField.font = TUIFontHuge
            textField.keyboardType = UIKeyboardType.DecimalPad
            textField.textAlignment = .Right
            textField.placeholder = String(NSLocale.currentLocale().objectForKey(NSLocaleCurrencySymbol) as! NSString)
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
            _tipsOutput = label
        }
        return _tipsOutput
    }
    
    var tipTitle: UILabel {
        if _tipTitle == nil {
            let label = UILabel()
            label.font = TUIFontLarge
            label.text = "Tip:"
            _tipTitle = label
        }
        return _tipTitle
    }
    
    var tipPercentLabel: UILabel {
        if _tipPercentLabel == nil {
            let label = UILabel()
            label.font = TUIFontLarge
            label.textAlignment = .Right
            _tipPercentLabel = label
        }
        return _tipPercentLabel
    }
    
    var tipPercentage: Float {
        get {
            return _tipPercentage
        }
        set {
            _tipPercentage = newValue
            tipPercentLabel.text = String(format: "%0.2f%%", _tipPercentage)
            tipPercentageSlider.setValue(_tipPercentage, animated: true)
        }
    }
    
    var tipPercentageSlider: UISlider {
        get {
            if _tipPercentageSlider == nil {
                let slider = UISlider()
                slider.addTarget(self, action: "tipSliderDidChanged:", forControlEvents: .ValueChanged)
                slider.minimumValue = minTipsPercentage
                slider.maximumValue = maxTipsPercentage
                _tipPercentageSlider = slider
            }
            return _tipPercentageSlider
        }
    }
    
    var settingsButton: UIBarButtonItem {
        if _settingsButton == nil {
            let button = UIBarButtonItem(title: "Settings", style: .Plain, target: self, action: "didPressedSettingsButton")
            _settingsButton = button
        }
        return _settingsButton
    }
    
    var numberFormatter: NSNumberFormatter {
        let formatter = NSNumberFormatter()
        formatter.numberStyle = NSNumberFormatterStyle.CurrencyStyle
        formatter.locale = NSLocale.currentLocale()
        return formatter
    }
}