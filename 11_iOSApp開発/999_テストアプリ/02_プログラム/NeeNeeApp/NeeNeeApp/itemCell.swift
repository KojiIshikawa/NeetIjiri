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
        let ud1 = UserDefaults.standard
        let udActionSize : CGFloat! = CGFloat(ud1.float(forKey: "ACTIONSET_SIZE"))

        _img = UIImageView(frame: CGRect(
            x: 0,y: 0
           ,width: udActionSize
           ,height: udActionSize))
        
        _name = UILabel()
        _name.sizeToFit()
        _name.numberOfLines = 0
        _name.textAlignment = NSTextAlignment.center
        _name.font = UIFont.systemFont(ofSize: Utility.getMojiSize(Const.SIZEKBN_SMALL))
        
        self.addSubview(_img)
        self.addSubview(_name)
        
        self._name.translatesAutoresizingMaskIntoConstraints = false
        
        // 個数の制約
        self.addConstraints([
            
            // x座標
            NSLayoutConstraint(
                item: self._name,
                attribute:  NSLayoutAttribute.centerX,
                relatedBy: .equal,
                toItem: self,
                attribute:  NSLayoutAttribute.centerX,
                multiplier: 1.0,
                constant: 0
            ),
            
            // y座標
            NSLayoutConstraint(
                item: self._name,
                attribute: NSLayoutAttribute.centerY,
                relatedBy: .equal,
                toItem: self,
                attribute:  NSLayoutAttribute.centerY,
                multiplier: 1.4 / 1.0,
                constant: 0
            )
        ])
    }

    required init(coder aDecoder: NSCoder){
        super.init(coder: aDecoder)!
    }

}
