//
//  SettingsViewController.swift
//  TipCalculator
//
//  Created by Robert Xue on 10/4/15.
//  Copyright (c) 2015 roboxue. All rights reserved.
//

import UIKit
import SnapKit

class SettingsViewController: UIViewController {
    private var _defaultTipPercentageLabel: UILabel!
    private var _defaultTipPercentageValue: UILabel!
    private var _tipPercentageSlider: UISlider!
    private var _themeLabel: UILabel!
    private var _themeSwitch: UISwitch!

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(defaultTipPercentageLabel)
        view.addSubview(defaultTipPercentageValue)
        view.addSubview(tipPercentageSlider)
        view.addSubview(themeLabel)
        view.addSubview(themeSwitch)
        defaultTipPercentageLabel.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(snp_topLayoutGuideBottom).offset(TUISpanSize)
            make.left.equalTo(view).offset(TUISpanSize)
        }
        defaultTipPercentageValue.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(defaultTipPercentageLabel)
            make.right.equalTo(view).offset(-TUISpanSize)
        }
        tipPercentageSlider.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(defaultTipPercentageLabel.snp_bottom).offset(TUISpanSize)
            make.left.equalTo(view).offset(TUISpanSize)
            make.right.equalTo(view).offset(-TUISpanSize)
        }
        themeLabel.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(tipPercentageSlider.snp_bottom).offset(TUISpanSize)
            make.left.equalTo(view).offset(TUISpanSize)
        }
        themeSwitch.snp_makeConstraints { (make) -> Void in
            make.centerY.equalTo(themeLabel)
            make.right.equalTo(view).offset(-TUISpanSize)
        }
        
        title = "Settings"
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        refreshTheme()
        refresh()
    }
}

extension SettingsViewController {
    func refreshTheme() {
        let theme = Defaults.visualTheme
        defaultTipPercentageValue.textColor = theme.tintColor
        themeSwitch.onTintColor = theme.tintColor
        defaultTipPercentageLabel.textColor = theme.primaryTextColor
        themeLabel.textColor = theme.primaryTextColor
    }
    
    func refresh() {
        defaultTipPercentageValue.text = "\(Defaults.defaultTipPercentage)%"
        themeSwitch.on = Defaults.visualTheme == .Dark
        tipPercentageSlider.setValue(Float(Defaults.defaultTipPercentage), animated: true)
    }
    
    func tipSliderDidChanged(sender: UISlider) {
        Defaults.defaultTipPercentage = Int(sender.value)
        refresh()
    }
    
    func themeDidChanged(sender: UISwitch) {
        Defaults.visualTheme = sender.on ? .Dark : .Light
        refreshTheme()
    }
}

extension SettingsViewController {
    var defaultTipPercentageLabel: UILabel {
        if _defaultTipPercentageLabel == nil {
            let label = UILabel()
            label.font = TUIFontRegular
            label.text = "Default Tip Percentage"
            _defaultTipPercentageLabel = label
        }
        return _defaultTipPercentageLabel
    }

    var defaultTipPercentageValue: UILabel {
        if _defaultTipPercentageValue == nil {
            let label = UILabel()
            label.font = TUIFontRegular
            label.textAlignment = .Right
            _defaultTipPercentageValue = label
        }
        return _defaultTipPercentageValue
    }
    
    var tipPercentageSlider: UISlider {
        if _tipPercentageSlider == nil {
            let slider = UISlider()
            slider.addTarget(self, action: "tipSliderDidChanged:", forControlEvents: .ValueChanged)
            slider.minimumValue = minTipsPercentage
            slider.maximumValue = maxTipsPercentage
            _tipPercentageSlider = slider
        }
        return _tipPercentageSlider
    }
    
    var themeLabel: UILabel {
        if _themeLabel == nil {
            let label = UILabel()
            label.font = TUIFontRegular
            label.text = "Dark Theme"
            _themeLabel = label
        }
        return _themeLabel
    }
    
    var themeSwitch: UISwitch {
        if _themeSwitch == nil {
            _themeSwitch = UISwitch()
            _themeSwitch.addTarget(self, action: "themeDidChanged:", forControlEvents: .ValueChanged)
        }
        return _themeSwitch
    }
}
