//
//  ResultViewController.swift
//  NeeNeeApp
//
//  Created by v2_system on 2016/02/11.
//  Copyright © 2016年 KojiIshikawa. All rights reserved.
//

import Foundation


//行動結果の表示画面です。
//ログイン時、またはタイマーイベントで呼び出されます。
class ResultViewController: UIViewController {
    
    // 背景
    private var imgResultView: UIImageView!

    //画面オブジェクト
    private var lblResult: UILabel! //ラベル
    private var btnOK: UIButton! //OKボタン

    // view ロード完了時
    override func viewDidLoad() {
        print(NSDate().description, NSStringFromClass(self.classForCoder), #function, #line)
        
        super.viewDidLoad()
        
        //背景
        imgResultView = UIImageView(frame: self.view.frame)
        imgResultView.image = Utility.getUncachedImage(named: "02_08_01.png")
        self.view.addSubview(imgResultView)
        
        // 全オブジェクトの制約設定.
        objConstraints()
        
        //行動結果を計算する
        self.getActionResult()
    }
    
    
    //メモリ消費が多くなった時に動くイベント
    override func didReceiveMemoryWarning() {
        print(NSDate().description, NSStringFromClass(self.classForCoder), #function, #line)
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    //行動結果を計算する
    //結果をテーブルへ反映する
    func getActionResult() {
        print(NSDate().description, NSStringFromClass(self.classForCoder), #function, #line)

        //*****************************
        //テストデータを作成
        //*****************************
        let charaData : [T_CharaBase] = Utility.getCharaBase(Const.CHARACTER1_ID)
        let insetData = T_ActionResult.MR_createEntity()! as T_ActionResult
        insetData.charaID = charaData[0].charaID
//        let now = NSDate()
//        let dateFormatter = NSDateFormatter()
//        dateFormatter.locale = NSLocale(localeIdentifier: "ja_JP") // 日本時間
//        dateFormatter.timeStyle = .MediumStyle
//        dateFormatter.dateStyle = .MediumStyle
        insetData.actSetDate = NSDate()
        insetData.actStartDate = NSDate()
        insetData.actEndDate = NSDate()
        insetData.itemID = 1
        insetData.resultID = 0
        insetData.managedObjectContext!.MR_saveToPersistentStoreAndWait()
        
        
        //最新の行動履歴を取得
        let profileFilter: NSPredicate = NSPredicate(format: "charaID = %@", charaData[0].charaID)
        let tActionR :[T_ActionResult] = T_ActionResult.MR_findAllSortedBy("actSetDate", ascending: false, withPredicate: profileFilter) as! [T_ActionResult];
        
        //件数確認
        if tActionR.count == 0 {
            return
        }
        
        //行動がしていない場合
        if ((tActionR[0].actEndDate) == nil) {
            return
        }
        
        //行動結果マスタ取得
        let resFilter: NSPredicate = NSPredicate(format: "itemID = %@", tActionR[0].itemID)
        let mActionR :[M_ActionResult] = M_ActionResult.MR_findAllSortedBy("resultID", ascending: true, withPredicate: resFilter) as! [M_ActionResult];
        
        
        //0~100の値をランダムで取得
        let randInt = Int32(arc4random_uniform(UInt32(100)));
        
        var minPer : Int32 = 0
        var maxPer : Int32 = 0
        var resultNo = 0
        
        //行動結果のパターン分ループ処理
        for ( var i = 0; i < mActionR.count-1 ; i += 1 ) {
            
            maxPer = minPer + mActionR[0].resPer.intValue
            
            if minPer <= randInt && randInt <= maxPer {
                resultNo = i
                break
            }
            
            minPer = minPer + mActionR[0].resPer.intValue
        }
        
        //ドロップアイテムの判定
        let dropFilter: NSPredicate = NSPredicate(format: "itemID = %@", tActionR[0].itemID)
        let mDropItem :[M_DropItem] = M_DropItem.MR_findAllSortedBy("dropPer", ascending: true, withPredicate: dropFilter) as! [M_DropItem];
        
        //件数確認
        if (mDropItem.count == 0) {
            return
        }
        
        //使用したアイテムを取得
        let usedItem = Utility.getMItem(Int(mActionR[0].itemID))
        
        // メッセージを表示
        lblResult = UILabel(frame: CGRectMake(60,80,self.view.bounds.width-100,270))
        lblResult.text = usedItem[0].itemName  + " " + Utility.getRankName(mActionR[resultNo].rankKBN) + "\n\n"
        lblResult.text! += mActionR[resultNo].message + "\n\n"

        //取得アイテムを表示
        lblResult.text! += "取得アイテム一覧" + "\n"

        
        //取得アイテム計算
        var randDrop : Int32 = 0 //0〜100までのランダム数値
        var dropPer : Int32 = 0 //補正込みのドロップ確率
//        var getItems : [Int] = []
        var mItem : [M_Item]
        var getItemFilter: NSPredicate
        var tGetItem :[T_GetItem]
        //ドロップアイテム数分ループ処理
        for ( var j = 0; j < mDropItem.count-1; j++ ) {
            //低確率のものから抽選する
            randDrop = Int32(arc4random_uniform(UInt32(100)));
            
            dropPer = mDropItem[j].dropPer.intValue * Utility.getRankDrop(mActionR[0].rankKBN)
            
            //取得判定
            if (0 <= randDrop && randDrop <= dropPer) {
                print("アイテムを獲得しました＝%@", mDropItem[j].dropItemID)
//                //配列に格納する
//                getItems.append(Int(mDropItem[j].dropItemID))

                //所持アイテムを加算
                getItemFilter = NSPredicate(format: "charaID = %@ and itemID = %@", charaData[0].charaID,mDropItem[j].dropItemID)
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
            

                
                //取得アイテムをラベルへ設定
                mItem = Utility.getMItem(Int(mDropItem[j].dropItemID))
                lblResult.text! += mItem[0].itemName + "\n"

            }
        }
        
        
        lblResult.numberOfLines = 0
        self.view.addSubview(lblResult)
        
    }

    //結果を画面に表示する
    func showResult() {
        print(NSDate().description, NSStringFromClass(self.classForCoder), #function, #line)
    }
    
    
    /** 全オブジェクトの制約設定 **/
    func objConstraints() {
        print(NSDate().description, NSStringFromClass(self.classForCoder), #function, #line)
        
        imgResultView.translatesAutoresizingMaskIntoConstraints = false
        
        // 壁紙の制約
        self.view.addConstraints([
            
            // x座標
            NSLayoutConstraint(
                item: self.imgResultView,
                attribute:  NSLayoutAttribute.Right,
                relatedBy: .Equal,
                toItem: self.view,
                attribute:  NSLayoutAttribute.Right,
                multiplier: 1.0,
                constant: 0
            ),
            
            // y座標
            NSLayoutConstraint(
                item: self.imgResultView,
                attribute: NSLayoutAttribute.Bottom,
                relatedBy: .Equal,
                toItem: self.view,
                attribute:  NSLayoutAttribute.Bottom,
                multiplier: 1.0,
                constant: 0
            ),
            
            // 横幅
            NSLayoutConstraint(
                item: self.imgResultView,
                attribute: .Width,
                relatedBy: .Equal,
                toItem: self.view,
                attribute: .Width,
                multiplier: 1.0,
                constant: 0
            ),
            
            // 縦幅
            NSLayoutConstraint(
                item: self.imgResultView,
                attribute: .Height,
                relatedBy: .Equal,
                toItem: self.view,
                attribute: .Height,
                multiplier: 1.0,
                constant: 0
            )]
        )
    }
}


