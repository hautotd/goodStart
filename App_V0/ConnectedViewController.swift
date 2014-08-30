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
    @IBOutlet weak var userSurname: UILabel!
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var historyTable: UITableView!
    var tableData: [NSString] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let del = UIApplication.sharedApplication().delegate as AppDelegate
   
        self.userSurname.text = del.surname
         self.userSurname.sizeToFit()
        let history: NSArray = del.userData?.objectForKey("history") as NSArray
        println(history)
        for historyElement in history{
            println("history element")
            var historyzero = historyElement as NSDictionary
            var text = historyzero.objectForKey("comment") as NSString
            var comment:NSString = historyzero.objectForKey("comment") as NSString
            var ranking:NSString = historyzero.objectForKey("ranking") as NSString
            var date: NSString = NSString(format: "%.0i", historyzero.objectForKey("date") as Int)
            let t:NSTimeInterval = historyzero.objectForKey("date") as NSTimeInterval
            let dd : NSDate = NSDate(timeIntervalSince1970: t)
            let dateStringFormatter = NSDateFormatter()
            dateStringFormatter.dateFormat = "yyyy/MM/dd"
            let d = dateStringFormatter.stringFromDate(dd)
            println(d)
            var textToDisplay = d + " " + ranking + "/10 " + comment
            self.tableData.append(textToDisplay)
        }
       
     //   let userData:NSDictionary = del.userData! as NSDictionary
      //  let userHistory:NSArray = userData["history"] as NSArray
      //  println("history : ")
      //  println(userHistory)
      //  self.tableData = userHistory
      //  self.historyTable!.reloadData()
         self.historyTable.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
        configureDisconnectButton()
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
        
        return cell
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
