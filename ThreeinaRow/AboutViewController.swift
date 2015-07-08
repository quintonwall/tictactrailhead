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
    
    
    @IBAction func sdsSwitchTapped(sender: AnyObject) {
    }
}