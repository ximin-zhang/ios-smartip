//
//  ViewController.swift
//  TipCalc
//
//  Created by ximin_zhang on 7/19/16.
//  Copyright © 2016 ximin_zhang. All rights reserved.
//

import UIKit
import Foundation

class ViewController: UIViewController {

    @IBOutlet weak var billTxtField: UITextField!
    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var totLabel: UILabel!
    @IBOutlet weak var tipControl: UISegmentedControl!
    @IBOutlet weak var appliedPercentage: UILabel!
    @IBOutlet weak var costPp: UILabel!
    @IBOutlet weak var splitNumLabel: UILabel!
    
    var currencyFormatter = NSNumberFormatter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        currencyFormatter.numberStyle = NSNumberFormatterStyle.CurrencyStyle
        let defaults = NSUserDefaults.standardUserDefaults()
        let startTimeInit = defaults.objectForKey("start_time") // as! NSDate
        var startTime: NSDate
        if(startTimeInit == nil) {
            startTime = NSDate()
        }else{
            startTime = startTimeInit as! NSDate
        }
        
        let currentTime = NSDate()
        
        // Find the difference between current time and start time.
        let elapsedTime = currentTime.timeIntervalSinceDate(startTime)
        let minutes = elapsedTime / 60.0
        if minutes >= 10 {
            // do nothing, leave blank
        } else {
            billTxtField.text = defaults.stringForKey("lastBill")
        }
        
        // make bill amount is always the first responder
        billTxtField.becomeFirstResponder()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onTap(sender: AnyObject) {
        view.endEditing(true)
    }
    
    @IBAction func CalcTip(sender: AnyObject) {
        
        let defaults = NSUserDefaults.standardUserDefaults()
        // selected segment index in settings page for number of ppl
        let idx2 = defaults.integerForKey("defaultIdx2")
        let customPerc = Double(defaults.integerForKey("customPercInt")) / 100.00
        let tipPercentage = [0.18, 0.20, customPerc]
        let bill = Double(billTxtField.text!) ?? 0
        let tip = bill * tipPercentage[tipControl.selectedSegmentIndex]
        let tot = bill + tip
        
        appliedPercentage.text = "(" + String(NSString(format: "%.2f", tipPercentage[tipControl.selectedSegmentIndex])) + ")"
        tipLabel.text = String(currencyFormatter.stringFromNumber(tip)!)
        totLabel.text = String(currencyFormatter.stringFromNumber(tot)!)
        costPp.text = String(currencyFormatter.stringFromNumber(tot / Double(idx2 + 1))!)
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        let defaults = NSUserDefaults.standardUserDefaults()
        let idx = defaults.integerForKey("defaultIdx") // segment index for default tip %
        tipControl.selectedSegmentIndex = idx
        splitNumLabel.text = "(Split by " + String(defaults.integerForKey("defaultIdx2") + 1) + ")"
        
        // show persistent custom tip percentage
        if let customPerObj = defaults.objectForKey("customPercStr") {
            tipControl.setTitle(String(customPerObj), forSegmentAtIndex: 2)
        } else {
            tipControl.setTitle("25%", forSegmentAtIndex: 2)
        }
        
        CalcTip(self)
        
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setObject(NSDate(), forKey: "start_time")
        defaults.setObject(billTxtField.text, forKey: "lastBill")
        
    }
    
    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
    }
}

