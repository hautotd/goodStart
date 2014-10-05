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
    var refreshControl:UIRefreshControl!
    var tableData: [NSString] = []
    
    override func viewDidLoad() {
        //var cell = UINib(nibName: "MyCell", bundle: nil)
        //self.historyTable.registerNib(cell!, forCellReuseIdentifier: "cell")
        super.viewDidLoad()
        
        /////////// REFRESHING CONTROL ////////////////////
        self.refreshControl = UIRefreshControl()
        //self.refreshControl.attributedTitle = NSAttributedString(string: "Pull to refersh")
        self.refreshControl.addTarget(self, action: "refresh:", forControlEvents: UIControlEvents.ValueChanged)
        self.historyTable.addSubview(refreshControl)
        
        self.getDataSpinner.startAnimating()
        
        /////////// SERVER CALL ////////////////////
        getHistory()
        
        
        configureDisconnectButton()
        self.getDataSpinner.stopAnimating()
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return self.tableData.count;
    }
    
    func tableView(tableView: UITableView,
        cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        //let cell:UITableViewCell = UITableViewCell(style:UITableViewCellStyle.Default, reuseIdentifier:"cell")
        var cell = tableView.dequeueReusableCellWithIdentifier("cell") as? UITableViewCell
        if !(cell != nil) {
            cell = UITableViewCell(style: UITableViewCellStyle.Value1, reuseIdentifier: "cell")
        }
        cell!.textLabel?.text = tableData[indexPath.row]
        cell!.textLabel?.textColor = UIColor.whiteColor()
        cell!.backgroundColor = UIColor.clearColor()
        cell!.textLabel?.numberOfLines = 4;
        //cell.textLabel.lineBreakMode = NSLineBreakMode;
        return cell!
    }
    
    func configureDisconnectButton(){
        disconnectButton.addTarget(self, action: "disconnect", forControlEvents:.TouchUpInside)
        
    }
    
    func disconnect(){
        NSUserDefaults.standardUserDefaults().removeObjectForKey("userInfos")
        NSUserDefaults.standardUserDefaults().synchronize()
        performSegueWithIdentifier("goToLogin", sender: self)
    }
    
    func refresh(sender:AnyObject)
    {
        println("refreshing ! ")
        getHistory()
    }
    
    func getHistory(){
        let userInfos: NSDictionary? = NSUserDefaults.standardUserDefaults().objectForKey("userInfos") as NSDictionary?
        let userName: NSString = userInfos?.objectForKey("name") as NSString
        let pwd: NSString = userInfos?.objectForKey("password") as NSString
        
        var request = NSMutableURLRequest(URL: NSURL(string: "http://54.77.86.119:8080/users/\(userName)/\(pwd)")!)
        //var session = NSURLSession()
        request.HTTPMethod = "GET"
        
        
        
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
                self.refreshControl.endRefreshing()
                return
            }
            println("Data: \(data)")
            
            let dataParsed = NSData(bytes: data.bytes, length: Int(data.length))
            let str:String = NSString(data: dataParsed, encoding: NSUTF8StringEncoding)!
            
            if(str=="{}"){
                dispatch_async(dispatch_get_main_queue(), {
                    println("error")
                    let alert = UIAlertView()
                    alert.title = "Error"
                    alert.message = "ID not found Please sign in! "
                    alert.addButtonWithTitle("Ok")
                    alert.show()
                })
                
            }else{
                
                var err: NSError?
                
                var jsonResult = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: &err) as NSDictionary
                if(error != nil) {
                    // If there is an error parsing JSON, print it to the console
                    println("JSON Error \(error!.localizedDescription)")
                }
                
                let userName: NSString = jsonResult["name"] as NSString
                //println(jsonResult);
                dispatch_async(dispatch_get_main_queue(), {
                    
                    let history: NSArray = jsonResult["history"] as NSArray
                    var descriptor: NSSortDescriptor = NSSortDescriptor(key: "date", ascending: false)
                    var sortedResults: NSArray = history.sortedArrayUsingDescriptors([descriptor])
                    println(history)
                    self.tableData = []
                    for historyElement in sortedResults{
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
                        dateStringFormatter.dateFormat = "dd/MM/yyyy HH:mm"
                        let d = dateStringFormatter.stringFromDate(dd)
                        var textToDisplay: NSString = d + " \n" + "A " + " " + job + " in a " + whereStr + "\nRated " + ranking + "/10 \nComment : " + comment
                        self.tableData.append(textToDisplay)
                    }
                    self.historyTable.reloadData()
                    self.refreshControl.endRefreshing()
                    
                })
            }
        })
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
