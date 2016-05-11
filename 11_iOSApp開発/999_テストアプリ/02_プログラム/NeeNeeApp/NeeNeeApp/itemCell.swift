//
//  itemCell.swift
//  NeeNeeApp
//
//  Created by Boil Project on 2016/01/26.
//  Copyright © 2016年 Boil Project. All rights reserved.
//

import Foundation
import UIKit

class itemCell: UICollectionViewCell {

    var _img:UIImageView!
    var _name:UILabel!
    
    override init(frame: CGRect){
        super.init(frame: frame)
        
        // セッションからアクションセット画面のサイズを取得
        let ud1 = NSUserDefaults.standardUserDefaults()
        let udActionSize : CGFloat! = CGFloat(ud1.floatForKey("ACTIONSET_SIZE"))

        _img = UIImageView(frame: CGRectMake(
            0,0
           ,udActionSize
           ,udActionSize))
        
        _name = UILabel()
        _name.sizeToFit()
        _name.numberOfLines = 0
        _name.textAlignment = NSTextAlignment.Center
        _name.font = UIFont(name: "HiraMinProN-W6", size: 8)
        
        self.addSubview(_img)
        self.addSubview(_name)
        
        self._name.translatesAutoresizingMaskIntoConstraints = false
        
        // 個数の制約
        self.addConstraints([
            
            // x座標
            NSLayoutConstraint(
                item: self._name,
                attribute:  NSLayoutAttribute.CenterX,
                relatedBy: .Equal,
                toItem: self,
                attribute:  NSLayoutAttribute.CenterX,
                multiplier: 1.0,
                constant: 0
            ),
            
            // y座標
            NSLayoutConstraint(
                item: self._name,
                attribute: NSLayoutAttribute.CenterY,
                relatedBy: .Equal,
                toItem: self,
                attribute:  NSLayoutAttribute.CenterY,
                multiplier: 1.4 / 1.0,
                constant: 0
            )
        ])
    }

    required init(coder aDecoder: NSCoder){
        super.init(coder: aDecoder)!
    }

}