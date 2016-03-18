//
//  Const.swift
//  NeeNeeApp
//
//  Created by v2_system on 2016/02/07.
//  Copyright © 2016年 KojiIshikawa. All rights reserved.
//

import Foundation





//****************************************
// MARK: - 定数定義クラス
//アプリ内で使用する定数はこちらへ記述しましょう
//****************************************
class Const {
    static let TEST_NAME = ""
    static let CHARACTER1_ID = 1
    static let QUESTION_TEXT = "？？？？？？？？？？"
    static let mySongPath = NSBundle.mainBundle().pathForResource("暇で忙しい", ofType:"mp3")
    static let myOpeningPath = NSBundle.mainBundle().pathForResource("start data config", ofType:"mp3")
    static let mySeStartPath = NSBundle.mainBundle().pathForResource("se5", ofType:"mp3")
    static let mySeYesPath = NSBundle.mainBundle().pathForResource("se4", ofType:"mp3")
    static let mySeNoPath = NSBundle.mainBundle().pathForResource("se6", ofType:"mp3")
    static let mySeItemSetPath = NSBundle.mainBundle().pathForResource("se1", ofType:"mp3")
    static let mySeItemSetNGPath = NSBundle.mainBundle().pathForResource("se12", ofType:"mp3")
    static let mySeItemCancelNoPath = NSBundle.mainBundle().pathForResource("se13", ofType:"mp3")
    static let ACTION_START_TIME_INTERVAL:Float = 60 * 3
    static let ACTION_END_TIME_INTERVAL:Float = 60 * 5
}