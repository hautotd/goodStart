//
//  newConquestViewController.swift
//  App_V0
//
//  Created by Dimitri Hautot on 24/08/2014.
//  Copyright (c) 2014 Dimitri Hautot. All rights reserved.
//

import UIKit

class RankingConquestViewController: UIViewController {
 
    @IBOutlet weak var rankingStepper: UIStepper!
    
    @IBOutlet weak var rankingLabel: UILabel!
    
    override func viewDidLoad() {
        self.rankingStepper.minimumValue = 0
        self.rankingStepper.maximumValue = 10
        self.rankingStepper.wraps = true
        super.viewDidLoad()
            
    }

    
    @IBAction func rankUpOnce(sender: UIStepper) {
        let value: Double = sender.value
        println(value)
        let stringValue = NSString(format: "%.0f",value)
        
println(stringValue)
        self.rankingLabel.text = stringValue
    }
   
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
