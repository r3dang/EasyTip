//
//  ViewController.swift
//  EasyTip
//
//  Created by Rajit Dang on 12/15/16.
//  Copyright © 2016 Rajit Dang. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    let defaults = UserDefaults.standard
    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var billField: UITextField!
    @IBOutlet weak var tipSlider: UISlider!
    @IBOutlet weak var customTipLabel: UILabel!
    @IBOutlet weak var tipControl: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "EasyTip"
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        tipControl.selectedSegmentIndex = defaults.integer(forKey: "segIndex")
        print(defaults.integer(forKey: "segIndex"));
        tipSlider.value = defaults.float(forKey: "defaultSlider")
        customTipLabel.text = String(format: "%0.2f%%", tipSlider.value)
        if(tipControl.selectedSegmentIndex != 3) {
            tipSlider.isHidden = true
            customTipLabel.isHidden = true
        } else {
            tipSlider.isHidden = false;
            customTipLabel.isHidden = false;
        }

    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /**
     * Function binded to view. When one taps,
     * keyboard closes
     */
    @IBAction func onTap(_ sender: Any) {
        view.endEditing(true)
    }
    
    /**
     * When bill amount is changed, calculate Tip
     */
    @IBAction func billChanged(_ sender: Any) {
        calculateTip()
    }
    
    /**
     * When segmented control option is changed, recalculate tip
     */
    @IBAction func differentTip(_ sender: Any) {
        if tipControl.selectedSegmentIndex == 3 {
            tipSlider.isHidden = false
            customTipLabel.isHidden = false
        } else {
            tipSlider.isHidden = true
            customTipLabel.isHidden = true
        }
        calculateTip()
    }
    
    /**
     * The custom option is selected in segementedControl
     */
    @IBAction func customTipAmount(_ sender: Any) {
        customTipLabel.text = String(format: "%0.2f%%", tipSlider.value)
        calculateTip()
    }
    
    /**
     * main driver function which dynamically calculates tip
     */
    func calculateTip() {
        let percentages = [0.18, 0.20, 0.25]
        let bill = Double(billField.text!) ?? 0
        var tip = 0.0
        if tipControl.selectedSegmentIndex == 3 {
            tip = bill * Double(tipSlider.value/100)
        } else {
            tip = bill * percentages[tipControl.selectedSegmentIndex]
        }
            
        let total = bill + tip
        tipLabel.text = String(format: "$%0.2f", tip)
        totalLabel.text = String(format: "$%0.2f", total)
    }
    
}

