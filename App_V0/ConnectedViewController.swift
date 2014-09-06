//
//  ConnectedViewController.swift
//  App_V0
//
//  Created by Dimitri Hautot on 24/08/2014.
//  Copyright (c) 2014 Dimitri Hautot. All rights reserved.
//


import UIKit

class ConnectedViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var disconnectButton: UIButton!
    @IBOutlet weak var getDataSpinner: UIActivityIndicatorView!
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var historyTable: UITableView!
    var tableData: [NSString] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.getDataSpinner.startAnimating()
        let del = UIApplication.sharedApplication().delegate as AppDelegate
        
        let userInfos: NSDictionary? = NSUserDefaults.standardUserDefaults().objectForKey("userInfos") as NSDictionary?
        let userName: NSString = userInfos?.objectForKey("name") as NSString
        println("USER NAME")
        println(userName)
        var request = NSMutableURLRequest(URL: NSURL(string: "http://54.77.86.119:8080/users/\(userName)"))
        var session = NSURLSession()
        request.HTTPMethod = "GET"
        
        //            var history = ["date" : 1409266166, "ranking":"9", "comment":"nouvellement cree", "where":"boat", "job":"nurse", "nationality": "french", "height":"tall", "weight":"fat","age":"20" ]
        
        //        let t:NSTimeInterval = historyzero.objectForKey("date") as NSTimeInterval
        //        let dd : NSDate = NSDate(timeIntervalSince1970: t)
        
        let date : NSTimeInterval = NSDate().timeIntervalSince1970
        
        
   
        
        var err: NSError?
        //request.HTTPBody = NSJSONSerialization.dataWithJSONObject(params, options: nil, error: &err)
        
        
        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue(), completionHandler: { (response:NSURLResponse!, data: NSData!, error: NSError!) -> Void in
            
            println("Response: \(response)")
            
            
            var strData = NSString(data: data, encoding: NSUTF8StringEncoding)
            
            var err: NSError?
            
            //println("strData: \(strData)")
            
            
            
            var jsonResult = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: &err) as NSDictionary
            if(err != nil) {
                // If there is an error parsing JSON, print it to the console
                println("JSON Error \(err!.localizedDescription)")
            }
            
            let userName: NSString = jsonResult["name"] as NSString
            //println(jsonResult);
            dispatch_async(dispatch_get_main_queue(), {
                //self.labelResponse.text = userSurname
                //let appDelegate = UIApplication.sharedApplication().delegate as AppDelegate
                //  appDelegate.surname = userSurname
                //appDelegate.name = userName
                // appDelegate.userData = jsonResult
               // println(jsonResult["history"])
                
                        let history: NSArray = jsonResult["history"] as NSArray
                        println(history)
                        for historyElement in history{
                            println("history element")
                            var historyzero = historyElement as NSDictionary
                            println(historyzero)
                            var text = historyzero.objectForKey("comment") as NSString
                            
                            //var gender = historyzero.objectForKey("gender") as NSString
                             var whereStr = historyzero.objectForKey("where") as NSString
                            var job = historyzero.objectForKey("job") as NSString
                            var comment:NSString = historyzero.objectForKey("comment") as NSString
                            var ranking:NSString = historyzero.objectForKey("ranking") as NSString
                            var date: NSString = NSString(format: "%.0i", historyzero.objectForKey("date") as Int)
                            let t:NSTimeInterval = historyzero.objectForKey("date") as NSTimeInterval
                            let dd : NSDate = NSDate(timeIntervalSince1970: t)
                            let dateStringFormatter = NSDateFormatter()
                            dateStringFormatter.dateFormat = "dd/MM/yyyy"
                            let d = dateStringFormatter.stringFromDate(dd)
                           
                           var textToDisplay: NSString = d + " \n" + "A " + " " + job + " in a " + whereStr + "\nRated " + ranking + "/10 \nComment : " + comment
                           //var textToDisplay = "coucou"
                            self.tableData.append(textToDisplay)
                        }
                self.historyTable.reloadData()
                
            })
 
            
        })
  
        
         self.historyTable.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
        configureDisconnectButton()
        self.getDataSpinner.stopAnimating()
    }
    
    func tableView(tableView: UITableView!, numberOfRowsInSection section: Int) -> Int
    {
        return self.tableData.count;
    }
   
    func tableView(tableView: UITableView!,
        cellForRowAtIndexPath indexPath: NSIndexPath!) -> UITableViewCell!
    {
        let cell:UITableViewCell = UITableViewCell(style:UITableViewCellStyle.Default, reuseIdentifier:"cell")
        cell.textLabel.text = tableData[indexPath.row]
        cell.textLabel.textColor = UIColor.whiteColor()
        cell.backgroundColor = UIColor.clearColor()
        cell.textLabel.numberOfLines = 4;
        //cell.textLabel.lineBreakMode = NSLineBreakMode;
        return cell
    }
    
    func configureDisconnectButton(){
        disconnectButton.addTarget(self, action: "disconnect", forControlEvents:.TouchUpInside)
     
    }
    
    func disconnect(){
        NSUserDefaults.standardUserDefaults().removeObjectForKey("userInfos")
        NSUserDefaults.standardUserDefaults().synchronize()
        performSegueWithIdentifier("goToLogin", sender: self)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
