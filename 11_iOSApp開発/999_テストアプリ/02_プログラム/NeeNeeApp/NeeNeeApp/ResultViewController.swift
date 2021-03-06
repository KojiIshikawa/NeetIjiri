//
//  ResultViewController.swift
//  NeeNeeApp
//
//  Created by Boil Project on 2016/02/11.
//  Copyright © 2016年 Boil Project. All rights reserved.
//

import Foundation


//行動結果の表示画面です。
//ログイン時、またはタイマーイベントで呼び出されます。
class ResultViewController: UIViewController {
    
    // 背景
    fileprivate var imgResultView: UIImageView!

    //画面オブジェクト
    fileprivate var lblResult: UILabel! //ラベル
    fileprivate var btnOK: UIButton! //OKボタン
    
    // view アンロード開始時
    override func viewWillDisappear(_ animated: Bool) {
        
        // SEを再生する.
        Utility.seSoundPlay(Const.SE_NO_PATH)
    }
    
    // view ロード完了時
    override func viewDidLoad() {
        print(Date().description, NSStringFromClass(self.classForCoder), #function,#line)
        
        super.viewDidLoad()
        
        //背景
        imgResultView = UIImageView(frame: self.view.frame)
        imgResultView.image = Utility.getUncachedImage(named: "02_08_01.png")
        self.view.addSubview(imgResultView)
        
        //メッセージを表示.
        lblResult = UILabel()
        lblResult.numberOfLines = 0
        lblResult.text = self.getActionResult()
        self.lblResult.font = UIFont.systemFont(ofSize: Utility.getMojiSize(Const.SIZEKBN_LARGE))
        
        self.view.addSubview(lblResult)
        
        //全オブジェクトの制約設定.
        self.objConstraints()
    }
    
    
    //メモリ消費が多くなった時に動くイベント
    override func didReceiveMemoryWarning() {
        print(Date().description, NSStringFromClass(self.classForCoder), #function,#line)
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    //行動結果を計算する
    //結果をテーブルへ反映する
    func getActionResult() -> String {
        print(Date().description, NSStringFromClass(self.classForCoder), #function,#line)
        
        //返却データ
        var strResult = ""
        
        //未完了の行動済行動履歴を取得
        let tActionR = Utility.getFinishedTActionResult(Const.CHARACTER1_ID)
        
        //未処理の行動履歴件数確認、０件なら処理終了
        if (tActionR.count == 0) {
            return "行動済の行動履歴が\nありません。"
        }
        
        //行動結果マスタ取得
        let resFilter: NSPredicate = NSPredicate(format: "itemID = %@", tActionR[0].itemID)
        let mActionR :[M_ActionResult] = M_ActionResult.mr_findAllSorted(by: "resultID", ascending: true, with: resFilter) as! [M_ActionResult];
        
        //1~100の値をランダムで取得
        let randInt = Int32(arc4random_uniform(UInt32(100))) + 1;
        var minPer : Int32 = 1
        var maxPer : Int32 = 0
        var resultNo = 0
        
        //行動結果のパターン分ループ処理
        for i in 0 ..< mActionR.count {
            
            maxPer = minPer + mActionR[i].resPer.int32Value - 1
            
            if minPer <= randInt && randInt <= maxPer {
                resultNo = i
                break
            }
            
            minPer = minPer + mActionR[i].resPer.int32Value
        }

        //使用したアイテムを取得
        if mActionR.count > 0 {
            
            //ラベルへの文言設定
            let usedItem = Utility.getMItem(Int(mActionR[resultNo].itemID == nil ? 1 : mActionR[resultNo].itemID))
            strResult = usedItem[0].itemName + " " + Utility.getRankName(mActionR[resultNo].rankKBN) + "\n\n"
            strResult += Utility.insertReturn(mActionR[resultNo].message,interval: 16) + "\n\n"
            strResult += "【取得ひま一覧】" + "\n"
            
            //ドロップアイテムを算出する.
            let mDropItem = Utility.getDropItem(Int(tActionR[0].itemID),rankKbn: mActionR[resultNo].rankKBN,loginUseFlg: false)

            //件数確認
            if (mDropItem.count == 0) {
                strResult += "ひまを取得できなかった・・・"
            }
            
            for dropItem in mDropItem {

                //取得アイテムをラベルへ設定
                let mItem = Utility.getMItem(Int(dropItem.dropItemID))
                strResult += mItem[0].itemName + "\n"
            }
            
            //完了フラグを”処理済”に更新する.
            let updateActionR :T_ActionResult = tActionR[0]
            updateActionR.finishFlg = 1
            updateActionR.managedObjectContext!.mr_saveToPersistentStoreAndWait()
            
        } else {
            
            // マスタ不整合の場合
            strResult = "行動結果マスタが\n取得できませんでした。"
        }
        
        return strResult
    }

    //結果を画面に表示する
    func showResult() {
        print(Date().description, NSStringFromClass(self.classForCoder), #function,#line)
    }
    
    /** 全オブジェクトの制約設定 **/
    func objConstraints() {
        print(Date().description, NSStringFromClass(self.classForCoder), #function,#line)
        
        imgResultView.translatesAutoresizingMaskIntoConstraints = false
        lblResult.translatesAutoresizingMaskIntoConstraints = false
        
        // 壁紙の制約
        self.view.addConstraints([
            
            // x座標
            NSLayoutConstraint(
                item: self.imgResultView,
                attribute:  NSLayoutAttribute.right,
                relatedBy: .equal,
                toItem: self.view,
                attribute:  NSLayoutAttribute.right,
                multiplier: 1.0,
                constant: 0
            ),
            
            // y座標
            NSLayoutConstraint(
                item: self.imgResultView,
                attribute: NSLayoutAttribute.bottom,
                relatedBy: .equal,
                toItem: self.view,
                attribute:  NSLayoutAttribute.bottom,
                multiplier: 1.0,
                constant: 0
            ),
            
            // 横幅
            NSLayoutConstraint(
                item: self.imgResultView,
                attribute: .width,
                relatedBy: .equal,
                toItem: self.view,
                attribute: .width,
                multiplier: 1.0,
                constant: 0
            ),
            
            // 縦幅
            NSLayoutConstraint(
                item: self.imgResultView,
                attribute: .height,
                relatedBy: .equal,
                toItem: self.view,
                attribute: .height,
                multiplier: 1.0,
                constant: 0
            )]
        )
        
        // 行動結果ラベルの制約
        self.view.addConstraints([
            
            // x座標
            NSLayoutConstraint(
                item: self.lblResult,
                attribute:  NSLayoutAttribute.left,
                relatedBy: .equal,
                toItem: self.view,
                attribute:  NSLayoutAttribute.right,
                multiplier: 1.0 / 9.0,
                constant: 0
            ),
            
            // y座標
            NSLayoutConstraint(
                item: self.lblResult,
                attribute: NSLayoutAttribute.top,
                relatedBy: .equal,
                toItem: self.view,
                attribute: NSLayoutAttribute.bottom,
                multiplier: 1.0 / 6.0,
                constant: 0
            )]
        )

    }
}


