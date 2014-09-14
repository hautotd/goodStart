//
//  newConquestViewController.swift
//  App_V0
//
//  Created by Dimitri Hautot on 24/08/2014.
//  Copyright (c) 2014 Dimitri Hautot. All rights reserved.
//

import UIKit

class AppearanceConquestViewController: UIViewController , UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet weak var avatarView: UIImageView!
    @IBOutlet weak var nationalityPicker: UIPickerView!
    @IBOutlet weak var weightSegment: UISegmentedControl!
    @IBOutlet weak var heightSegment: UISegmentedControl!
    
    var appDelegate = UIApplication.sharedApplication().delegate as AppDelegate
    
    var nationalityData : NSArray!
    var heightData : NSArray!
    var weightData : NSArray!
    
    override func viewDidLoad() {
        nationalityData = ["French", "English", "German", "Spanish", "American", "Canadian", "Vietnam", "Chineese"]
        heightData = ["Small", "Medium", "Tall"]
        weightData = ["Skinny", "Normal", "Fit", "Chubby"]
      //self.nationalityPicker.selectRow(0, inComponent: 0, animated: true)
                super.viewDidLoad()
    }
    
    @IBAction func heightChanged(sender: AnyObject) {
        println(self.heightSegment.selectedSegmentIndex)
    }
    
    @IBAction func goToWhere(sender: AnyObject) {
        appDelegate.newConquestObject.height = heightData[self.heightSegment.selectedSegmentIndex] as NSString
        appDelegate.newConquestObject.weight = weightData[self.weightSegment.selectedSegmentIndex] as NSString
        
         appDelegate.newConquestObject.nationality = nationalityData[self.nationalityPicker.selectedRowInComponent(0)] as NSString
        
        appDelegate.newConquestObject.printNewConquest()
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView!) -> Int
    {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView!, numberOfRowsInComponent component: Int) -> Int
    {
        return nationalityData!.count
    }
 
    
      func pickerView(pickerView: UIPickerView!, viewForRow row: Int, forComponent component: Int, reusingView view: UIView!) -> UIView! {
        var label:UILabel = UILabel()
     //   label.backgroundColor = UIColor.whiteColor()
        label.textColor = UIColor.whiteColor()
        label.textAlignment = NSTextAlignment.Center
        label.font = UIFont(name: "Arial", size: 40 )
        label.text = nationalityData[row] as NSString
        return label
    }
    
    func pickerView(pickerView: UIPickerView!, didSelectRow row: Int, inComponent component: Int)
    {
       // appDelegate.newConquestObject.nationality = nationalityData![row] as NSString
    }
    
    func pickerView(pickerView: UIPickerView!, rowHeightForComponent component: Int) -> CGFloat {
        return 40
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
