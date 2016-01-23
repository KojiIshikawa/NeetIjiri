//
//  InputViewController.swift
//  v2MagicalRecord
//
//  Created by v2_system on 2016/01/24.
//  Copyright © 2016年 v2_system. All rights reserved.
//

import UIKit
import Foundation

class InputViewController: UIViewController {
    
    
    @IBOutlet weak var txtGoroku: UITextField!

    
    // MARK: - User interaction
    
    @IBAction func didTouchDoneButton(sender : AnyObject) {
        print(NSDate().description, __FUNCTION__, __LINE__)
        
        if txtGoroku.text!.isEmpty {
            print("入力検証")
            return
        }
    
        let gorokuList :[GorokuM] = GorokuM.MR_findAll() as! [GorokuM];
        
        // Entityを追加
        let goroku = GorokuM.MR_createEntity() as GorokuM!
        
        goroku.gorokuCodeValue = gorokuList.count+1
        goroku.gorokuValue = txtGoroku.text
        goroku.deleteFlgValue = 0
        // CoreDataに保存する（永続化）
        goroku.managedObjectContext?.MR_saveToPersistentStoreAndWait()
        
        self.navigationController?.popViewControllerAnimated(true)
    }
}