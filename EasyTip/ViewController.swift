//
//  ViewController.swift
//  EasyTip
//
//  Created by Rajit Dang on 12/15/16.
//  Copyright © 2016 Rajit Dang. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var tipControl: UISegmentedControl!
    @IBOutlet weak var billField: UITextField!
    @IBOutlet weak var tipSlider: UISlider!
    @IBOutlet weak var customTipLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
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
        calculateTip()
    }
    
    @IBAction func customTipAmount(_ sender: Any) {
        customTipLabel.text = String(format: "%0.2f", tipSlider.value)
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

