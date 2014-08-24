//
//  ConnectedViewController.swift
//  App_V0
//
//  Created by Dimitri Hautot on 24/08/2014.
//  Copyright (c) 2014 Dimitri Hautot. All rights reserved.
//


import UIKit

class ConnectedViewController: UIViewController {
    
    @IBOutlet weak var disconnectButton: UIButton!
    @IBOutlet weak var userSurname: UILabel!
    @IBOutlet weak var label: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
                            let del = UIApplication.sharedApplication().delegate as AppDelegate
   
        self.userSurname.text = del.surname
         self.userSurname.sizeToFit()
        configureDisconnectButton()
    }
    
    func configureDisconnectButton(){
        disconnectButton.addTarget(self, action: "disconnect", forControlEvents:.TouchUpInside)
     
    }
    
    func disconnect(){
        NSUserDefaults.standardUserDefaults().removeObjectForKey("userInfos")
        NSUserDefaults.standardUserDefaults().synchronize()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
