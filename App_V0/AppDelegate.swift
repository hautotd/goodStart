    //
//  AppDelegate.swift
//  App_V0
//
//  Created by Dimitri Hautot on 23/08/2014.
//  Copyright (c) 2014 Dimitri Hautot. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
                            
    var window: UIWindow?
    var surname: NSString = ""
    var name: NSString = ""
    
    var userData: NSDictionary?
    
    struct newConquest {
        var sex : NSString
        var ranking : Double
        var place : NSString
        var date:Double
        var comment:NSString
        var whereStr: NSString
        var job: NSString
        var nationality: NSString
        var height: NSString
        var weight: NSString
        var age: NSString
        var friendsShared: NSArray
        
        init(){
            sex = ""
            ranking = 0
             place = ""
             date = 0
             comment = ""
             whereStr = ""
             job = ""
             nationality = ""
             height = ""
             weight = ""
             age = ""

            friendsShared = []
        }
        func printNewConquest(){
    println(" ***** NewCOnquestObject ******")
            println(self.sex + " " + NSString(format: "%.0f",self.ranking) + " " + self.place)
            println(NSString(format: "%.0f",self.date) + " " + self.comment + " " + self.whereStr)
            println(self.job + " " + self.nationality)
            println(self.height + " " + self.weight + " " + self.age)
      println(" ***** ******** ******")
        }
    }
    
    var newConquestObject: newConquest =  newConquest()

    
    
    func application(application: UIApplication!, didFinishLaunchingWithOptions launchOptions: NSDictionary!) -> Bool {
        // Override point for customization after application launch.
        
        let Device = UIDevice.currentDevice()
        let iosVersion = NSString(string: Device.systemVersion).doubleValue
        let iOS8 = iosVersion >= 8
        let iOS7 = iosVersion >= 7 && iosVersion < 8
        
        if iOS8
        {
            println("We are in IO8!")
              UIApplication.sharedApplication().registerForRemoteNotifications()
            application.registerUserNotificationSettings(UIUserNotificationSettings(forTypes: UIUserNotificationType.Sound | UIUserNotificationType.Alert | UIUserNotificationType.Badge, categories: nil))
        }
        else if iOS7
        {
            //do iOS 7 stuff, which is pretty much nothing for local notifications.
println("We are in IO7!")
            application.registerForRemoteNotificationTypes( UIRemoteNotificationType.Badge | UIRemoteNotificationType.Sound | UIRemoteNotificationType.Alert)
        }
        return true
//       UIApplication.sharedApplication().registerForRemoteNotifications()
//        let settings = UIUserNotificationSettings(forTypes: .Alert, categories: nil)
//        UIApplication.sharedApplication().registerUserNotificationSettings(settings)
//        return true
    }

    func applicationWillResignActive(application: UIApplication!) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }
 
    // implemented in your application delegate
    func application(application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: NSData!) {
        println("Got token data! \(deviceToken)")
    }
    
    func application(application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: NSError!) {
        println("Couldn't register: \(error)")
    }
    
      func application(application: UIApplication, didRegisterUserNotificationSettings notificationSettings: UIUserNotificationSettings) {
       println("settings")
    }
    
    
    func applicationDidEnterBackground(application: UIApplication!) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication!) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication!) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication!) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }



}

