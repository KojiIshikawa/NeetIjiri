//
//  AppDelegate.swift
//  NeeNeeApp
//
//  Created by 石川晃次 on 2015/12/27.
//  Copyright © 2015年 KojiIshikawa. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.

        print(NSDate().description, __FUNCTION__, __LINE__)
        
        //coredataでやりとりするsqliteを設定
        MagicalRecord.setupCoreDataStackWithAutoMigratingSqliteStoreNamed("NeetMaster.sqlite")
        
        //全件削除
        M_Kakugen.MR_truncateAll()
        M_Okan.MR_truncateAll()
        M_Job.MR_truncateAll()
        M_Item.MR_truncateAll()
        M_Stage.MR_truncateAll()
        M_ActionImage.MR_truncateAll()
        M_ActionResult.MR_truncateAll()
        M_DropItem.MR_truncateAll()
 
        
        //バンドルのマスタをストアへ移行する
        let preloadSQLiteURL = NSBundle.mainBundle().pathForResource("Master", ofType: "sqlite")
        let db = FMDatabase(path: preloadSQLiteURL)

        let sqlKakugen = "SELECT * FROM M_Kakugen;" //格言マスタ
        let sqlOkan = "SELECT * FROM M_Okan;" //おかんマスタ
        let sqlJob = "SELECT * FROM M_Job;" //役職マスタ
        let sqlItem = "SELECT * FROM M_Item;" //アイテムマスタ
        let sqlStage = "SELECT * FROM M_Stage;" //ステージマスタ
        let sqlActionImage = "SELECT * FROM M_ActionImage;" //行動画像マスタ
        let sqlActionResult = "SELECT * FROM M_ActionResult;" //行動結果マスタ
        let sqlDropItem = "SELECT * FROM M_DropItem;" //ドロップアイテムマスタ
        
        
        db.open()
        
        var i = 0
        
        //格言マスタ
        let res_Kakugen = db.executeQuery(sqlKakugen, withArgumentsInArray: nil)
        while res_Kakugen.next() {
            let newRecord: M_Kakugen = M_Kakugen.MR_createEntity()! as M_Kakugen
            newRecord.kakugenID = NSNumber(int: res_Kakugen.intForColumn("kakugenID"))
            newRecord.kakugenText = res_Kakugen.stringForColumn("kakugenText")
            newRecord.viewNo = NSNumber(int: res_Kakugen.intForColumn("viewNo"))
            newRecord.managedObjectContext!.MR_saveToPersistentStoreAndWait()
            i += 1
        }
        print("件数\(i)")
        i = 0
        
        //おかんマスタ
        let res_Okan = db.executeQuery(sqlOkan, withArgumentsInArray: nil)
        while res_Okan.next() {
            let newRecord: M_Okan = M_Okan.MR_createEntity()! as M_Okan
            newRecord.okanID = NSNumber(int: res_Okan.intForColumn("okanID"))
            newRecord.okanText = res_Okan.stringForColumn("okanText")
            newRecord.loginDays = NSNumber(int: res_Okan.intForColumn("loginDays"))
            newRecord.managedObjectContext!.MR_saveToPersistentStoreAndWait()
            i += 1

        }
        print("件数\(i)")
        i = 0
        
        //役職マスタ
        let res_Job = db.executeQuery(sqlJob, withArgumentsInArray: nil)
        while res_Job.next() {
            let newRecord: M_Job = M_Job.MR_createEntity()! as M_Job
            newRecord.jobID = NSNumber(int: res_Job.intForColumn("jobID"))
            newRecord.maxStageID = NSNumber(int: res_Job.intForColumn("maxStageID"))
            newRecord.jobName = res_Job.stringForColumn("jobName")
            newRecord.jobText = res_Job.stringForColumn("jobText")
            newRecord.viewNo = NSNumber(int: res_Job.intForColumn("viewNo"))
            newRecord.managedObjectContext!.MR_saveToPersistentStoreAndWait()
            i += 1
        }
        print("件数\(i)")
        i = 0
        
        //アイテムマスタ
        let res_Item = db.executeQuery(sqlItem, withArgumentsInArray: nil)
        while res_Item.next() {
            let newRecord: M_Item = M_Item.MR_createEntity()! as M_Item
            newRecord.itemID = NSNumber(int: res_Item.intForColumn("itemID"))
            newRecord.stageID = NSNumber(int: res_Item.intForColumn("stageID"))
            newRecord.animeKBN = NSNumber(int: res_Item.intForColumn("animeKBN"))
            newRecord.itemName = res_Item.stringForColumn("itemName")
            newRecord.itemText = res_Item.stringForColumn("itemText")
            newRecord.imageItem = res_Item.stringForColumn("imageItem")
            newRecord.point = NSNumber(int: res_Item.intForColumn("point"))
            newRecord.procTime = NSNumber(int: res_Item.intForColumn("procTime"))
            newRecord.useArea = NSNumber(int: res_Item.intForColumn("useArea"))
            newRecord.viewNo = NSNumber(int: res_Item.intForColumn("viewNo"))
            newRecord.firstX = NSNumber(int: res_Item.intForColumn("firstX"))
            newRecord.firstY = NSNumber(int: res_Item.intForColumn("firstY"))
            newRecord.minX = NSNumber(int: res_Item.intForColumn("minX"))
            newRecord.maxX = NSNumber(int: res_Item.intForColumn("maxX"))
            newRecord.minY = NSNumber(int: res_Item.intForColumn("minY"))
            newRecord.maxY = NSNumber(int: res_Item.intForColumn("maxY"))
            
            newRecord.managedObjectContext!.MR_saveToPersistentStoreAndWait()
            i += 1
        }
        print("件数\(i)")
        i = 0

        //ステージマスタ
        let res_Stage = db.executeQuery(sqlStage, withArgumentsInArray: nil)
        while res_Stage.next() {
            let newRecord: M_Stage = M_Stage.MR_createEntity()! as M_Stage
            newRecord.stageID = NSNumber(int: res_Stage.intForColumn("stageID"))
            newRecord.stageName = res_Stage.stringForColumn("stageName")
            newRecord.stageText = res_Stage.stringForColumn("stageText")
            newRecord.bgm = res_Stage.stringForColumn("bgm")
            newRecord.imageBack = res_Stage.stringForColumn("imageBack")
            newRecord.viewNo = NSNumber(int: res_Stage.intForColumn("viewNo"))
            newRecord.managedObjectContext!.MR_saveToPersistentStoreAndWait()
            i += 1
        }
        print("件数\(i)")
        i = 0
        
        //行動画像マスタ
        let res_ActionImage = db.executeQuery(sqlActionImage, withArgumentsInArray: nil)
        while res_ActionImage.next() {
            let newRecord: M_ActionImage = M_ActionImage.MR_createEntity()! as M_ActionImage
            newRecord.itemID = NSNumber(int: res_ActionImage.intForColumn("itemID"))
//            newRecord.stageID = NSNumber(int: res_ActionImage.intForColumn("stageID"))
//            newRecord.actID = NSNumber(int: res_ActionImage.intForColumn("actID"))
            newRecord.imageAct = res_ActionImage.stringForColumn("imageAct")
            newRecord.way = NSNumber(int: res_ActionImage.intForColumn("way"))
            newRecord.managedObjectContext!.MR_saveToPersistentStoreAndWait()
            i += 1
        }
        print("件数\(i)")
        i = 0
        
        //行動結果マスタ
        let res_ActionResult = db.executeQuery(sqlActionResult, withArgumentsInArray: nil)
        while res_ActionResult.next() {
            let newRecord: M_ActionResult = M_ActionResult.MR_createEntity()! as M_ActionResult
            newRecord.itemID = NSNumber(int: res_ActionResult.intForColumn("itemID"))
            newRecord.resultID = NSNumber(int: res_ActionResult.intForColumn("resultID"))
            newRecord.message = res_ActionResult.stringForColumn("message")
            newRecord.resPer = NSNumber(int: res_ActionResult.intForColumn("resPer"))
            newRecord.rankKBN = res_ActionResult.stringForColumn("rankKBN")
//            newRecord.itemCount = NSNumber(int: res_ActionResult.intForColumn("itemCount"))
            
            
            newRecord.managedObjectContext!.MR_saveToPersistentStoreAndWait()
            i += 1
        }
        print("件数\(i)")
        i = 0
        
        //ドロップアイテムマスタ
        let res_DropItem = db.executeQuery(sqlDropItem, withArgumentsInArray: nil)
        while res_DropItem.next() {
            let newRecord: M_DropItem = M_DropItem.MR_createEntity()! as M_DropItem
            newRecord.itemID = NSNumber(int: res_DropItem.intForColumn("itemID"))
            newRecord.dropItemID = NSNumber(int: res_DropItem.intForColumn("dropItemID"))
            newRecord.dropPer = NSNumber(int: res_DropItem.intForColumn("dropPer"))
            newRecord.managedObjectContext!.MR_saveToPersistentStoreAndWait()
            i += 1
        }
        print("件数\(i)")
        i = 0

        

        db.close()


        
        
//        let fileManager = NSFileManager.defaultManager()
//        print(NSPersistentStore.MR_urlForStoreName("NeetMaster.sqlite"))
// Override point for customization after application launch.
        
//        do {
//            //端末内にSQLiteファイルが存在するか確認
//            let storeSQLiteURL = NSPersistentStore.MR_urlForStoreName("NeetMaster.sqlite")
////            let storeSQLshmURL = NSURL(fileURLWithPath: storeSQLiteURL!.URLByDeletingLastPathComponent!.path! + "/NeetMaster.sqlite-shm")
////            let storeSQLwalURL = NSURL(fileURLWithPath: storeSQLiteURL!.URLByDeletingLastPathComponent!.path! + "/NeetMaster.sqlite-wal")
//            //let pathToStore = storeSQLiteURL?.URLByDeletingLastPathComponent
//            
//            
//            if fileManager.fileExistsAtPath(storeSQLiteURL!.path!) {
//                
//                //端末内の自動生成ファイルを削除する
//                try fileManager.removeItemAtURL(storeSQLiteURL!)
////                try fileManager.removeItemAtURL(storeSQLshmURL)
////                try fileManager.removeItemAtURL(storeSQLwalURL)
//                
//            } else {
//                print("storeSQLiteFile not exist")
//            }
//            
//            
//            
//            // file URL to preload
//            let preloadSQLiteURL = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("NeetMaster", ofType: "sqlite")!)
////            let preloadSQLshmURL = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("NeetMaster", ofType: "sqlite-shm")!)
////            let preloadSQLwalURL = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("NeetMaster", ofType: "sqlite-wal")!)
//            
//            
//            print("storeSQLiteURL:  \(storeSQLiteURL)")
////            print("storeSQLshmURL:  \(storeSQLshmURL)")
////            print("storeSQLwalURL:  \(storeSQLwalURL)")
//            print("sql:  \(preloadSQLiteURL)")
////            print("shm:  \(preloadSQLshmURL)")
////            print("wal:  \(preloadSQLwalURL)")
//            
//            //コピーする
//            try fileManager.copyItemAtURL(preloadSQLiteURL, toURL: storeSQLiteURL!)
////            try fileManager.copyItemAtURL(preloadSQLshmURL, toURL: storeSQLshmURL)
////            try fileManager.copyItemAtURL(preloadSQLwalURL, toURL: storeSQLwalURL)
//            
//            
//        } catch let error {
//            print("Error...\(error)")
//        }
        return true
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
        NSNotificationCenter.defaultCenter().postNotificationName(
            "applicationDidEnterBackground", object: nil)
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
        NSNotificationCenter.defaultCenter().postNotificationName(
            "applicationWillEnterForeground", object: nil)
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        // Saves changes in the application's managed object context before the application terminates.
 //       self.saveContext()
        MagicalRecord.cleanUp()
    }

    // MARK: - Core Data stack

    lazy var applicationDocumentsDirectory: NSURL = {
        // The directory the application uses to store the Core Data store file. This code uses a directory named "com.KojiIshikawa.NeeNeeApp" in the application's documents Application Support directory.
        let urls = NSFileManager.defaultManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask)
        return urls[urls.count-1]
    }()

    lazy var managedObjectModel: NSManagedObjectModel = {
        // The managed object model for the application. This property is not optional. It is a fatal error for the application not to be able to find and load its model.
        let modelURL = NSBundle.mainBundle().URLForResource("NeeNeeApp", withExtension: "momd")!
        return NSManagedObjectModel(contentsOfURL: modelURL)!
    }()

    lazy var persistentStoreCoordinator: NSPersistentStoreCoordinator = {
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
        // Returns the managed object context for the application (which is already bound to the persistent store coordinator for the application.) This property is optional since there are legitimate error conditions that could cause the creation of the context to fail.
        let coordinator = self.persistentStoreCoordinator
        var managedObjectContext = NSManagedObjectContext(concurrencyType: .MainQueueConcurrencyType)
        managedObjectContext.persistentStoreCoordinator = coordinator
        return managedObjectContext
    }()

    // MARK: - Core Data Saving support

    func saveContext () {
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

