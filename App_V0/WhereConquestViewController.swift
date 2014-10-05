//
//  newConquestViewController.swift
//  App_V0
//
//  Created by Dimitri Hautot on 24/08/2014.
//  Copyright (c) 2014 Dimitri Hautot. All rights reserved.
//

import UIKit

class WhereConquestViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var whereTableView: UITableView!
    var items = ["hotel", "parking", "church", "bedroom", "airport", "car", "beach", "jacuzzi", "kitchen", "street", "theatre", "club"]
    //    var picturesArray = ["hotel.png", "parking.png", "church.png", "bedroom.png", "airport.png", "car.png", "beach.png", "jacuzzi.png", "kitchen.png", "street.png", "theatre.png", "club.png"]
    var appDelegate = UIApplication.sharedApplication().delegate as AppDelegate
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        self.whereTableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
   //     var cell = UINib(nibName: "MyCell", bundle: nil)
     //   self.whereTableView.registerNib(cell!, forCellReuseIdentifier: "cell")
        self.automaticallyAdjustsScrollViewInsets = false;
        self.whereTableView.separatorStyle = UITableViewCellSeparatorStyle.None
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(tableView: UITableView,
        cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("cell") as? UITableViewCell
            if !(cell != nil) {
                cell = UITableViewCell(style: UITableViewCellStyle.Value1, reuseIdentifier: "cell")
            }
        //        var imageName = UIImage(named: picturesArray[indexPath.row])
        //        cell.imageView.autoresizesSubviews = false
        //        cell.contentMode = UIViewContentMode.Center
        //        cell.imageView.image = imageName
        //        cell.shouldIndentWhileEditing = false
       // cell!.textLabel?.textAlignment = NSTextAlignment.Center
        cell!.backgroundColor = UIColor(rgb: 0xf89854)
        cell!.textLabel?.textColor = UIColor.whiteColor()
        cell!.textLabel?.font = UIFont(name: "Arial", size: 40 )
        cell!.textLabel?.text = items[indexPath.row].uppercaseString
        println("chagé!")
        return cell!
    }
    
    func tableView(tableView: UITableView!, didSelectRowAtIndexPath indexPath: NSIndexPath!) {
        println("You selected cell #\(indexPath.row)!")
        appDelegate.newConquestObject.whereStr = items[indexPath.row]
        
        performSegueWithIdentifier("goToJob", sender: self)    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
