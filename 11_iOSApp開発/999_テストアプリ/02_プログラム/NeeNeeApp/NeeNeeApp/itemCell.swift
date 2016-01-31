//
//  itemCell.swift
//  NeeNeeApp
//
//  Created by 石川晃次 on 2016/01/26.
//  Copyright © 2016年 KojiIshikawa. All rights reserved.
//

import Foundation
import UIKit

class itemCell: UICollectionViewCell {

    var _img:UIImageView!
    var _name:UILabel!
    
    override init(frame: CGRect){
        super.init(frame: frame)
        _img = UIImageView(frame: CGRectMake(0,0,50,50))
        _name = UILabel(frame: CGRectMake(0,0,50,50))
        self.addSubview(_img)
        self.addSubview(_name)
    }

    required init(coder aDecoder: NSCoder){
        super.init(coder: aDecoder)!
    }

}