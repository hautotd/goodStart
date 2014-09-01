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
            
            
            // TO change when the right value is sent back bby the node if no user found !
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
                let userSurname: NSString = jsonResult["surname"] as NSString
                let userName: NSString = jsonResult["name"] as NSString
                println(jsonResult);
                dispatch_async(dispatch_get_main_queue(), {
                    self.labelResponse.text = userSurname
                    let appDelegate = UIApplication.sharedApplication().delegate as AppDelegate
                    appDelegate.surname = userSurname
                    appDelegate.name = userName
                    appDelegate.userData = jsonResult
                    println(jsonResult["history"])
                    self.connectionSpinner.stopAnimating()

                    //If using storyboard, assuming you have a view controller with storyboard ID "MyCustomViewController"
                    let secondViewController = self.storyboard.instantiateViewControllerWithIdentifier("MyCustomViewController") as UIViewController
                    self.presentViewController(secondViewController, animated: true, completion: nil)
                    
                    let dataString = NSString(data: data, encoding: NSUTF8StringEncoding)
                                        println("Data put to the session part:")
                    NSUserDefaults.standardUserDefaults().setObject(jsonResult, forKey: "userInfos")
                    //let test: AnyObject? = NSUserDefaults.standardUserDefaults().objectForKey("userInfos")

                   // println(test)
                    NSUserDefaults.standardUserDefaults().synchronize()
                    
                })
                
            }
          
            
        })
        
        task.resume()
    }
 
    @IBAction func createUser(sender: AnyObject) {
        println("Creation user")
        var request = NSMutableURLRequest(URL: NSURL(string: "http://54.77.86.119:8080/users"))
        var session = NSURLSession()
        request.HTTPMethod = "POST"
        
        var history = ["date" : 1409266166, "ranking":"9", "comment":"nouvellement cree", "where":"boat", "job":"nurse", "nationality": "french", "height":"tall", "weight":"fat","age":"20" ]
        
        var params = ["name":self.loginInput.text,"history": history,"surname":"utilisateursurname"] as Dictionary<String,NSObject>
        
                var err: NSError?
                request.HTTPBody = NSJSONSerialization.dataWithJSONObject(params, options: nil, error: &err)
        
        
        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue(), completionHandler: { (response:NSURLResponse!, data: NSData!, error: NSError!) -> Void in
           
            println("Response: \(response)")

            
            var strData = NSString(data: data, encoding: NSUTF8StringEncoding)
            
            var err: NSError?
            
            println("strData: \(strData)")
            dispatch_async(dispatch_get_main_queue(), {
            if(strData == "updated"){
                let alert = UIAlertView()
                alert.title = "Nouvel utilisateur"
                alert.message = "Utilisateur - \(self.loginInput.text) - créé ! "
                alert.addButtonWithTitle("Ok")
                alert.show()
            }
            else{
                let alert = UIAlertView()
                alert.title = "Problème"
                alert.message = "Oups ! erreur de création "
                alert.addButtonWithTitle("Ok")
                alert.show()
            }
            })
            
        })
        
//        var connection = NSURLConnection(request: request, delegate: self)
//        
//        println("sending request")
//        
//        connection.start()
        
        
        
//        
//        
//        var err: NSError?
//        request.HTTPBody = NSJSONSerialization.dataWithJSONObject(params, options: nil, error: &err)
//        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
//        request.addValue("application/json", forHTTPHeaderField: "Accept")
//        var task = session.dataTaskWithRequest(request, completionHandler: {data, response, error -> Void in
//            println("Response: \(response)")
//            var strData = NSString(data: data, encoding: NSUTF8StringEncoding)
//            println("Body: \(strData)")
//            var err: NSError?
//            var json = NSJSONSerialization.JSONObjectWithData(data, options: .MutableLeaves, error: &err) as? NSDictionary
//            
//            // Did the JSONObjectWithData constructor return an error? If so, log the error to the console
//            if(err != nil) {
//                println(err!.localizedDescription)
//                let jsonStr = NSString(data: data, encoding: NSUTF8StringEncoding)
//                println("Error could not parse JSON: '\(jsonStr)'")
//            }
//            else {
//                // The JSONObjectWithData constructor didn't return an error. But, we should still
//                // check and make sure that json has a value using optional binding.
//                if let parseJSON = json {
//                    // Okay, the parsedJSON is here, let's get the value for 'success' out of it
//                    var success = parseJSON["success"] as? Int
//                    println("Succes: \(success)")
//                }
//                else {
//                    // Woa, okay the json object was nil, something went worng. Maybe the server isn't running?
//                    let jsonStr = NSString(data: data, encoding: NSUTF8StringEncoding)
//                    println("Error could not parse JSON: \(jsonStr)")
//                }
//            }
//        })
        
       // task.resume()
        
        
    }
    func goToMainView(){
        self.performSegueWithIdentifier("goToMainView", sender:self)
    }

}