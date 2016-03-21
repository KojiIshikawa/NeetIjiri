//
//  Utility.swift
//  NeeNeeApp
//
//  Created by v2_system on 2016/02/11.
//  Copyright © 2016年 KojiIshikawa. All rights reserved.
//

import Foundation
import AVFoundation

class Utility {
    
    // BGM・SEの再生用オブジェクト
    static private var myAudioPlayer: AVAudioPlayer!
    static private var mySePlayer: AVAudioPlayer!
    
    //画像をキャッシュせず読み込むメソッド
    class func getUncachedImage (named name : String) -> UIImage?
    {
        if let imgPath = NSBundle.mainBundle().pathForResource(name, ofType: nil)
        {
            return UIImage(contentsOfFile: imgPath)
        }
        return nil
    }
    
    
    class func bgmSoundPlay(bgmPath: String)
    {
        print(NSDate().description, __FUNCTION__, __LINE__)
        
        //userDefaultからボリューム値を取得
        let ud = NSUserDefaults.standardUserDefaults()
        var udBGM : Float! = ud.floatForKey("VOL_BGM")
        
        if udBGM < 0.0 {
            udBGM = 0.5
        }
        
        //再生
        do {
            //再生中ならストップする.
            if myAudioPlayer != nil {
                myAudioPlayer.stop()
            }
            
            myAudioPlayer = try AVAudioPlayer(contentsOfURL: NSURL(fileURLWithPath:NSBundle.mainBundle().pathForResource(bgmPath == "" ? Const.DEFAULT_BGM_PATH : bgmPath, ofType:"mp3")!
))
            myAudioPlayer.volume = udBGM
            myAudioPlayer.numberOfLoops = -1
            myAudioPlayer.play()
            
        }catch{
            // 例外発生
        }
   }
   
    
    class func bgmVolumeChange(volume: Float)
    {
        print(NSDate().description, __FUNCTION__, __LINE__)
        myAudioPlayer.volume = volume
    }

    class func bgmStop()
    {
        print(NSDate().description, __FUNCTION__, __LINE__)
        myAudioPlayer.stop()
    }
    
    /** SE再生 **/
    //ファイルのパス
    class func seSoundPlay(sePath: String)
    {
        print(NSDate().description, __FUNCTION__, __LINE__)
        
        //userDefaultからボリューム値を取得
        let ud = NSUserDefaults.standardUserDefaults()
        var udSE : Float! = ud.floatForKey("VOL_SE")
        
        if udSE < 0.0 {
            udSE = 0.5
        }

        
        // SEを再生する.
        do {
            mySePlayer = try AVAudioPlayer(contentsOfURL: NSURL(fileURLWithPath:NSBundle.mainBundle().pathForResource(sePath == "" ? Const.DEFAULT_SE_PATH : sePath, ofType:"mp3")!))
            mySePlayer.volume = udSE * 2
            mySePlayer.play()
            
        }catch{
            // 例外発生
        }
    }
    
    class func seVolumeChange(volume: Float)
    {
        print(NSDate().description, __FUNCTION__, __LINE__)
        mySePlayer.volume = volume * 2
    }
    
    class func seStop()
    {
        print(NSDate().description, __FUNCTION__, __LINE__)
        mySePlayer.stop()
    }

    
    //****************************************
    // MARK: - DB Access
    //****************************************
    
    /** 基本情報の取得 **/
    class func getCharaBase(charaId: Int) -> [T_CharaBase]  {
        print(NSDate().description, __FUNCTION__, __LINE__)
        
        return T_CharaBase.MR_findByAttribute("charaID", withValue: charaId) as! [T_CharaBase];
    }
    
    /** アイテム情報の取得 **/
    class func getMItem(itemId: Int) -> [M_Item]  {
        print(NSDate().description, __FUNCTION__, __LINE__)
        
        return M_Item.MR_findByAttribute("itemID", withValue: itemId) as! [M_Item];
    }
    
    /** ステージ情報の取得 **/
    class func getMStage(stageId: Int) -> [M_Stage]  {
        print(NSDate().description, __FUNCTION__, __LINE__)
        
        return M_Stage.MR_findByAttribute("stageID", withValue: stageId) as! [M_Stage];
    }

    /** アクション情報の取得 **/
    class func getMAction(stageId: Int, actionId: Int) -> [M_Action] {
        print(NSDate().description, __FUNCTION__, __LINE__)
        
        let actionList = M_Action.MR_findByAttribute("stageID", withValue: stageId) as! [M_Action];

        var resultActionList:[M_Action] = []
        
        for action in actionList {
            
            // 一致する場合、アイテム情報をセットする.
            if action.actID == actionId {
                
                // アクションを返却する.
                resultActionList.append(action)
                return resultActionList
            }
            
        }
        
    return resultActionList
    }
    
}


