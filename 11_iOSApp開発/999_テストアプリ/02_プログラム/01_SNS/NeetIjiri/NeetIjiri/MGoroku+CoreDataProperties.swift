//
//  MGoroku+CoreDataProperties.swift
//  NeetIjiri
//
//  Created by v2_system on 2016/01/11.
//  Copyright © 2016年 v2_system. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension MGoroku {

    @NSManaged var gorokuCode: NSNumber?
    @NSManaged var gorokuValue: String?
    @NSManaged var deleteFlg: NSNumber?

}
