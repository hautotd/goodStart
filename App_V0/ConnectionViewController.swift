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
    //@IBOutlet weak var labelResponse: UILabel!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        configureHttpConnection()
        configureConnectionSpinner()
        
        println("ok")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func configureConnectionSpinner(){
        connectionSpinner.hidesWhenStopped = true
        
        
    }
    
    
    func configureHttpConnection(){
        httpRequestButton.addTarget(self, action: "testConnection:", forControlEvents: .TouchUpInside)
        
    }
    
    
    func testConnection(sender: UIButton){
        if(loginInput.text == ""){
            let alert = UIAlertView()
            alert.title = "Error"
            alert.message = "User ID is empty"
            alert.addButtonWithTitle("Ok")
            alert.show()
            return
        }
        if(passwordInput.text == ""){
            return
        }
        
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
                dispatch_async(dispatch_get_main_queue(), {
                    self.connectionSpinner.stopAnimating()
                    let alertNetwork = UIAlertView()
                    alertNetwork.title = "Error"
                    alertNetwork.message = "No network or server down. "
                    alertNetwork.addButtonWithTitle("Ok")
                    alertNetwork.show()
                })
                println(error.localizedDescription)
                return
            }
            var err: NSError?
            let dataParsed = NSData(bytes: data.bytes, length: Int(data.length))
            
            let str:String = NSString(data: dataParsed, encoding: NSUTF8StringEncoding)
            
            if(str=="{}"){
                dispatch_async(dispatch_get_main_queue(), {
                    println("error")
                    self.connectionSpinner.stopAnimating()
                    let alert = UIAlertView()
                    alert.title = "Error"
                    alert.message = "ID not found Please sign in! "
                    alert.addButtonWithTitle("Ok")
                    alert.show()
                })
                
            }else{
                
                
                var jsonResult = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: &err) as NSDictionary
                if(err != nil) {
                    // If there is an error parsing JSON, print it to the console
                    println("JSON Error \(err!.localizedDescription)")
                }
                //let userSurname: NSString = jsonResult["surname"] as NSString
                let userName: NSString = jsonResult["name"] as NSString
                println(jsonResult);
                dispatch_async(dispatch_get_main_queue(), {
                    //self.labelResponse.text = userSurname
                    let appDelegate = UIApplication.sharedApplication().delegate as AppDelegate
                    //  appDelegate.surname = userSurname
                    appDelegate.name = userName
                    appDelegate.userData = jsonResult
                    println(jsonResult["history"])
                    self.connectionSpinner.stopAnimating()
                    
                    
                    let dataString = NSString(data: data, encoding: NSUTF8StringEncoding)
                    println("Data put to the session part:")
                    NSUserDefaults.standardUserDefaults().setObject(jsonResult, forKey: "userInfos")
                    //let test: AnyObject? = NSUserDefaults.standardUserDefaults().objectForKey("userInfos")
                    
                    // println(test)
                    NSUserDefaults.standardUserDefaults().synchronize()
                    let secondViewController = self.storyboard.instantiateViewControllerWithIdentifier("MyCustomViewController") as UIViewController
                    self.presentViewController(secondViewController, animated: true, completion: nil)
                    
                    
                })
                
            }
            
            
        })
        
        task.resume()
    }
    
    func goToMainView(){
        self.performSegueWithIdentifier("goToMainView", sender:self)
    }
    
}