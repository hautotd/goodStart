//
//  ConnectionViewController.swift
//  App_V0
//
//  Created by Dimitri Hautot on 23/08/2014.
//  Copyright (c) 2014 Dimitri Hautot. All rights reserved.
//

import UIKit
import Foundation

class ConnectionViewController: UIViewController {
    
    @IBOutlet var connectionView: UIView!
    @IBOutlet weak var loginInput: UITextField!
    @IBOutlet weak var passwordInput: UITextField!

    @IBOutlet weak var connectionSpinner: UIActivityIndicatorView!
    @IBOutlet weak var httpRequestButton: UIButton!
    
    @IBOutlet weak var goBackButton: UIButton!
    @IBOutlet weak var labelResponse: UILabel!
    
    override func viewDidLoad() {
    
        super.viewDidLoad()
        configureHttpConnection()
        configureConnectionSpinner()
        var loginImg = UIImage(named: "login.png") as UIImage
        httpRequestButton.setBackgroundImage(loginImg, forState: .Normal)
            println("ok")
            }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func configureConnectionSpinner(){
        connectionSpinner.activityIndicatorViewStyle = .Gray
        connectionSpinner.hidesWhenStopped = true
        
       
    }
    
    
    func configureHttpConnection(){
        httpRequestButton.addTarget(self, action: "testConnection:", forControlEvents: .TouchUpInside)
        
    }

    
    func testConnection(sender: UIButton){
        
        connectionSpinner.startAnimating()
        println(loginInput.text)
        println(passwordInput.text)
        let urlPath = "http://54.77.86.119:8080/users/\(loginInput.text)"
        let url: NSURL = NSURL(string: urlPath)
        let session = NSURLSession.sharedSession()
        let task = session.dataTaskWithURL(url, completionHandler: {data, response, error -> Void in
            println("Task completed")
            if(error != nil) {
                // If there is an error in the web request, print it to the console
                println(error.localizedDescription)
            }
            var err: NSError?
            println(data)
            if(data == nil || data=="" || data=="{}"){
                println("error")
                
            }else{
              
                
                var jsonResult = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: &err) as NSDictionary
                if(err != nil) {
                    // If there is an error parsing JSON, print it to the console
                    println("JSON Error \(err!.localizedDescription)")
                }
                let userSurname: NSString = jsonResult["surname"] as NSString
                let userName: NSString = jsonResult["name"] as NSString
                println(jsonResult);
                dispatch_async(dispatch_get_main_queue(), {
                    self.labelResponse.text = userSurname
                    let del = UIApplication.sharedApplication().delegate as AppDelegate
                    del.surname = userSurname
                    del.name = userName
                    
                    self.connectionSpinner.stopAnimating()

                    //If using storyboard, assuming you have a view controller with storyboard ID "MyCustomViewController"
                    let secondViewController = self.storyboard.instantiateViewControllerWithIdentifier("MyCustomViewController") as UIViewController
                    self.presentViewController(secondViewController, animated: true, completion: nil)
                    
                    let dataString = NSString(data: data, encoding: NSUTF8StringEncoding)
                    NSUserDefaults.standardUserDefaults().setObject(dataString, forKey: "userInfos")
                    let test = NSUserDefaults.standardUserDefaults().objectForKey("userInfos")
                    println(test)
                    NSUserDefaults.standardUserDefaults().synchronize()
                    
                })
                
            }
          
            
        })
        
        task.resume()
        
    }
 
    func goToMainView(){
        self.performSegueWithIdentifier("goToMainView", sender:self)
    }

}