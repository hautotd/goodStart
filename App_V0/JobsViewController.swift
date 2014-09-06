//
//  newConquestViewController.swift
//  App_V0
//
//  Created by Dimitri Hautot on 24/08/2014.
//  Copyright (c) 2014 Dimitri Hautot. All rights reserved.
//

import UIKit

class JobsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var jobsTableView: UITableView!
        var items = ["Nurse", "Engineer", "Taxi Driver", "Actor", "Lawyer", "footballer", "cook", "singer", "dancer", "unemployed", "teacher", "club"]
    //    var picturesArray = ["hotel.png", "parking.png", "church.png", "bedroom.png", "airport.png", "car.png", "beach.png", "jacuzzi.png", "kitchen.png", "street.png", "theatre.png", "club.png"]
    var appDelegate = UIApplication.sharedApplication().delegate as AppDelegate
    
      let swipeBack = UISwipeGestureRecognizer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        swipeBack.direction = UISwipeGestureRecognizerDirection.Right
        swipeBack.addTarget(self, action: "swipedView")
        jobsTableView.addGestureRecognizer(swipeBack)
        jobsTableView.userInteractionEnabled = true
        
        self.jobsTableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
        self.automaticallyAdjustsScrollViewInsets = false;
        self.jobsTableView.separatorStyle = UITableViewCellSeparatorStyle.None
        
        
    }
    
    func tableView(tableView: UITableView!, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(tableView: UITableView!, cellForRowAtIndexPath indexPath: NSIndexPath!) -> UITableViewCell! {
        var cell: UITableViewCell = self.jobsTableView.dequeueReusableCellWithIdentifier("cell") as UITableViewCell
        
        //        var imageName = UIImage(named: picturesArray[indexPath.row])
        //        cell.imageView.autoresizesSubviews = false
        //        cell.contentMode = UIViewContentMode.Center
        //        cell.imageView.image = imageName
        //        cell.shouldIndentWhileEditing = false
        cell.textLabel.textAlignment = NSTextAlignment.Center
        cell.backgroundColor = UIColor(rgb: 0x30b3b2)
        cell.textLabel.textColor = UIColor.whiteColor()
        cell.textLabel.font = UIFont(name: "Arial", size: 40 )
        cell.textLabel.text = items[indexPath.row].uppercaseString
        
        return cell
    }
    
    func tableView(tableView: UITableView!, didSelectRowAtIndexPath indexPath: NSIndexPath!) {
        println("You selected cell #\(indexPath.row)!")
        appDelegate.newConquestObject.job = items[indexPath.row]
        
        performSegueWithIdentifier("goToFriends", sender: self)    }
    
    func swipedView(){
        performSegueWithIdentifier("goToWhere", sender: self)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
