//
//  newConquestViewController.swift
//  App_V0
//
//  Created by Dimitri Hautot on 24/08/2014.
//  Copyright (c) 2014 Dimitri Hautot. All rights reserved.
//

import UIKit

class AddFriendViewController: UIViewController, UITextFieldDelegate{
        var appDelegate = UIApplication.sharedApplication().delegate as AppDelegate
    
    @IBOutlet weak var userNamInput: UITextField!
    @IBOutlet weak var checkAndAddFriendButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
    }
    
    @IBAction func checkAndAddFriend(sender: AnyObject) {
        appDelegate.newConquestObject.printNewConquest()
        let userInfos: NSDictionary? = NSUserDefaults.standardUserDefaults().objectForKey("userInfos") as NSDictionary?
        let userName: NSString = userInfos?.objectForKey("name") as NSString
               var request = NSMutableURLRequest(URL: NSURL(string: "http://54.77.86.119:8080/users/\(userName)/friends/add")!)
        
        request.HTTPMethod = "POST"
        
        
        var params = [ "name": userNamInput.text ] as Dictionary<String,NSObject>
        
        
        var err: NSError?
        request.HTTPBody = NSJSONSerialization.dataWithJSONObject(params, options: nil, error: &err)
        
        
        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue(), completionHandler: { (response:NSURLResponse!, data: NSData!, error: NSError!) -> Void in

            if(error != nil || data == nil) {
                // If there is an error in the web request, print it to the console
                dispatch_async(dispatch_get_main_queue(), {
                    let alertNetwork = UIAlertView()
                    alertNetwork.title = "Error"
                    alertNetwork.message = "No network or server down. "
                    alertNetwork.addButtonWithTitle("Ok")
                    alertNetwork.show()
                })
                println(error.localizedDescription)
                return
            }
            
            var jsonResult = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: &err) as NSDictionary
            
            
            let status: NSString = jsonResult["status"] as NSString
            
            if(status == "SUCCESS"){
                dispatch_async(dispatch_get_main_queue(), {
                    let alert = UIAlertView()
                    alert.title = "History"
                    alert.message = "Ami ajouté ! "
                    alert.addButtonWithTitle("Ok")
                    alert.show()
                })
            }else{
                dispatch_async(dispatch_get_main_queue(), {
                    println("error")
                    let alert = UIAlertView()
                    alert.title = "Error"
                    alert.message = "Friend not added! "
                    alert.addButtonWithTitle("Ok")
                    alert.show()
                })
            }
            
        })
    }
    
    
    func textFieldShouldReturn(textField: UITextField!) -> Bool {
        textField.resignFirstResponder()
        println("click")
        return true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
