//
//  ViewController.swift
//  App_V0
//
//  Created by Dimitri Hautot on 23/08/2014.
//  Copyright (c) 2014 Dimitri Hautot. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var connectionButton: UIButton!
    
    var prenom:NSString = ""
    
    override func viewDidAppear(animated: Bool) {
        
        let rawData: AnyObject? = NSUserDefaults.standardUserDefaults().objectForKey("userInfos")
        println("Data got from the session part:")
        println(rawData)
        
        if(rawData != nil){
            let test = rawData as NSDictionary
            println("Local stroage user infos")
            println(test)
            println("------------------------")
            if(test !=  ""){
                println("------------------------")
                println("Already connected")
                println("------------------------")
                let del = UIApplication.sharedApplication().delegate as AppDelegate
                del.userData = rawData as? NSDictionary
                self.performSegueWithIdentifier("newEntry", sender:self)
            }
        }else{
            println("------------------------")
            println("Not connected")
            println("------------------------")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let del = UIApplication.sharedApplication().delegate as AppDelegate
        println("current prenom")
        println(del.surname)
        var birdTexture1 = UIImage(named: "connect.png") as UIImage
        connectionButton.setBackgroundImage(birdTexture1, forState: .Normal)
        // Do any additional setup after loading the view, typically from a nib.
        goToFirstView()
        
    }
    
    
    func goToFunction(){
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func goToFirstView(){
    }
    
}

