//
//  ViewController.swift
//  v2MagicalRecord
//
//  Created by v2_system on 2016/01/22.
//  Copyright © 2016年 v2_system. All rights reserved.
//

import UIKit

class TopViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    private var GorokuObjects: [GorokuM] = [];
    @IBOutlet weak var tableView: UITableView!
    

    

    //****************************************
    // MARK: - ViewController Event
    //****************************************
    
    override func viewDidLoad() {
        print(NSDate().description, __FUNCTION__, __LINE__)
        
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.reloadData()
        
    }
    
    override func viewWillAppear(animated: Bool) {
        print(NSDate().description, __FUNCTION__, __LINE__)
        
        super.viewWillAppear(animated)
        self.reloadData()
    }

    override func didReceiveMemoryWarning() {
        print(NSDate().description, __FUNCTION__, __LINE__)

        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }



    //****************************************
    // MARK: - TableView data source
    //****************************************
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(NSDate().description, __FUNCTION__, __LINE__)
        return GorokuObjects.count
    }
    
    ///test
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        print(NSDate().description, __FUNCTION__, __LINE__)
        let cell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: "GorokuCell") as UITableViewCell
        
        
        cell.textLabel?.text = String(GorokuObjects[indexPath.row].gorokuValue)
        cell.detailTextLabel?.text = "\(GorokuObjects[indexPath.row].gorokuCode)"

        return cell
    }
    
    
    //****************************************
    // MARK: - TableView delegate
    //****************************************
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        print(NSDate().description, __FUNCTION__, __LINE__)
        if editingStyle == UITableViewCellEditingStyle.Delete {
            // Entityの削除 delete entity
            let todoObject = GorokuObjects[indexPath.row]
            todoObject.MR_deleteEntity()
            
            todoObject.managedObjectContext?.MR_saveToPersistentStoreAndWait()
            
            GorokuObjects = GorokuM.MR_findAll() as! [GorokuM]
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Fade)
        }
    }
    
    
    func tableView(tableView: UITableView, editingStyleForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCellEditingStyle {
        print(NSDate().description, __FUNCTION__, __LINE__)
        return UITableViewCellEditingStyle.Delete;
    }
    

    
    //****************************************
    // MARK: - Utility Method
    //****************************************
    
    private func reloadData() {
        print(NSDate().description, __FUNCTION__, __LINE__)
//        GorokuObjects = GorokuM.MR_findAll() as! [GorokuM]
        GorokuObjects = GorokuM.MR_findAllSortedBy("gorokuCode", ascending: true) as! [GorokuM]
        tableView.reloadData()
    }

}

