//
//  Utility.swift
//  NeeNeeApp
//
//  Created by Boil Project on 2016/02/11.
//  Copyright © 2016年 Boil Project. All rights reserved.
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
        print(name)
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
            
            myAudioPlayer = try AVAudioPlayer(contentsOfURL: NSURL(fileURLWithPath:NSBundle.mainBundle().pathForResource(bgmPath == "" ? Const.BGM_DEFAULT_PATH : bgmPath, ofType:"mp3")!
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
            mySePlayer = try AVAudioPlayer(contentsOfURL: NSURL(fileURLWithPath:NSBundle.mainBundle().pathForResource(sePath == "" ? Const.SE_DEFAULT_PATH : sePath, ofType:"mp3")!))
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

    /** アクションイメージ情報の取得 **/
    class func getMActionImage(itemId: Int) -> [M_ActionImage] {
        print(NSDate().description, __FUNCTION__, __LINE__)
        
        return M_ActionImage.MR_findByAttribute("itemID", withValue: itemId, andOrderBy: "way,serialNo", ascending: true) as! [M_ActionImage];
    }
    

    /** 取得済アイテム情報の取得 **/
    class func getTGetItem(charaId: Int) -> [T_GetItem] {
        print(NSDate().description, __FUNCTION__, __LINE__)
        
        return T_GetItem.MR_findByAttribute("charaID", withValue: String(charaId), andOrderBy: "itemID", ascending: true) as! [T_GetItem];
    }
    
    /** 行動済かつ、未完了な行動結果履歴の取得 **/
    class func getFinishedTActionResult(charaId: Int) -> [T_ActionResult] {
        print(NSDate().description, __FUNCTION__, __LINE__)
        
        let profileFilter: NSPredicate = NSPredicate(format: "charaID = %@ AND actEndDate <> nil AND finishFlg = '0'", String(charaId))
        return  T_ActionResult.MR_findAllSortedBy("actSetDate", ascending: true, withPredicate: profileFilter) as! [T_ActionResult];
    }
    
    /** 所持ステージの書き込み **/
     class func editT_RefStage(stageId:Int) {
        print(NSDate().description, __FUNCTION__, __LINE__)

        let filter: NSPredicate =
            NSPredicate(format: "charaID = " + String(Const.CHARACTER1_ID) + " and stageID = " + String(stageId))
    
        let refStage :[T_RefStage] = T_RefStage.MR_findAllSortedBy("charaID,stageID", ascending: true, withPredicate: filter) as! [T_RefStage];
        
        // ステージを所持していない場合
        if (refStage.count == 0) {

            // 所持ステージを追加する.
            let initItem = T_RefStage.MR_createEntity()! as T_RefStage
            initItem.charaID = Const.CHARACTER1_ID
            initItem.stageID = stageId
            initItem.managedObjectContext!.MR_saveToPersistentStoreAndWait()
        }
    }
    
    
    /** 所持ステージの書き込み **/
    class func editT_RefJob(stageId:Int) {
        print(NSDate().description, __FUNCTION__, __LINE__)

        // 該当ステージに一致するジョブを取得する.
        let filter1: NSPredicate = NSPredicate(format: "maxStageID = " + String(stageId))
        
        let mJob :[M_Job] = M_Job.MR_findAllSortedBy("maxStageID", ascending: true, withPredicate: filter1) as! [M_Job];

        // 所持済のジョブの存在チェックをする.
        let filter2: NSPredicate =
        NSPredicate(format: "charaID = " + String(Const.CHARACTER1_ID) + " and jobID = " + String(mJob[0].jobID))
        
        let refJob :[T_RefJob] = T_RefJob.MR_findAllSortedBy("charaID,jobID", ascending: true, withPredicate: filter2) as! [T_RefJob];
        
        // ステージに該当するジョブを所持していない場合
        if (refJob.count == 0) {
            
            // 所持ステージを追加する.
            let addJob = T_RefJob.MR_createEntity()! as T_RefJob
            addJob.charaID = Const.CHARACTER1_ID
            addJob.jobID = mJob[0].jobID
            addJob.managedObjectContext!.MR_saveToPersistentStoreAndWait()
        }
    }
    
    class func getRankName(rankKBN: String) -> String  {
        print(NSDate().description, __FUNCTION__, __LINE__)

        var ret = ""
        
        switch rankKBN {
        case "S":
            ret = "大成功！ひまゲット率２倍！"
            
        case "A":
            ret = "成功"
            
        case "B":
            ret = "普通"
            
        case "C":
            ret = "失敗"
            
        case "D":
            ret = "大失敗"
            
        default:
            ret = "普通"
        }
        
        return ret
    }
    
    
    class func getRankDrop(rankKBN: String) -> Float32  {
        print(NSDate().description, __FUNCTION__, __LINE__)
        
        var ret :Float32 = 1.0
        
        switch rankKBN {
        case "S":
            ret = 2.0
            
        case "A":
            ret = 1.5
            
        case "B":
            ret = 1.0
            
        case "C":
            ret = 0.8
            
        case "D":
            ret = 0.5
            
        default:
            ret = 1.0
        }
        
        return ret
    }
    
    /** 渡された日付を日本時間に変換して返却する. **/
    class func jpDate (date: NSDate) -> String {
        
        let dateFormatter1 = NSDateFormatter()
        dateFormatter1.locale = NSLocale(localeIdentifier: "ja_JP") // 日本時間
        dateFormatter1.dateFormat = "yyyy/MM/dd HH:mm:ss"
        
        return dateFormatter1.stringFromDate(date)
    }
    
    // 比率だけ指定する場合
    class func resizeImage(imageFile: String,resizewWidth: CGFloat,resizeHeight: CGFloat) -> UIImage {
        
        let imageWk: UIImage = Utility.getUncachedImage(named: imageFile)!
        
        let resizedSize = CGSize(width: Int(resizewWidth), height: Int(resizeHeight))
        UIGraphicsBeginImageContext(resizedSize)
        imageWk.drawInRect(CGRect(x: 0, y: 0, width: resizedSize.width, height: resizedSize.height))
        let resizedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return resizedImage
    }
    
    //行動結果を計算し、ドロップアイテムを返却する.
    //また、結果をテーブルへ反映する
    class func getDropItem(itemID :Int,rankKbn :String,loginUseFlg :Bool)  -> [M_DropItem] {
        print(NSDate().description, __FUNCTION__, __LINE__)
                
        //ドロップアイテムの判定
        let dropFilter: NSPredicate = NSPredicate(format: "itemID = %@", String(itemID))
        let mDropItem :[M_DropItem] = M_DropItem.MR_findAllSortedBy("dropItemID", ascending: true, withPredicate: dropFilter) as! [M_DropItem];
        
        //返却アイテム
        var retDropItem :[M_DropItem] = []
        
        //件数確認
        if (mDropItem.count == 0) {
            return retDropItem
        }
        
        //取得アイテム計算
        var randDrop : Int32 = 0 //0〜100までのランダム数値
        var dropPer : Int32 = 0 //補正込みのドロップ確率
        var getItemFilter: NSPredicate
        var tGetItem :[T_GetItem]
        
        //ドロップアイテム数分ループ処理
        for ( var j = 0; j < mDropItem.count; j++ ) {
            
            //ログイン時に使用の場合は強制的に１件のみドロップとする.
            if (loginUseFlg && retDropItem.count > 0) {
                
                //ドロップアイテムを返却する.
                return retDropItem
            }
            
            //低確率のものから抽選する.(1~100を乱数取得し、取得確率内であれば取得する)
            randDrop = Int32(arc4random_uniform(UInt32(100))) + 1;
            
            //行動結果のランクを加味する.
            dropPer = Int32(Float32(mDropItem[j].dropPer.intValue) * Utility.getRankDrop(rankKbn))
            
            //取得判定
            if (1 <= randDrop && randDrop <= dropPer) {
                
                print("アイテムを獲得しました＝%@", mDropItem[j].dropItemID)
                retDropItem.append(mDropItem[j])
                
                //所持アイテムを加算
                getItemFilter = NSPredicate(format: "charaID = %@ and itemID = %@", String(Const.CHARACTER1_ID),mDropItem[j].dropItemID)
                tGetItem = T_GetItem.MR_findAllSortedBy("itemID", ascending: false, withPredicate: getItemFilter) as! [T_GetItem];
                
                if tGetItem.count == 0 {
                    
                    //INSERT
                    let insertData = T_GetItem.MR_createEntity()! as T_GetItem
                    insertData.charaID = Const.CHARACTER1_ID
                    insertData.itemID = mDropItem[j].dropItemID
                    insertData.itemCount = 1
                    insertData.managedObjectContext!.MR_saveToPersistentStoreAndWait()
                    
                } else {
                    
                    //UPDATE
                    tGetItem[0].itemCount = Int(tGetItem[0].itemCount) + 1
                    tGetItem[0].managedObjectContext!.MR_saveToPersistentStoreAndWait()
                }
            }
        }
        
        //ドロップアイテムを返却する
        return retDropItem
    }
    
    //データ管理文字列表示用に指定した文字で改行コードを入れて返却する.
    class func insertReturn(str :String, interval:Int)  -> String {
        print(NSDate().description, __FUNCTION__, __LINE__)
        
        //返却する文字列を宣言
        var retStr = ""
        var i = 0
        
        for char in str.characters {
            retStr += (i >= (interval - 1) && i % (interval - 1) == 0) ? String(char) + "\n" : String(char)
            i++
        }
        //文字列を返却
        return retStr
        
        
    }
    
    
}



