//
//  newConquestViewController.swift
//  App_V0
//
//  Created by Dimitri Hautot on 24/08/2014.
//  Copyright (c) 2014 Dimitri Hautot. All rights reserved.
//

import UIKit

class newConquestViewController: UIViewController {
    
    @IBOutlet weak var manSexButton: UIButton!
    @IBOutlet weak var womanSexButton: UIButton!
    @IBOutlet weak var unknownSexButton: UIButton!
    
     var appDelegate = UIApplication.sharedApplication().delegate as AppDelegate
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        
//        var manImg = UIImage(named: "manLogo.png") as UIImage
//        manSexButton.setBackgroundImage(manImg, forState: .Normal)
//        manSexButton.setTitle("", forState: .Normal)
//        
//        var womanImg = UIImage(named: "womanLogo.png") as UIImage
//        womanSexButton.setBackgroundImage(womanImg, forState: .Normal)
//        womanSexButton.setTitle("", forState: .Normal)
//        
//        var unknownImg = UIImage(named: "unknownLogo.png") as UIImage
//        unknownSexButton.setBackgroundImage(unknownImg, forState: .Normal)
//        unknownSexButton.setTitle("", forState: .Normal)
     
    }
    @IBAction func setMan(sender: AnyObject) {
        println("set sex")
        appDelegate.newConquestObject.sex = "M"
        appDelegate.newConquestObject.printNewConquest()
        
    }

    @IBAction func setWoman(sender: AnyObject) {
         println("set sex")
        appDelegate.newConquestObject.sex = "W"
       appDelegate.newConquestObject.printNewConquest()
    }
    @IBAction func setUnknwonSex(sender: AnyObject) {
        appDelegate.newConquestObject.sex = "U"
        appDelegate.newConquestObject.printNewConquest()
    }
//
//    @IBAction func setSexWoman(sender: UIButton) {
//        println("set sex")
//    }
//    
//    @IBAction func setSexUnknown(sender: UIButton) {
//                println("set sex")
//    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
