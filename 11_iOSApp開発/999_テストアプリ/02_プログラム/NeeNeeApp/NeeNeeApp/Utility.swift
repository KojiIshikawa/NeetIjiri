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
    private var myAudioPlayer: AVAudioPlayer!
    static private var mySePlayer: AVAudioPlayer!

    //画像をキャッシュせず読み込むメソッド
    class func getUncachedImage (named name : String) -> UIImage?
    {
        print(NSDate().description, __FUNCTION__, __LINE__)
        
        if let imgPath = NSBundle.mainBundle().pathForResource(name, ofType: nil)
        {
            return UIImage(contentsOfFile: imgPath)
        }
        return nil
    }
    
    
    
    /** SE再生 **/
    class func seSoundPlay(sePath: String)
    {
        print(NSDate().description, __FUNCTION__, __LINE__)
        
        // SEを再生する.
        do {
            mySePlayer = try AVAudioPlayer(contentsOfURL: NSURL(fileURLWithPath:sePath))
            //            mySePlayer.volume = seVolumeSBar.value * 2
            mySePlayer.play()
            
        }catch{
            // 例外発生
        }
    }

}


