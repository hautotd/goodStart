//
//  newConquestViewController.swift
//  App_V0
//
//  Created by Dimitri Hautot on 24/08/2014.
//  Copyright (c) 2014 Dimitri Hautot. All rights reserved.
//

import UIKit

class SendConquestViewController: UIViewController {
    
    @IBOutlet weak var sendConquest: UIButton!
    var appDelegate = UIApplication.sharedApplication().delegate as AppDelegate
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    @IBAction func sendConquestAction(sender: AnyObject) {
        
        appDelegate.newConquestObject.printNewConquest()
        let alert = UIAlertView()
        alert.title = "New conquest"
        alert.message = "Sex : \(appDelegate.newConquestObject.sex) \n Ranking : \(appDelegate.newConquestObject.ranking) \n Place : \(appDelegate.newConquestObject.whereStr)  \n Comment : \(appDelegate.newConquestObject.comment) \n Job : \(appDelegate.newConquestObject.job) \n Nationality : \(appDelegate.newConquestObject.nationality) \n Height : \(appDelegate.newConquestObject.height) \n Weight : \(appDelegate.newConquestObject.weight) \n Age : \(appDelegate.newConquestObject.age) "
        alert.addButtonWithTitle("Ok")
        alert.show()
    }
         override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
