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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        settingsSlider.isHidden = true;
        settingsSliderLabel.isHidden = true;
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    

    @IBAction func changedDefaultTip(_ sender: Any) {
        let percentages = [0.18, 0.2, 0.25]
        if settingsControl.selectedSegmentIndex == 3 {
            settingsSlider.isHidden = false;
            settingsSliderLabel.isHidden = false;
        } else {
            settingsSlider.isHidden = true;
            settingsSliderLabel.isHidden = true;
            defaults.set(percentages[settingsControl.selectedSegmentIndex], forKey: "defaultTip")
        }
    }
    
    @IBAction func settingsCustomChanged(_ sender: Any) {
        settingsSliderLabel.text = String(format: "%0.2f%%", settingsSlider.value)
        defaults.set(settingsSlider.value, forKey: "defaultTip")
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
