//
//  newConquestViewController.swift
//  App_V0
//
//  Created by Dimitri Hautot on 24/08/2014.
//  Copyright (c) 2014 Dimitri Hautot. All rights reserved.
//

import UIKit

class SubscribeViewController: UIViewController, UITextFieldDelegate {
 
    @IBOutlet weak var userNameInput: UITextField!
    @IBOutlet weak var userEmailInput: UITextField!
    @IBOutlet weak var passwordInput: UITextField!
    
    
    var appDelegate = UIApplication.sharedApplication().delegate as AppDelegate
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
 
    func textFieldShouldReturn(textField: UITextField!) -> Bool {
        textField.resignFirstResponder()
        println("click")
        return true
    }
    @IBAction func subscribeNewUser(sender: AnyObject) {
        
        if(self.userNameInput.text.isEmpty || self.userEmailInput.text.isEmpty || self.passwordInput.text.isEmpty){
            let alert = UIAlertView()
            alert.title = "Erreur donnée invalide"
            alert.message = "Donnée vide"
            alert.addButtonWithTitle("Ok")
            alert.show()
            return
        }
            println("Creation user")
            var request = NSMutableURLRequest(URL: NSURL(string: "http://54.77.86.119:8080/users"))
            var session = NSURLSession()
            request.HTTPMethod = "POST"
            
//            var history = ["date" : 1409266166, "ranking":"9", "comment":"nouvellement cree", "where":"boat", "job":"nurse", "nationality": "french", "height":"tall", "weight":"fat","age":"20" ]
        
            var params = ["name":self.userNameInput.text, "email":self.userEmailInput.text, "password":self.passwordInput.text] as Dictionary<String,NSObject>
            
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
                        alert.message = "Utilisateur - \(self.userNameInput.text) - créé ! "
                        alert.addButtonWithTitle("Ok")
                        alert.show()
                        self.performSegueWithIdentifier("subscribeToConnect", sender: self)
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
            
     
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
