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
    static fileprivate var myAudioPlayer: AVAudioPlayer!
    static fileprivate var mySePlayer: AVAudioPlayer!
    
    //画像をキャッシュせず読み込むメソッド
    class func getUncachedImage (named name : String) -> UIImage?
    {
        print(name)
        if let imgPath = Bundle.main.path(forResource: name, ofType: nil)
        {
            return UIImage(contentsOfFile: imgPath)
        }
        return nil
    }
    
    
    class func bgmSoundPlay(_ bgmPath: String)
    {
        print(Date().description, #function,#function,#line)
        
        //userDefaultからボリューム値を取得
        let ud = UserDefaults.standard
        var udBGM : Float! = ud.float(forKey: "VOL_BGM")
        
        if udBGM < 0.0 {
            udBGM = 0.5
        }
        
        //再生
        do {
            //再生中ならストップする.
            if myAudioPlayer != nil {
                myAudioPlayer.stop()
            }
            
            myAudioPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath:Bundle.main.path(forResource: bgmPath == "" ? Const.BGM_DEFAULT_PATH : bgmPath, ofType:"caf")!
))
            myAudioPlayer.volume = udBGM
            myAudioPlayer.numberOfLoops = -1
            myAudioPlayer.play()
            
        }catch{
            // 例外発生
        }
   }
   
    
    class func bgmVolumeChange(_ volume: Float)
    {
        print(Date().description, #function,#line)
        myAudioPlayer.volume = volume
    }

    class func bgmStop()
    {
        print(Date().description, #function,#line)
        myAudioPlayer.stop()
    }
    
    /** SE再生 **/
    //ファイルのパス
    class func seSoundPlay(_ sePath: String)
    {
        print(Date().description, #function,#line)
        
        //userDefaultからボリューム値を取得
        let ud = UserDefaults.standard
        var udSE : Float! = ud.float(forKey: "VOL_SE")
        
        if udSE < 0.0 {
            udSE = 0.5
        }

        
        // SEを再生する.
        do {
            mySePlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath:Bundle.main.path(forResource: sePath == "" ? Const.SE_DEFAULT_PATH : sePath, ofType:"caf")!))
            mySePlayer.volume = udSE * 2
            mySePlayer.play()
            
        }catch{
            // 例外発生
        }
    }
    
    class func seVolumeChange(_ volume: Float)
    {
        print(Date().description, #function,#line)
        mySePlayer.volume = volume * 2
    }
    
    class func seStop()
    {
        print(Date().description, #function,#line)
        mySePlayer.stop()
    }

    
    //****************************************
    // MARK: - DB Access
    //****************************************
    
    /** 基本情報の取得 **/
    class func getCharaBase(_ charaId: Int) -> [T_CharaBase]  {
        print(Date().description, #function,#line)
        
        return T_CharaBase.mr_find(byAttribute: "charaID", withValue: charaId) as! [T_CharaBase];
    }
    
    /** アイテム情報の取得 **/
    class func getMItem(_ itemId: Int) -> [M_Item]  {
        print(Date().description, #function,#line)
        
        return M_Item.mr_find(byAttribute: "itemID", withValue: itemId) as! [M_Item];
    }
    
    /** ステージ情報の取得 **/
    class func getMStage(_ stageId: Int) -> [M_Stage]  {
        print(Date().description, #function,#line)
        
        return M_Stage.mr_find(byAttribute: "stageID", withValue: stageId) as! [M_Stage];
    }

    /** アクションイメージ情報の取得 **/
    class func getMActionImage(_ itemId: Int) -> [M_ActionImage] {
        print(Date().description, #function,#line)
        
        return M_ActionImage.mr_find(byAttribute: "itemID", withValue: itemId, andOrderBy: "way,serialNo", ascending: true) as! [M_ActionImage];
    }
    

    /** 取得済アイテム情報の取得 **/
    class func getTGetItem(_ charaId: Int) -> [T_GetItem] {
        print(Date().description, #function,#line)
        
        return T_GetItem.mr_find(byAttribute: "charaID", withValue: String(charaId), andOrderBy: "itemID", ascending: true) as! [T_GetItem];
    }
    
    /** 行動済かつ、未完了な行動結果履歴の取得 **/
    class func getFinishedTActionResult(_ charaId: Int) -> [T_ActionResult] {
        print(Date().description, #function,#line)
        
        let profileFilter: NSPredicate = NSPredicate(format: "charaID = %@ AND actEndDate <> nil AND finishFlg = '0'", String(charaId))
        return  T_ActionResult.mr_findAllSorted(by: "actSetDate", ascending: true, with: profileFilter) as! [T_ActionResult];
    }
    
    /** 所持ステージの書き込み **/
     class func editT_RefStage(_ stageId:Int) {
        print(Date().description, #function,#line)

        let filter: NSPredicate =
            NSPredicate(format: "charaID = " + String(Const.CHARACTER1_ID) + " and stageID = " + String(stageId))
    
        let refStage :[T_RefStage] = T_RefStage.mr_findAllSorted(by: "charaID,stageID", ascending: true, with: filter) as! [T_RefStage];
        
        // ステージを所持していない場合
        if (refStage.count == 0) {

            // 所持ステージを追加する.
            let initItem = T_RefStage.mr_createEntity()! as T_RefStage
            initItem.charaID = Const.CHARACTER1_ID as NSNumber!
            initItem.stageID = stageId as NSNumber!
            initItem.managedObjectContext!.mr_saveToPersistentStoreAndWait()
        }
    }
    
    
    /** 所持ステージの書き込み **/
    class func editT_RefJob(_ stageId:Int) {
        print(Date().description, #function,#line)

        // 該当ステージに一致するジョブを取得する.
        let filter1: NSPredicate = NSPredicate(format: "maxStageID = " + String(stageId))
        
        let mJob :[M_Job] = M_Job.mr_findAllSorted(by: "maxStageID", ascending: true, with: filter1) as! [M_Job];

        // 所持済のジョブの存在チェックをする.
        let filter2: NSPredicate =
        NSPredicate(format: "charaID = " + String(Const.CHARACTER1_ID) + " and jobID = " + String(describing: mJob[0].jobID))
        
        let refJob :[T_RefJob] = T_RefJob.mr_findAllSorted(by: "charaID,jobID", ascending: true, with: filter2) as! [T_RefJob];
        
        // ステージに該当するジョブを所持していない場合
        if (refJob.count == 0) {
            
            // 所持ステージを追加する.
            let addJob = T_RefJob.mr_createEntity()! as T_RefJob
            addJob.charaID = Const.CHARACTER1_ID as NSNumber!
            addJob.jobID = mJob[0].jobID
            addJob.managedObjectContext!.mr_saveToPersistentStoreAndWait()
        }
    }
    
    class func getRankName(_ rankKBN: String) -> String  {
        print(Date().description, #function,#line)

        var ret = ""
        
        switch rankKBN {
        case "S":
            ret = "大成功！"
            
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
    
    
    class func getRankDrop(_ rankKBN: String) -> Float32  {
        print(Date().description, #function,#line)
        
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
    class func jpDate (_ date: Date) -> String {
        
        let dateFormatter1 = DateFormatter()
        dateFormatter1.locale = Locale(identifier: "ja_JP") // 日本時間
        dateFormatter1.dateFormat = "YYYY年MM月dd日 HH時mm分"
        
        return dateFormatter1.string(from: date)
    }
    
    // 比率だけ指定する場合
    class func resizeImage(_ imageFile: String,resizewWidth: CGFloat,resizeHeight: CGFloat) -> UIImage {
        
        let imageWk: UIImage = Utility.getUncachedImage(named: imageFile)!
        
        let resizedSize = CGSize(width: Int(resizewWidth), height: Int(resizeHeight))
        UIGraphicsBeginImageContext(resizedSize)
        imageWk.draw(in: CGRect(x: 0, y: 0, width: resizedSize.width, height: resizedSize.height))
        let resizedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return resizedImage!
    }
    
    //行動結果を計算し、ドロップアイテムを返却する.
    //また、結果をテーブルへ反映する
    class func getDropItem(_ itemID :Int,rankKbn :String,loginUseFlg :Bool)  -> [M_DropItem] {
        print(Date().description, #function,#line)
                
        //ドロップアイテムの判定
        let dropFilter: NSPredicate = NSPredicate(format: "itemID = %@", String(itemID))
        let mDropItem :[M_DropItem] = M_DropItem.mr_findAllSorted(by: "dropItemID", ascending: true, with: dropFilter) as! [M_DropItem];
        
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
        for j in 0 ..< mDropItem.count  {
            
            //ログイン時に使用の場合は強制的に１件のみドロップとする.
            if (loginUseFlg && retDropItem.count > 0) {
                
                //ドロップアイテムを返却する.
                return retDropItem
            }
            
            //低確率のものから抽選する.(1~100を乱数取得し、取得確率内であれば取得する)
            randDrop = Int32(arc4random_uniform(UInt32(100))) + 1;
            
            //行動結果のランクを加味する.
            dropPer = Int32(Float32(mDropItem[j].dropPer.int32Value) * Utility.getRankDrop(rankKbn))
            
            //取得判定
            if (1 <= randDrop && randDrop <= dropPer) {
                
                print("アイテムを獲得しました＝%@", mDropItem[j].dropItemID)
                retDropItem.append(mDropItem[j])
                
                //所持アイテムを加算
                getItemFilter = NSPredicate(format: "charaID = %@ and itemID = %@", String(Const.CHARACTER1_ID),mDropItem[j].dropItemID)
                tGetItem = T_GetItem.mr_findAllSorted(by: "itemID", ascending: false, with: getItemFilter) as! [T_GetItem];
                
                if tGetItem.count == 0 {
                    
                    //INSERT
                    let insertData = T_GetItem.mr_createEntity()! as T_GetItem
                    insertData.charaID = Const.CHARACTER1_ID as NSNumber!
                    insertData.itemID = mDropItem[j].dropItemID
                    insertData.itemCount = 1
                    insertData.managedObjectContext!.mr_saveToPersistentStoreAndWait()
                    
                } else {
                    
                    //UPDATE
                    tGetItem[0].itemCount = NSNumber(Int32(tGetItem[0].itemCount)! + 1)
                    tGetItem[0].managedObjectContext!.mr_saveToPersistentStoreAndWait()
                }
            }
        }
        
        //ドロップアイテムを返却する
        return retDropItem
    }
    
    //データ管理文字列表示用に指定した文字で改行コードを入れて返却する.
    class func insertReturn(_ str :String, interval:Int)  -> String {
        print(Date().description, #function,#line)
        
        //返却する文字列を宣言
        var retStr = ""
        var i = 0
        
        for char in str.characters {
            retStr += (i >= (interval - 1) && i % (interval - 1) == 0) ? String(char) + "\n" : String(char)
            i += 1
        }
        //文字列を返却
        return retStr
    }
    
    //実行端末とサイズ区分から適切な文字サイズを返却する.
    class func getMojiSize(_ sizeKbn : Int) -> CGFloat {
        let screenSize = UIScreen.main.bounds
        let width = Int(screenSize.width)
        //let height = Int(screenSize.height)

        switch sizeKbn {
            
        case Const.SIZEKBN_SMALL:
        
            switch width {
                
            case 320:
                
                //iPhone4,5
                return 5

            case 375:
                //iPhone6
                return 6

            default:
                //iPhone6 Plus及びその他
                return 7
            }
            
        case Const.SIZEKBN_LARGE:
            
            switch width {
                
            case 320:
                
                //iPhone4,5
                return 15
                
            case 375:
                //iPhone6
                return 18
                
            default:
                //iPhone6 Plus及びその他
                return 19
            }
            
        default:
            
            //中サイズ
            switch width {
                
            case 320:
                
                //iPhone4,5
                return 12
                
            case 375:
                //iPhone6
                return 13
                
            default:
                //iPhone6 Plus及びその他
                return 14
            }

            
        }
    }

    
    
}



