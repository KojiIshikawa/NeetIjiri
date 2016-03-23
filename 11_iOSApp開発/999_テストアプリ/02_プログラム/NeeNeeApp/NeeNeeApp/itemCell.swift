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
        
        _img = UIImageView(frame: CGRectMake(0,0,100,100))
        _name = UILabel()
        _name.sizeToFit()
        _name.font = UIFont(name: "HiraMinProN-W6", size: 8)
        //_name.textColor = UIColor.redColor()
        
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
                multiplier: 1.0,
                constant: 20
            )
            
        ])
    }

    required init(coder aDecoder: NSCoder){
        super.init(coder: aDecoder)!
    }

}