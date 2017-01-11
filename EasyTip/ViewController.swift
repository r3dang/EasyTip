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
    @IBOutlet weak var personStepper: UIStepper!
    @IBOutlet weak var personLabel: UILabel!
    @IBOutlet weak var darkImage: UIImageView!
    @IBOutlet weak var personImage: UIImageView!
    
    /*This function is called when the app starts*/
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
            personImage.isHidden = true
            darkImage.backgroundColor = UIColor.black
            personLabel.textColor = UIColor.white
            personStepper.tintColor = UIColor.white
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
            darkImage.isHidden = true;
            personImage.backgroundColor = UIColor.green
            personLabel.textColor = UIColor.blue
            personStepper.tintColor = UIColor.blue
        }
        
        let lastSessionTime = defaults.integer(forKey: "lastCalculationTime")
        let currentTimestamp = Int(NSDate().timeIntervalSince1970);
        if(currentTimestamp - lastSessionTime < 3600) { // persist across restarts for 1 hour
            let billSubtotal = defaults.double(forKey: "recentBillAmount")
            if(billSubtotal >= 0.0) {
                billField.text = String(billSubtotal);
                calculateTip()
                
            }
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
            personImage.isHidden = true
            darkImage.isHidden = false
            darkImage.backgroundColor = UIColor.black
            personLabel.textColor = UIColor.white
            personStepper.tintColor = UIColor.white
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
            darkImage.isHidden = true
            personImage.isHidden = false
            personImage.backgroundColor = UIColor.green
            personLabel.textColor = UIColor.blue
            personStepper.tintColor = UIColor.blue
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
    
    @IBAction func stepperValueChanged(_ sender: Any) {
        if personStepper.value == 0 {
            personStepper.value = 1
        }
        
        var splitWays = Int(personStepper.value)
        if personStepper.value == 0 {
            personStepper.value = 1
            splitWays = 1
        }
        
        personLabel.text = "x" + String(splitWays)
        defaults.set(splitWays, forKey: "splitWays");
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
        let currentTimestamp = Int(NSDate().timeIntervalSince1970)
        defaults.set(currentTimestamp, forKey: "lastCalculationTime")
        
        if personStepper.value == 0 {
            personStepper.value = 1
        }
        let percentages = [0.18, 0.20, 0.25]
        let bill = Double(billField.text!) ?? 0
        defaults.set(bill, forKey: "recentBillAmount")
        var tip = 0.0
        if tipControl.selectedSegmentIndex == 3 {
            tip = (bill * Double(tipSlider.value/100))/personStepper.value
        } else {
            tip = (bill * percentages[tipControl.selectedSegmentIndex])/personStepper.value
        }
        
        let total = (bill + tip)/personStepper.value
        tipLabel.text = String(format: "$%0.2f", tip)
        totalLabel.text = String(format: "$%0.2f", total)
    }
    
}

