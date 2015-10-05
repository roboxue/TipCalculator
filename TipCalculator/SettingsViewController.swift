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

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(defaultTipPercentageLabel)
        view.addSubview(defaultTipPercentageValue)
        view.addSubview(tipPercentageSlider)
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
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        refresh()
    }
}

extension SettingsViewController {
    func refresh() {
        defaultTipPercentageValue.text = "\(Defaults.defaultTipPercentage)%"
        tipPercentageSlider.setValue(Float(Defaults.defaultTipPercentage), animated: true)
    }
    
    func tipSliderDidChanged(sender: UISlider) {
        Defaults.defaultTipPercentage = Int(sender.value)
        refresh()
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
            label.textColor = TUITintColor
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
}
