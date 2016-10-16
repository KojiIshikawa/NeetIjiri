//
//  AppDelegate.swift
//  NeeNeeApp
//
//  Created by Boil Project on 2015/12/27.
//  Copyright © 2015年 Boil Project. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.

        print(Date().description, #function, #line)
        
        //coredataでやりとりするsqliteを設定
        MagicalRecord.setupCoreDataStack(withAutoMigratingSqliteStoreNamed: "NeetMaster.sqlite")
        
        //全件削除
        M_Kakugen.mr_truncateAll()
        M_Okan.mr_truncateAll()
        M_Job.mr_truncateAll()
        M_Item.mr_truncateAll()
        M_Stage.mr_truncateAll()
        M_ActionImage.mr_truncateAll()
        M_ActionResult.mr_truncateAll()
        M_DropItem.mr_truncateAll()
 
        
        //バンドルのマスタをストアへ移行する
        let preloadSQLiteURL = Bundle.main.path(forResource: "Master", ofType: "sqlite")
        let db = FMDatabase(path: preloadSQLiteURL)

        let sqlKakugen = "SELECT * FROM M_Kakugen;" //格言マスタ
        let sqlOkan = "SELECT * FROM M_Okan;" //おかんマスタ
        let sqlJob = "SELECT * FROM M_Job;" //役職マスタ
        let sqlItem = "SELECT * FROM M_Item;" //アイテムマスタ
        let sqlStage = "SELECT * FROM M_Stage;" //ステージマスタ
        let sqlActionImage = "SELECT * FROM M_ActionImage;" //行動画像マスタ
        let sqlActionResult = "SELECT * FROM M_ActionResult;" //行動結果マスタ
        let sqlDropItem = "SELECT * FROM M_DropItem;" //ドロップアイテムマスタ
        
        
        db?.open()
        
        var i = 0
        
        //格言マスタ
        let res_Kakugen = db?.executeQuery(sqlKakugen, withArgumentsIn: nil)
        while (res_Kakugen?.next())! {
            let newRecord: M_Kakugen = M_Kakugen.mr_createEntity()! as M_Kakugen
            newRecord.kakugenID = NSNumber(value: (res_Kakugen?.int(forColumn: "kakugenID"))! as Int32)
            newRecord.kakugenText = res_Kakugen?.string(forColumn: "kakugenText")
            newRecord.viewNo = NSNumber(value: (res_Kakugen?.int(forColumn: "viewNo"))! as Int32)
            newRecord.managedObjectContext!.mr_saveToPersistentStoreAndWait()
            i += 1
        }
        print("件数\(i)")
        i = 0
        
        //おかんマスタ
        let res_Okan = db?.executeQuery(sqlOkan, withArgumentsIn: nil)
        while (res_Okan?.next())! {
            let newRecord: M_Okan = M_Okan.mr_createEntity()! as M_Okan
            newRecord.okanID = NSNumber(value: (res_Okan?.int(forColumn: "okanID"))! as Int32)
            newRecord.okanText = res_Okan?.string(forColumn: "okanText")
            newRecord.loginDays = NSNumber(value: (res_Okan?.int(forColumn: "loginDays"))! as Int32)
            newRecord.managedObjectContext!.mr_saveToPersistentStoreAndWait()
            i += 1

        }
        print("件数\(i)")
        i = 0
        
        //役職マスタ
        let res_Job = db?.executeQuery(sqlJob, withArgumentsIn: nil)
        while (res_Job?.next())! {
            let newRecord: M_Job = M_Job.mr_createEntity()! as M_Job
            newRecord.jobID = NSNumber(value: (res_Job?.int(forColumn: "jobID"))! as Int32)
            newRecord.maxStageID = NSNumber(value: (res_Job?.int(forColumn: "maxStageID"))! as Int32)
            newRecord.jobName = res_Job?.string(forColumn: "jobName")
            newRecord.jobText = res_Job?.string(forColumn: "jobText")
            newRecord.viewNo = NSNumber(value: (res_Job?.int(forColumn: "viewNo"))! as Int32)
            newRecord.managedObjectContext!.mr_saveToPersistentStoreAndWait()
            i += 1
        }
        print("件数\(i)")
        i = 0
        
        //アイテムマスタ
        let res_Item = db?.executeQuery(sqlItem, withArgumentsIn: nil)
        while (res_Item?.next())! {
            let newRecord: M_Item = M_Item.mr_createEntity()! as M_Item
            newRecord.itemID = NSNumber(value: (res_Item?.int(forColumn: "itemID"))! as Int32)
            newRecord.stageID = NSNumber(value: (res_Item?.int(forColumn: "stageID"))! as Int32)
            newRecord.animeKBN = NSNumber(value: (res_Item?.int(forColumn: "animeKBN"))! as Int32)
            newRecord.itemName = res_Item?.string(forColumn: "itemName")
            newRecord.itemText = res_Item?.string(forColumn: "itemText")
            newRecord.imageItem = res_Item?.string(forColumn: "imageItem")
            newRecord.point = NSNumber(value: (res_Item?.int(forColumn: "point"))! as Int32)
            newRecord.procTime = NSNumber(value: (res_Item?.int(forColumn: "procTime"))! as Int32)
            newRecord.useArea = NSNumber(value: (res_Item?.int(forColumn: "useArea"))! as Int32)
            newRecord.viewNo = NSNumber(value: (res_Item?.int(forColumn: "viewNo"))! as Int32)
            newRecord.firstX = NSNumber(value: (res_Item?.int(forColumn: "firstX"))! as Int32)
            newRecord.firstY = NSNumber(value: (res_Item?.int(forColumn: "firstY"))! as Int32)
            newRecord.minX = NSNumber(value: (res_Item?.int(forColumn: "minX"))! as Int32)
            newRecord.maxX = NSNumber(value: (res_Item?.int(forColumn: "maxX"))! as Int32)
            newRecord.minY = NSNumber(value: (res_Item?.int(forColumn: "minY"))! as Int32)
            newRecord.maxY = NSNumber(value: (res_Item?.int(forColumn: "maxY"))! as Int32)
            newRecord.managedObjectContext!.mr_saveToPersistentStoreAndWait()
            i += 1
        }
        print("件数\(i)")
        i = 0

        //ステージマスタ
        let res_Stage = db?.executeQuery(sqlStage, withArgumentsIn: nil)
        while (res_Stage?.next())! {
            let newRecord: M_Stage = M_Stage.mr_createEntity()! as M_Stage
            newRecord.stageID = NSNumber(value: (res_Stage?.int(forColumn: "stageID"))! as Int32)
            newRecord.stageName = res_Stage?.string(forColumn: "stageName")
            newRecord.stageText = res_Stage?.string(forColumn: "stageText")
            newRecord.bgm = res_Stage?.string(forColumn: "bgm")
            newRecord.imageBack = res_Stage?.string(forColumn: "imageBack")
            newRecord.viewNo = NSNumber(value: (res_Stage?.int(forColumn: "viewNo"))! as Int32)
            newRecord.managedObjectContext!.mr_saveToPersistentStoreAndWait()
            i += 1
        }
        print("件数\(i)")
        i = 0
        
        //行動画像マスタ
        let res_ActionImage = db?.executeQuery(sqlActionImage, withArgumentsIn: nil)
        while (res_ActionImage?.next())! {
            let newRecord: M_ActionImage = M_ActionImage.mr_createEntity()! as M_ActionImage
            newRecord.itemID = NSNumber(value: (res_ActionImage?.int(forColumn: "itemID"))! as Int32)
            newRecord.imageAct = res_ActionImage?.string(forColumn: "imageAct")
            newRecord.way = NSNumber(value: (res_ActionImage?.int(forColumn: "way"))! as Int32)
            newRecord.managedObjectContext!.mr_saveToPersistentStoreAndWait()
            i += 1
        }
        print("件数\(i)")
        i = 0
        
        //行動結果マスタ
        let res_ActionResult = db?.executeQuery(sqlActionResult, withArgumentsIn: nil)
        while (res_ActionResult?.next())! {
            let newRecord: M_ActionResult = M_ActionResult.mr_createEntity()! as M_ActionResult
            newRecord.itemID = NSNumber(value: (res_ActionResult?.int(forColumn: "itemID"))! as Int32)
            newRecord.resultID = NSNumber(value: (res_ActionResult?.int(forColumn: "resultID"))! as Int32)
            newRecord.message = res_ActionResult?.string(forColumn: "message")
            newRecord.resPer = NSNumber(value: (res_ActionResult?.int(forColumn: "resPer"))! as Int32)
            newRecord.rankKBN = res_ActionResult?.string(forColumn: "rankKBN")
            newRecord.managedObjectContext!.mr_saveToPersistentStoreAndWait()
            i += 1
        }
        print("件数\(i)")
        i = 0
        
        //ドロップアイテムマスタ
        let res_DropItem = db?.executeQuery(sqlDropItem, withArgumentsIn: nil)
        while (res_DropItem?.next())! {
            let newRecord: M_DropItem = M_DropItem.mr_createEntity()! as M_DropItem
            newRecord.itemID = NSNumber(value: (res_DropItem?.int(forColumn: "itemID"))! as Int32)
            newRecord.dropItemID = NSNumber(value: (res_DropItem?.int(forColumn: "dropItemID"))! as Int32)
            newRecord.dropPer = NSNumber(value: (res_DropItem?.int(forColumn: "dropPer"))! as Int32)
            newRecord.managedObjectContext!.mr_saveToPersistentStoreAndWait()
            i += 1
        }
        print("件数\(i)")
        i = 0

        db?.close()

        //インターステイシャル広告の読み込み
        NADInterstitial.sharedInstance().loadAd(withApiKey: "44f368525bf701c52095f5ea3801bdb9c31cf0c0", spotId: "631009")
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
        NotificationCenter.default.post(
            name: Notification.Name(rawValue: "applicationDidEnterBackground"), object: nil)
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
        NotificationCenter.default.post(
            name: Notification.Name(rawValue: "applicationWillEnterForeground"), object: nil)
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        // Saves changes in the application's managed object context before the application terminates.
 //       self.saveContext()
        MagicalRecord.cleanUp()
    }

    // MARK: - Core Data stack

    lazy var applicationDocumentsDirectory: URL = {
        // The directory the application uses to store the Core Data store file. This code uses a directory named "com.KojiIshikawa.NeeNeeApp" in the application's documents Application Support directory.
        let urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return urls[urls.count-1]
    }()

    lazy var managedObjectModel: NSManagedObjectModel = {
        // The managed object model for the application. This property is not optional. It is a fatal error for the application not to be able to find and load its model.
        let modelURL = Bundle.main.url(forResource: "NeeNeeApp", withExtension: "momd")!
        return NSManagedObjectModel(contentsOf: modelURL)!
    }()

    lazy var persistentStoreCoordinator: NSPersistentStoreCoordinator = {
        // The persistent store coordinator for the application. This implementation creates and returns a coordinator, having added the store for the application to it. This property is optional since there are legitimate error conditions that could cause the creation of the store to fail.
        // Create the coordinator and store
        let coordinator = NSPersistentStoreCoordinator(managedObjectModel: self.managedObjectModel)
        let url = self.applicationDocumentsDirectory.appendingPathComponent("SingleViewCoreData.sqlite")
        var failureReason = "There was an error creating or loading the application's saved data."
        do {
            try coordinator.addPersistentStore(ofType: NSSQLiteStoreType, configurationName: nil, at: url, options: nil)
        } catch {
            // Report any error we got.
            var dict = [String: AnyObject]()
            dict[NSLocalizedDescriptionKey] = "Failed to initialize the application's saved data" as AnyObject?
            dict[NSLocalizedFailureReasonErrorKey] = failureReason as AnyObject?

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
        var managedObjectContext = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
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

