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
//        print(NSDate().description, __FUNCTION__, __LINE__)
        
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
            myAudioPlayer = try AVAudioPlayer(contentsOfURL: NSURL(fileURLWithPath:bgmPath))
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
            mySePlayer = try AVAudioPlayer(contentsOfURL: NSURL(fileURLWithPath:sePath))
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

}


