//
//  AppDelegate.swift
//  LocalNotifications
//
//  Created by Marquis Dennis on 4/9/16.
//  Copyright © 2016 FlashBolt. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        let notificationSettings =  UIUserNotificationSettings(forTypes: [.Alert, .Badge, .Sound], categories: nil)
        
        UIApplication.sharedApplication().registerUserNotificationSettings(notificationSettings)
    
        generateLocalNotification()
        
        return true
    }
    
    func generateLocalNotification() {
        let localNotification = UILocalNotification()
        localNotification.fireDate = NSDate(timeIntervalSinceNow: 10)
        localNotification.alertBody = "Local notification firing"
        localNotification.applicationIconBadgeNumber = 3;
        localNotification.soundName = UILocalNotificationDefaultSoundName
        localNotification.userInfo = ["id": 42, "name": "I am your notification!"]
        UIApplication.sharedApplication().scheduleLocalNotification(localNotification)
    }
    
    func application(application: UIApplication, didReceiveLocalNotification notification: UILocalNotification) {
        if application.applicationState == .Active {
            let alertController = UIAlertController(title: "Received Local Notification \(notification.userInfo!["id"] as! Int)", message: "Would you like to view the notification?", preferredStyle: .Alert)
            
            let ignoreAction = UIAlertAction(title: "Ignore", style: .Cancel, handler: nil)
            let viewAction = UIAlertAction(title: "View", style: .Default, handler: { (action) -> Void in
                self.takeActionWithLocalNotification(notification)
            })
            
            alertController.addAction(ignoreAction)
            alertController.addAction(viewAction)
            
            window?.rootViewController?.presentViewController(alertController, animated: true, completion: nil)
        } else {
            takeActionWithLocalNotification(notification)
        }
    }
    
    func takeActionWithLocalNotification(notification: UILocalNotification) {
        let notificationId = notification.userInfo!["id"] as! Int
        let notificationName = notification.userInfo!["name"] as! String
        
        let alert = UIAlertController(title: "Notification \(notificationId)", message: notificationName, preferredStyle: .Alert)
        let action = UIAlertAction(title: "Ok", style: .Default, handler: nil)
        alert.addAction(action)
        window?.rootViewController?.presentViewController(alert, animated: true, completion: nil)
        
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

