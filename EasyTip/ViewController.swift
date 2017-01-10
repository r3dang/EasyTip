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
    @IBOutlet weak var billTextLabel: UILabel!
    @IBOutlet weak var tipTextLabel: UILabel!
    @IBOutlet weak var totalTextLabel: UILabel!
    @IBOutlet weak var viewRectangle: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "EasyTip"
        billField.becomeFirstResponder()
        
        let themeColor = defaults.bool(forKey: "themeSwitchState")
        if themeColor == true {
            self.view.backgroundColor = UIColor.black
            tipLabel.textColor = UIColor.white
            totalLabel.textColor = UIColor.white
            tipSlider.tintColor = UIColor.white
            customTipLabel.textColor = UIColor.white
            tipControl.tintColor = UIColor.white
            billTextLabel.textColor = UIColor.white
            tipTextLabel.textColor = UIColor.white
            totalTextLabel.textColor = UIColor.white
            viewRectangle.backgroundColor = UIColor.white
            tipSlider.thumbTintColor = UIColor.white
            tipSlider.maximumTrackTintColor = UIColor.white
            tipSlider.minimumTrackTintColor = UIColor.white
        } else {
            self.view.backgroundColor = UIColor.green
            tipLabel.textColor = UIColor.blue
            totalLabel.textColor = UIColor.blue
            tipSlider.tintColor = UIColor.blue
            customTipLabel.textColor = UIColor.blue
            tipControl.tintColor = UIColor.blue
            billTextLabel.textColor = UIColor.blue
            tipTextLabel.textColor = UIColor.blue
            totalTextLabel.textColor = UIColor.blue
            tipSlider.thumbTintColor = UIColor.white
            tipSlider.maximumTrackTintColor = UIColor.blue
            tipSlider.minimumTrackTintColor = UIColor.blue
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
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
        
        let themeColor = defaults.bool(forKey: "themeSwitchState")
        if themeColor == true {
            self.view.backgroundColor = UIColor.black
            tipLabel.textColor = UIColor.white
            totalLabel.textColor = UIColor.white
            tipSlider.tintColor = UIColor.white
            customTipLabel.textColor = UIColor.white
            tipControl.tintColor = UIColor.white
            billTextLabel.textColor = UIColor.white
            tipTextLabel.textColor = UIColor.white
            totalTextLabel.textColor = UIColor.white
            viewRectangle.backgroundColor = UIColor.white
            tipSlider.thumbTintColor = UIColor.white
            tipSlider.maximumTrackTintColor = UIColor.white
            tipSlider.minimumTrackTintColor = UIColor.white
        } else {
            self.view.backgroundColor = UIColor.green
            tipLabel.textColor = UIColor.blue
            totalLabel.textColor = UIColor.blue
            tipSlider.tintColor = UIColor.blue
            customTipLabel.textColor = UIColor.blue
            tipControl.tintColor = UIColor.blue
            billTextLabel.textColor = UIColor.blue
            tipTextLabel.textColor = UIColor.blue
            totalTextLabel.textColor = UIColor.blue
            tipSlider.thumbTintColor = UIColor.white
            tipSlider.maximumTrackTintColor = UIColor.blue
            tipSlider.minimumTrackTintColor = UIColor.blue
            viewRectangle.backgroundColor = UIColor.blue
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
    
    override func motionEnded(_ motion: UIEventSubtype, with event: UIEvent?) {
        if (tipControl.selectedSegmentIndex == 3 && motion == .motionShake) {
            tipSlider.value = Float(drand48()*29 + 1)
            customTipLabel.text = String(format: "%0.2f%%", tipSlider.value)
        }
        
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

