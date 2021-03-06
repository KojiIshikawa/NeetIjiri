//
//  AppDelegate.swift
//  v2MagicalRecord
//
//  Created by v2_system on 2016/01/22.
//  Copyright © 2016年 v2_system. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        print(NSDate().description, __FUNCTION__, __LINE__)
        // Override point for customization after application launch.
        
        let fileManager = NSFileManager.defaultManager()
        
        do {
            //端末内にSQLiteファイルが存在するか確認
            let storeSQLiteURL = NSPersistentStore.MR_urlForStoreName("NeetMaster.sqlite")
            let storeSQLshmURL = NSURL(fileURLWithPath: storeSQLiteURL!.URLByDeletingLastPathComponent!.path! + "/NeetMaster.sqlite-shm")
            let storeSQLwalURL = NSURL(fileURLWithPath: storeSQLiteURL!.URLByDeletingLastPathComponent!.path! + "/NeetMaster.sqlite-wal")
            //let pathToStore = storeSQLiteURL?.URLByDeletingLastPathComponent
            
        
            if fileManager.fileExistsAtPath(storeSQLiteURL!.path!) {
                
                //端末内の自動生成ファイルを削除する
                try fileManager.removeItemAtURL(storeSQLiteURL!)
                try fileManager.removeItemAtURL(storeSQLshmURL)
                try fileManager.removeItemAtURL(storeSQLwalURL)
                
            } else {
                print("storeSQLiteFile not exist")
            }
            
            
            
            // file URL to preload
            let preloadSQLiteURL = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("NeetMaster", ofType: "sqlite")!)
            let preloadSQLshmURL = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("NeetMaster", ofType: "sqlite-shm")!)
            let preloadSQLwalURL = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("NeetMaster", ofType: "sqlite-wal")!)

            
            print("storeSQLiteURL:  \(storeSQLiteURL)")
            print("storeSQLshmURL:  \(storeSQLshmURL)")
            print("storeSQLwalURL:  \(storeSQLwalURL)")
            print("sql:  \(preloadSQLiteURL)")
            print("shm:  \(preloadSQLshmURL)")
            print("wal:  \(preloadSQLwalURL)")

            //コピーする
            try fileManager.copyItemAtURL(preloadSQLiteURL, toURL: storeSQLiteURL!)
            try fileManager.copyItemAtURL(preloadSQLshmURL, toURL: storeSQLshmURL)
            try fileManager.copyItemAtURL(preloadSQLwalURL, toURL: storeSQLwalURL)

        
        } catch let error {
            print("Error...\(error)")
        }

        MagicalRecord.setupCoreDataStackWithAutoMigratingSqliteStoreNamed("NeetMaster.sqlite")

        return true
    }

    func applicationWillResignActive(application: UIApplication) {
        print(NSDate().description, __FUNCTION__, __LINE__)
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        print(NSDate().description, __FUNCTION__, __LINE__)
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        print(NSDate().description, __FUNCTION__, __LINE__)
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        print(NSDate().description, __FUNCTION__, __LINE__)
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        print(NSDate().description, __FUNCTION__, __LINE__)
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        // Saves changes in the application's managed object context before the application terminates.
//        self.saveContext()
        MagicalRecord.cleanUp()
    }

    // MARK: - Core Data stack

    lazy var applicationDocumentsDirectory: NSURL = {
        print(NSDate().description, __FUNCTION__, __LINE__)
        // The directory the application uses to store the Core Data store file. This code uses a directory named "v2-system.v2MagicalRecord" in the application's documents Application Support directory.
        let urls = NSFileManager.defaultManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask)
        return urls[urls.count-1]
    }()

    lazy var managedObjectModel: NSManagedObjectModel = {
        print(NSDate().description, __FUNCTION__, __LINE__)
        // The managed object model for the application. This property is not optional. It is a fatal error for the application not to be able to find and load its model.
        let modelURL = NSBundle.mainBundle().URLForResource("v2MagicalRecord", withExtension: "momd")!
        return NSManagedObjectModel(contentsOfURL: modelURL)!
    }()

    lazy var persistentStoreCoordinator: NSPersistentStoreCoordinator = {
        print(NSDate().description, __FUNCTION__, __LINE__)
        // The persistent store coordinator for the application. This implementation creates and returns a coordinator, having added the store for the application to it. This property is optional since there are legitimate error conditions that could cause the creation of the store to fail.
        // Create the coordinator and store
        let coordinator = NSPersistentStoreCoordinator(managedObjectModel: self.managedObjectModel)
        let url = self.applicationDocumentsDirectory.URLByAppendingPathComponent("SingleViewCoreData.sqlite")
        var failureReason = "There was an error creating or loading the application's saved data."
        do {
            try coordinator.addPersistentStoreWithType(NSSQLiteStoreType, configuration: nil, URL: url, options: nil)
        } catch {
            // Report any error we got.
            var dict = [String: AnyObject]()
            dict[NSLocalizedDescriptionKey] = "Failed to initialize the application's saved data"
            dict[NSLocalizedFailureReasonErrorKey] = failureReason

            dict[NSUnderlyingErrorKey] = error as NSError
            let wrappedError = NSError(domain: "YOUR_ERROR_DOMAIN", code: 9999, userInfo: dict)
            // Replace this with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog("Unresolved error \(wrappedError), \(wrappedError.userInfo)")
            abort()
        }
        
        return coordinator
    }()

    lazy var managedObjectContext: NSManagedObjectContext = {
        print(NSDate().description, __FUNCTION__, __LINE__)
        // Returns the managed object context for the application (which is already bound to the persistent store coordinator for the application.) This property is optional since there are legitimate error conditions that could cause the creation of the context to fail.
        let coordinator = self.persistentStoreCoordinator
        var managedObjectContext = NSManagedObjectContext(concurrencyType: .MainQueueConcurrencyType)
        managedObjectContext.persistentStoreCoordinator = coordinator
        return managedObjectContext
    }()

    // MARK: - Core Data Saving support

    func saveContext () {
        print(NSDate().description, __FUNCTION__, __LINE__)
        if managedObjectContext.hasChanges {
            do {
                try managedObjectContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                NSLog("Unresolved error \(nserror), \(nserror.userInfo)")
                abort()
            }
        }
    }

}

