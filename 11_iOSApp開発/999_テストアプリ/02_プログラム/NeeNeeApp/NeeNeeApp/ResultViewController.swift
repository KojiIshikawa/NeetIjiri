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
    

    
//    private var lblResult: UILabel //結果
//    private var lblComment: UILabel //詳細コメント
    
    // 背景
    private var imgResultView: UIImageView!

    //画面オブジェクト
    private var lblResult: UILabel! //ラベル
    private var btnOK: UIButton! //OKボタン

    
    
    // view ロード完了時
    override func viewDidLoad() {
        print(NSDate().description, String(self), __FUNCTION__, __LINE__)
        
        super.viewDidLoad()
        
        //背景
        imgResultView = UIImageView(frame: self.view.frame)
        imgResultView.image = Utility.getUncachedImage(named: "02_08_01.png")
        self.view.addSubview(imgResultView)

        
//        //OKボタン
//        btnOK = UIButton(frame: CGRectMake(20,60,self.view.bounds.width-30,120))
//        btnOK.titleLabel!.text = "OK"
//        self.view.addSubview(btnOK)

        
        
        
        
        
        //アクションが完了しているかチェックする
        self.isActionFinished()
        
        //行動結果を計算する
        self.getActionResult()
        
        //行動結果を画面に表示する
        self.showResult()
        
    }
    
    
    //メモリ消費が多くなった時に動くイベント
    override func didReceiveMemoryWarning() {
        print(NSDate().description, __FUNCTION__, __LINE__)
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    //アクションが完了しているかチェックする
    func isActionFinished() ->Bool {
    
        return true
    }
    
    //行動結果を計算する
    //結果をテーブルへ反映する
    func getActionResult() {
 
        //*****************************
        //テストデータを作成
        //行動履歴に1件INSERT
        //*****************************
        let charaData : [T_CharaBase] = Utility.getCharaBase(Const.CHARACTER1_ID)

        let insetData = T_ActionResult.MR_createEntity()! as T_ActionResult
        insetData.charaID = charaData[0].charaID
        
//        let now = NSDate()
//        let dateFormatter = NSDateFormatter()
//        dateFormatter.locale = NSLocale(localeIdentifier: "ja_JP") // ロケールの設定
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
        
        //最新のitemID
        print(tActionR[0].itemID)

        //行動がしていない場合
        if ((tActionR[0].actEndDate) == nil) {
            return
        }
        
        //行動結果判定
        let resFilter: NSPredicate = NSPredicate(format: "itemID = %@", tActionR[0].itemID)
        let mActionR :[M_ActionResult] = M_ActionResult.MR_findAllSortedBy("resultID", ascending: true, withPredicate: resFilter) as! [M_ActionResult];

        
        //0~100の値をランダムで取得
        let randInt = Int32(arc4random_uniform(UInt32(100)));
        
        var minPer : Int32 = 0
        var maxPer : Int32 = 0
        var resultNo = 0
        for ( var i = 0; i < mActionR.count-1 ; i++ ) {
            
            maxPer = minPer + mActionR[0].resPer.intValue
            if minPer <= randInt && randInt <= maxPer {
                resultNo = i
                break
            }
            minPer = minPer + mActionR[0].resPer.intValue
        }
        
        let dropFilter: NSPredicate = NSPredicate(format: "itemID = %@", tActionR[0].itemID)
        let mDropItem :[M_DropItem] = M_DropItem.MR_findAllSortedBy("dropPer", ascending: true, withPredicate: dropFilter) as! [M_DropItem];
        
        //件数確認
        if (mDropItem.count == 0) {
            return
        }
        
        //取得アイテム計算
        var randDrop : Int32 = 0
        var dropPer : Int32 = 0
        var getItems : [Int] = []
        for ( var j = 0; j < mDropItem.count-1; j++ ) {
            //低確率のものから抽選する
            randDrop = Int32(arc4random_uniform(UInt32(100)));
            
            if mActionR[0].rankKBN == "S" {
                dropPer = mDropItem[j].dropPer.intValue * 3
            } else if mActionR[0].rankKBN == "A" {
                dropPer = mDropItem[j].dropPer.intValue * 2
            } else {
                dropPer = mDropItem[j].dropPer.intValue
            }
            
            //取得判定
            if (0 <= randDrop && randDrop <= dropPer) {
                print("アイテムを獲得しました＝%@", mDropItem[j].dropItemID)
                //TODO:所持アイテムに加算
                getItems.append(Int(mDropItem[j].dropItemID))
            }
        }
        //TODO:ラベル表示用に退避
        
        
        
        


        // メッセージを表示
        lblResult = UILabel(frame: CGRectMake(60,80,self.view.bounds.width-100,250))
        
        lblResult.text = Utility.getRankName(mActionR[resultNo].rankKBN) + "\n\n"
        lblResult.text = lblResult.text! + mActionR[resultNo].message + "\n"
        
        lblResult.text = lblResult.text! + "\n"
        lblResult.text = lblResult.text! + "取得アイテム一覧" + "\n"
        
        var mItem :[M_Item]
        for item in getItems {
            mItem = Utility.getMItem(item)
            lblResult.text = lblResult.text! + mItem[0].itemName + "\n"
        }
        
        
        
        
        lblResult.numberOfLines = 0
        self.view.addSubview(lblResult)
        
        
        
        
        
        
    }

    //結果を画面に表示する
    func showResult() {
        
    }

}


