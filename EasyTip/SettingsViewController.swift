//
//  SettingsViewController.swift
//  EasyTip
//
//  Created by Rajit Dang on 12/16/16.
//  Copyright © 2016 Rajit Dang. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {
    let defaults = UserDefaults.standard
    @IBOutlet weak var settingsControl: UISegmentedControl!
    @IBOutlet weak var settingsSlider: UISlider!
    @IBOutlet weak var settingsSliderLabel: UILabel!
    @IBOutlet weak var themeSwitch: UISwitch!
    @IBOutlet weak var tipSettingLabel: UILabel!
    @IBOutlet weak var darkThemeLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        settingsControl.selectedSegmentIndex = defaults.integer(forKey: "segIndex")
        settingsSlider.value = defaults.float(forKey: "defaultSlider")
        settingsSliderLabel.text = String(format: "%0.2f%%", settingsSlider.value)
        if(settingsControl.selectedSegmentIndex != 3) {
            settingsSlider.isHidden = true;
            settingsSliderLabel.isHidden = true;
        }
        
        if defaults.bool(forKey: "themeSwitchState") == true {
            themeSwitch.isOn = true
            self.view.backgroundColor = UIColor.black
            settingsControl.tintColor = UIColor.white
            settingsSliderLabel.textColor = UIColor.white
            settingsSlider.thumbTintColor = UIColor.white
            settingsSlider.maximumTrackTintColor = UIColor.white
            settingsSlider.minimumTrackTintColor = UIColor.white
            darkThemeLabel.textColor = UIColor.white
            tipSettingLabel.textColor = UIColor.white
            themeSwitch.onTintColor = UIColor.white
            themeSwitch.backgroundColor = UIColor.black
            themeSwitch.thumbTintColor = UIColor.black
        } else {
            themeSwitch.isOn = false
            self.view.backgroundColor = UIColor.green
            settingsControl.tintColor = UIColor.blue
            settingsSliderLabel.textColor = UIColor.blue
            darkThemeLabel.textColor = UIColor.blue
            tipSettingLabel.textColor = UIColor.blue
            themeSwitch.tintColor = UIColor.blue
            themeSwitch.thumbTintColor = UIColor.white
            themeSwitch.backgroundColor = UIColor.green
            settingsSlider.thumbTintColor = UIColor.white
            settingsSlider.maximumTrackTintColor = UIColor.blue
            settingsSlider.minimumTrackTintColor = UIColor.blue
        }
        
        //Restore last session
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func themeChanged(_ sender: Any) {
        if themeSwitch.isOn {
            self.view.backgroundColor = UIColor.black
            settingsControl.tintColor = UIColor.white
            settingsSliderLabel.textColor = UIColor.white
            darkThemeLabel.textColor = UIColor.white
            tipSettingLabel.textColor = UIColor.white
            themeSwitch.onTintColor = UIColor.white
            themeSwitch.thumbTintColor = UIColor.black
            themeSwitch.backgroundColor = UIColor.black
            settingsSlider.thumbTintColor = UIColor.white
            settingsSlider.maximumTrackTintColor = UIColor.white
            settingsSlider.minimumTrackTintColor = UIColor.white
            defaults.set(true, forKey: "themeSwitchState")
        } else {
            self.view.backgroundColor = UIColor.green
            settingsControl.tintColor = UIColor.blue
            settingsSlider.thumbTintColor = UIColor.white
            settingsSliderLabel.textColor = UIColor.blue
            darkThemeLabel.textColor = UIColor.blue
            tipSettingLabel.textColor = UIColor.blue
            themeSwitch.tintColor = UIColor.blue
            themeSwitch.thumbTintColor = UIColor.white
            themeSwitch.backgroundColor = UIColor.green
            settingsSlider.thumbTintColor = UIColor.white
            settingsSlider.tintColor = UIColor.blue
            settingsSlider.maximumTrackTintColor = UIColor.blue
            settingsSlider.minimumTrackTintColor = UIColor.blue
            defaults.set(false, forKey: "themeSwitchState")
        }
        
        defaults.synchronize()
    }
    
    @IBAction func changedDefaultTip(_ sender: Any) {
        if settingsControl.selectedSegmentIndex == 3 {
            settingsSlider.isHidden = false;
            settingsSliderLabel.isHidden = false;
        } else {
            settingsSlider.isHidden = true;
            settingsSliderLabel.isHidden = true;
        }
        
        defaults.set(settingsControl.selectedSegmentIndex, forKey: "segIndex")
        defaults.synchronize()
    }
    
    @IBAction func settingsCustomChanged(_ sender: Any) {
        settingsSliderLabel.text = String(format: "%0.2f%%", settingsSlider.value)
        defaults.set(settingsSlider.value, forKey: "defaultSlider")
        defaults.synchronize()
    }
}
