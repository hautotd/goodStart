//
//  newConquestViewController.swift
//  App_V0
//
//  Created by Dimitri Hautot on 24/08/2014.
//  Copyright (c) 2014 Dimitri Hautot. All rights reserved.
//

import UIKit

class SendConquestViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var friendsTableView: UITableView!
    @IBOutlet weak var sendConquest: UIButton!
    var appDelegate = UIApplication.sharedApplication().delegate as AppDelegate
    
    var friendsArray = ["<f9a17e4a 652b280f bad164ce c1951832 3b9202dc 087a4f2b e0149585 d516bedf>","<acc929df 77f116c5 2a608935 e871139e 32692856 d77734a6 446b9ed4 455ddbc1>"]
    var friend1  = ["name": "IPDAD", "deviceId": "<f9a17e4a 652b280f bad164ce c1951832 3b9202dc 087a4f2b e0149585 d516bedf>"] as Dictionary<String,String>
    var friend2  = ["name": "IPHONE", "deviceId": "<acc929df 77f116c5 2a608935 e871139e 32692856 d77734a6 446b9ed4 455ddbc1>"] as Dictionary<String,String>
    var friend3  = ["name": "AMBRE", "deviceId": "<67c73a5e f9baf580 3343b8aa 29e80814 2af032b3 e030b704 0c624f15 f19ae273>"] as Dictionary<String,String>
    var friend4  = ["name": "ARNAUD", "deviceId": "d4056ebe 475f1d34 6b13da92 de93df8f 892500ae dd79cd74 6f47ea10 0a4a7ef3"] as Dictionary<String,String>
    
    
    var friendsDictionnary : Array<Dictionary<String,String>> = []
    var friendsToNotify : Array<Dictionary<String,String>> = []
    
    let swipeRec = UISwipeGestureRecognizer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        swipeRec.direction = UISwipeGestureRecognizerDirection.Right
        swipeRec.addTarget(self, action: "swipedView")
        friendsTableView.addGestureRecognizer(swipeRec)
        friendsTableView.userInteractionEnabled = true
        
        self.friendsTableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "friends")
        self.automaticallyAdjustsScrollViewInsets = false;
        self.friendsTableView.separatorStyle = UITableViewCellSeparatorStyle.None
        friendsDictionnary.append(friend1)
        friendsDictionnary.append(friend2)
        friendsDictionnary.append(friend3)
        friendsDictionnary.append(friend4)
        friendsDictionnary.append(["name": "TEST", "deviceId": self.appDelegate.deviceTokenString] as Dictionary<String,String>)
    }
    
    func tableView(tableView: UITableView!, numberOfRowsInSection section: Int) -> Int {
        return friendsDictionnary.count
    }
    
    func  tableView(tableView: UITableView!, cellForRowAtIndexPath indexPath: NSIndexPath!) -> UITableViewCell! {
        var cell: UITableViewCell = self.friendsTableView.dequeueReusableCellWithIdentifier("friends") as UITableViewCell
        //cell.textLabel.text = friendsArray[indexPath.row]
        cell.backgroundColor = UIColor(rgb: 0xf89854)
        cell.textLabel.textColor = UIColor.whiteColor()
        cell.textLabel.font = UIFont(name: "Arial", size: 40 )
        var currentObj : Dictionary<String,String> = friendsDictionnary[indexPath.row] as Dictionary<String,String>
        cell.textLabel.text = currentObj["name"]
        return cell
    }
    
    
    func tableView(tableView: UITableView!, didSelectRowAtIndexPath indexPath: NSIndexPath!) {
        println("You selected cell #\(indexPath.row)!")
        var selectedCell : UITableViewCell = tableView.cellForRowAtIndexPath(indexPath)
        selectedCell.accessoryType = UITableViewCellAccessoryType.Checkmark
        //sendNotification(friendsArray)
        friendsToNotify.append(friendsDictionnary[indexPath.row])
        
        
    }
    
    func tableView(tableView: UITableView!, didDeselectRowAtIndexPath indexPath: NSIndexPath!) {
        println("You deselected cell #\(indexPath.row)!")
        var selectedCell : UITableViewCell = tableView.cellForRowAtIndexPath(indexPath)
        selectedCell.accessoryType = UITableViewCellAccessoryType.None
        var foundIndex = 0
        for(i, value) in enumerate(friendsToNotify){
            if selectedCell.textLabel.text == value["name"] {
                foundIndex = i
            }
        }
        friendsToNotify.removeAtIndex(foundIndex)
    }
    
    func sendNotification(friendArrayToSend: NSArray, message: NSString){
        var request = NSMutableURLRequest(URL: NSURL(string: "http://54.77.86.119:8080/notification"))
        
        request.HTTPMethod = "POST"
        
        for (friendObj) in friendsToNotify {
            
            println(friendObj["name"]!)
            
            
            // TODO delete
            var deviceIdToSend:NSString = friendObj["deviceId"]!
            var params = ["deviceId" : deviceIdToSend,
                "message": message] as Dictionary<String,NSObject>
            println(deviceIdToSend)
            
            
            var err: NSError?
            request.HTTPBody = NSJSONSerialization.dataWithJSONObject(params, options: nil, error: &err)
            
            
            NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue(), completionHandler: { (response:NSURLResponse!, data: NSData!, error: NSError!) -> Void in
                
                println("Response: \(response)")
                
                
                var strData = NSString(data: data, encoding: NSUTF8StringEncoding)
                
                var err: NSError?
                
                println("strData: \(strData)")
                //            dispatch_async(dispatch_get_main_queue(), {
                //                if(strData == "history upserted"){
                //                    let alert = UIAlertView()
                //                    alert.title = "History"
                //                    alert.message = "User history updated ! "
                //                    alert.addButtonWithTitle("Ok")
                //                    alert.show()
                //                    self.performSegueWithIdentifier("goToHistoryFromSend", sender: self)
                //                }
                //                else{
                //                    let alert = UIAlertView()
                //                    alert.title = "Problème"
                //                    alert.message = "Oups ! erreur de création "
                //                    alert.addButtonWithTitle("Ok")
                //                    alert.show()
                //                }
                //            })
                
            })
        }
    }
    
    
    
    @IBAction func sendConquestAction(sender: AnyObject) {
        
        appDelegate.newConquestObject.printNewConquest()
        let userInfos: NSDictionary? = NSUserDefaults.standardUserDefaults().objectForKey("userInfos") as NSDictionary?
        let userName: NSString = userInfos?.objectForKey("name") as NSString
        println(userName)
        var request = NSMutableURLRequest(URL: NSURL(string: "http://54.77.86.119:8080/users/\(userName)/history"))
       
        request.HTTPMethod = "POST"
        
        let date : NSTimeInterval = NSDate().timeIntervalSince1970
        appDelegate.newConquestObject.printNewConquest()
        
        let messageToNotify: NSString = "Nouvelle entrée de " + userName + ". " + "Genre : " + appDelegate.newConquestObject.sex  + " - Nationalité : " + appDelegate.newConquestObject.nationality + " - Métier : " + appDelegate.newConquestObject.job + " - Note : " + NSString(format: "%.0f",appDelegate.newConquestObject.ranking)
        
        
        println(messageToNotify)
        
        sendNotification(friendsToNotify, message: messageToNotify)
        
        var params = [
            "date" : date,
            "ranking": appDelegate.newConquestObject.ranking,
            "comment": appDelegate.newConquestObject.comment,
            "where": appDelegate.newConquestObject.whereStr,
            "job": appDelegate.newConquestObject.job,
            "nationality": appDelegate.newConquestObject.nationality,
            "height": appDelegate.newConquestObject.height,
            "weight": appDelegate.newConquestObject.weight,
            "age": appDelegate.newConquestObject.age,
            "gender": appDelegate.newConquestObject.sex
            ] as Dictionary<String,NSObject>
        
        
        var err: NSError?
        request.HTTPBody = NSJSONSerialization.dataWithJSONObject(params, options: nil, error: &err)
        
        
        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue(), completionHandler: { (response:NSURLResponse!, data: NSData!, error: NSError!) -> Void in
            println("Response: \(response)")
            var strData = NSString(data: data, encoding: NSUTF8StringEncoding)
            var err: NSError?
            println("strData: \(strData)")
            dispatch_async(dispatch_get_main_queue(), {
                if(strData == "history upserted"){
                    let alert = UIAlertView()
                    alert.title = "History"
                    alert.message = "User history updated ! "
                    alert.addButtonWithTitle("Ok")
                    alert.show()
                    self.performSegueWithIdentifier("goToHistoryFromSend", sender: self)
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
    
    func swipedView(){
        performSegueWithIdentifier("goToJobs", sender: self)
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
