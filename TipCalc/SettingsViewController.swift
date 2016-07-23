//
//  SettingsViewController.swift
//  TipCalc
//
//  Created by ximin_zhang on 7/19/16.
//  Copyright © 2016 ximin_zhang. All rights reserved.
//

import UIKit

//let defaults = NSUserDefaults.standardUserDefaults()

class SettingsViewController: UIViewController {
   
    @IBOutlet weak var percentageSettingControl: UISegmentedControl!
    
    @IBOutlet weak var defaultNumOfPpl: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let defaults = NSUserDefaults.standardUserDefaults()
        let idx = defaults.integerForKey("defaultIdx")
        let idx2 = defaults.integerForKey("defaultIdx2")
        percentageSettingControl.selectedSegmentIndex = idx
        defaultNumOfPpl.selectedSegmentIndex = idx2
        if let customPerObj = defaults.objectForKey("customPercStr") {
            percentageSettingControl.setTitle(String(customPerObj), forSegmentAtIndex: 2)
        } else {
            percentageSettingControl.setTitle("25%", forSegmentAtIndex: 2)
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    @IBAction func defaultChange(sender: AnyObject) {
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setInteger(percentageSettingControl.selectedSegmentIndex, forKey: "defaultIdx")
        defaults.synchronize()
        
    }
    
    
    @IBAction func nofpplcontrol(sender: AnyObject) {
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setInteger(defaultNumOfPpl.selectedSegmentIndex, forKey: "defaultIdx2")
        defaults.synchronize()
        
        // animation of number of people for share (airbnb-belo)
        let numberOfBelo = Int(defaults.integerForKey("defaultIdx2")) + 1
        
        for cloop in 1...numberOfBelo {
            
            // set up some constants for the animation
            let duration = 1.5
            let options = UIViewAnimationOptions.CurveLinear
            
            // randomly assign a delay of 0.9 to 1s
            let delay = NSTimeInterval(900 + arc4random_uniform(100)) / 1000
            
            // set up some constants for the belo
            let size : CGFloat = CGFloat( arc4random_uniform(40))+50
            // let yPosition : CGFloat = CGFloat( arc4random_uniform(200))+150
            let yPosition : CGFloat = 150 + CGFloat(cloop) * 50
            
            // create the belo
            let belo = UIImageView()
            belo.image = UIImage(named: "belo_ppl")
            belo.frame = CGRectMake(0-size, yPosition, size, size)     
            self.view.addSubview(belo)
            
            
            // define the animation
            UIView.animateWithDuration(duration, delay: delay, options: options, animations: {
                
                // move the belo
                belo.frame = CGRectMake(320, yPosition, size, size)
                
                }, completion: { animationFinished in
                    
                    // remove the belo
                    belo.removeFromSuperview()
            })
        }
        
    }
    

    @IBAction func IncTapped(sender: AnyObject) {
        
        let nowStr = percentageSettingControl.titleForSegmentAtIndex(2)
        let nowInt : Int? = Int(nowStr!.substringToIndex(nowStr!.endIndex.predecessor()))
        
        if nowInt < 100 {
            percentageSettingControl.setTitle(String(nowInt! + 1) + "%", forSegmentAtIndex: 2)
        }
        
    }
    
    
    @IBAction func DecTapped(sender: AnyObject) {
        
        let nowStr = percentageSettingControl.titleForSegmentAtIndex(2)
        let nowInt : Int? = Int(nowStr!.substringToIndex(nowStr!.endIndex.predecessor()))
        
        if nowInt > 0 {
            percentageSettingControl.setTitle(String(nowInt! - 1) + "%", forSegmentAtIndex: 2)
        }
        
        
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        
        let defaults = NSUserDefaults.standardUserDefaults()
        let customPercStr = percentageSettingControl.titleForSegmentAtIndex(2)
        defaults.setObject(customPercStr, forKey: "customPercStr")
        let customPercInt : Int? = Int(customPercStr!.substringToIndex(customPercStr!.endIndex.predecessor()))
        defaults.setInteger(customPercInt!, forKey: "customPercInt")
        
        // --- Test ---
        // print("view will disappear")
    }
    
    
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
