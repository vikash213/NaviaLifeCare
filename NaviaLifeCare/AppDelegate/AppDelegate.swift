//
//  AppDelegate.swift
//  NaviaLifeCare
//
//  Created by vikash kumar on 10/2/18.
//  Copyright © 2018 NaviaLifeCare. All rights reserved.
//

import UIKit
import UserNotifications

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

   
    

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        //self.setUpApplication(launchOptions: launchOptions)
        self.registerLocalNotification()
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
        print("quites")
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
        
        self.pushLocalReminder()
        print("vikash")
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }

    //MARK: - Register for local notification
    func registerLocalNotification() {
        
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { (_, _) in
            // Parse errors and track state
        }
    }
    
    //MARK: - Push local notification
    func pushLocalReminder() {
        
        let center = UNUserNotificationCenter.current()
        let options: UNAuthorizationOptions = [.alert, .sound];
        center.requestAuthorization(options: options) { (granted, error) in
            if !granted {
                print("Something went wrong")
            }
        }
        center.getNotificationSettings { (settings) in
            if settings.authorizationStatus != .authorized {
                // Notifications not allowed
            }
        }
        let content = UNMutableNotificationContent()
        content.title = "Don't Forget Diet Plan"
        content.body = "Please have your meal"
        content.sound = UNNotificationSound.default()
        
        //get current day and date and push local notification before 5 min the meal time
       let (day, hour, min) = self.getCurrentDate()
        
        if  ((day == CurrentDay.Wednesday.rawValue) && (hour == 6 || hour == 15))
            || ((day == CurrentDay.Thursday.rawValue) && (hour == 7 || hour == 13 || hour == 17 || hour == 21))
            || ((day == CurrentDay.Monday.rawValue) && (hour == 6 || hour == 14)) {
            
            //push notification before 5 mins before meal time
            let date = Date(timeIntervalSinceNow: TimeInterval((55-min)*60))
            content.badge = 1
            let triggerWeekly = Calendar.current.dateComponents([.weekday, .hour, .minute, .second], from: date)
            let trigger = UNCalendarNotificationTrigger(dateMatching: triggerWeekly, repeats: true)
            
            let identifier = "UYLLocalNotification"
            let request = UNNotificationRequest(identifier: identifier, content: content, trigger: trigger)
            center.add(request, withCompletionHandler: { (error) in
                debugPrint(error ?? "Something went wrong!")
            })
        }
    }
    
    func getCurrentDate() -> (Int, Int, Int) {
        let date = Date()
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year, .month, .day, .hour, .minute, .second], from: date)
        return (components.day ?? 0, components.hour ?? 00, components.minute ?? 0)
        
    }

}

