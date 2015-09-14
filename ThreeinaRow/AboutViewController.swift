//
//  AboutViewController.swift
//  TicTacTrailhead
//
//  Created by Quinton Wall on 7/7/15.
//

import Foundation
import UIKit

class AboutViewController: UIViewController {
    
    @IBOutlet weak var closeButton: UIButton!
    
    @IBOutlet weak var sdsSwitch: UISwitch!

    @IBAction func closeTapped(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: {})

    }
    
    let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    
    @IBAction func sdsSwitchTapped(sender: AnyObject) {
        NSLog("yes")
        appDelegate.sdsEnabled = sdsSwitch.on
        self.dismissViewControllerAnimated(true, completion: {})
    }
    
    override func viewWillAppear(animated: Bool) {
        self.sdsSwitch.setOn(appDelegate.sdsEnabled, animated: false)
    }
}