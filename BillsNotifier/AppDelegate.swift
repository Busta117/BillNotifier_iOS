//
//  AppDelegate.swift
//  BillsNotifier
//
//  Created by Santiago Bustamante on 3/16/19.
//  Copyright © 2019 Busta. All rights reserved.
//

import UIKit
import AlamofireNetworkActivityLogger
import UserNotifications
import DateToolsSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        NetworkActivityLogger.shared.startLogging()
        NetworkActivityLogger.shared.level = .debug
        
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { (granted, error) in
            print("granted: \(granted)")
        }
        
        Bill.removeAll()
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
        
        Bill(provider: .Claro, number: 3003301001, providerSubtype: Claro.AccountType.mobile.rawValue).save()
        Bill(provider: .Claro, number: 42777469, providerSubtype: Claro.AccountType.home.rawValue).save()
        Bill(provider: .Enel, number: 4475163).save()
        Bill(provider: .Acueducto, number: 12172474).save()

        Bill(id: 1, title: "BBVA visa lifemiles (8910)", description: "Tarjeta de credito", dueDate: Date(year: 2019, month: 3, day: 28), isMonthly: true).save()
        Bill(id: 2, title: "Scotiabank visa lifemiles (9854)", description: "Tarjeta de credito", dueDate: Date(year: 2019, month: 4, day: 14), isMonthly: true).save()
        Bill(id: 3, title: "Scotiabank mastercard black (1906)", description: "Tarjeta de credito", dueDate: Date(year: 2019, month: 4, day: 28), isMonthly: true).save()
        Bill(id: 4, title: "Falabella", description: "Tarjeta de credito", dueDate: Date(year: 2019, month: 4, day: 14), isMonthly: true).save()
        Bill(id: 5, title: "Salud-Pension", description: "miplanilla.com", dueDate: Date(year: 2019, month: 3, day: 10), isMonthly: true).save()
        Bill(id: 6, title: "Administración", description: "Edificio Portal 50", dueDate: Date(year: 2019, month: 3, day: 14), isMonthly: true).save()
        
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
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


}

