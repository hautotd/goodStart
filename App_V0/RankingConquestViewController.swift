//
//  newConquestViewController.swift
//  App_V0
//
//  Created by Dimitri Hautot on 24/08/2014.
//  Copyright (c) 2014 Dimitri Hautot. All rights reserved.
//

import UIKit

class RankingConquestViewController: UIViewController, UITextFieldDelegate {
 
    @IBOutlet weak var rankingStepper: UIStepper!
    
    @IBOutlet weak var commentTextView: UITextView!
    @IBOutlet weak var rankingLabel: UILabel!
     var appDelegate = UIApplication.sharedApplication().delegate as AppDelegate
    
    override func viewDidLoad() {
        
        appDelegate.newConquestObject.printNewConquest()
        self.rankingStepper.value = appDelegate.newConquestObject.ranking
        self.rankingStepper.minimumValue = 0
        self.rankingStepper.maximumValue = 10
        self.rankingStepper.wraps = true
        self.rankingLabel.text = NSString(format: "%.0F", self.rankingStepper.value)
        self.commentTextView.layer.borderWidth = 0
        //self.commentTextView.layer.borderColor = UIColor.grayColor().CGColor
        super.viewDidLoad()
            
    }

    
    @IBAction func rankUpOnce(sender: UIStepper) {
        let value: Double = sender.value
        println(value)
        let stringValue = NSString(format: "%.0f",value)
        
println(stringValue)
        self.rankingLabel.text = stringValue
    }
   
    @IBAction func goToAppearance(sender: AnyObject) {
        appDelegate.newConquestObject.ranking = rankingStepper.value
        appDelegate.newConquestObject.comment = commentTextView.text
            appDelegate.newConquestObject.printNewConquest()

    }
    
    func textFieldShouldReturn(textField: UITextField!) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
  override func touchesBegan(touches: NSSet!, withEvent event: UIEvent!) {
        self.view.endEditing(true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
