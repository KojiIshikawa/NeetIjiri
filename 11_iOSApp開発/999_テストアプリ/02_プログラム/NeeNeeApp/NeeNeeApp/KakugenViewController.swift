//
//  KakugenViewController.swift
//  NeeNeeApp
//
//  Created by Boil Project on 2016/02/12.
//  Copyright © 2016年 Boil Project. All rights reserved.
//

import Foundation
fileprivate func < <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l < r
  case (nil, _?):
    return true
  default:
    return false
  }
}

fileprivate func > <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l > r
  default:
    return rhs < lhs
  }
}


class KakugenViewController: UIViewController {
    
    //背景
    fileprivate var imgViewKakugen: UIImageView!

    //画面オブジェクト
    fileprivate var lblKakugen: UILabel! //格言ラベル
    
    // view アンロード開始時
    override func viewWillDisappear(_ animated: Bool) {
        
        // SEを再生する.
        Utility.seSoundPlay(Const.SE_NO_PATH)
    }
    
    // view ロード完了時
    override func viewDidLoad() {
        print(Date().description, NSStringFromClass(self.classForCoder), #function, #line)
        super.viewDidLoad()

        //背景設定
        imgViewKakugen = UIImageView(frame: self.view.frame)
        imgViewKakugen.image = Utility.getUncachedImage(named: "02_09_01.png")
        self.view.addSubview(imgViewKakugen)
        
        // 格言を表示
        lblKakugen = UILabel()
        lblKakugen.text = getKakugen()
        lblKakugen.numberOfLines = 0
        self.lblKakugen.font = UIFont.systemFont(ofSize: Utility.getMojiSize(Const.SIZEKBN_LARGE))
        self.view.addSubview(lblKakugen)
        
        // 制約を設定する.
        objConstraints()
        
    }
    
    //メモリ消費が多くなった時に動くイベント
    override func didReceiveMemoryWarning() {
        print(Date().description, NSStringFromClass(self.classForCoder), #function, #line)
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    //****************************************
    // MARK: - DB Access
    //****************************************
    
    //格言の取得
    func getKakugen() -> String {
        print(Date().description, NSStringFromClass(self.classForCoder), #function, #line)
        
        //セッション情報.
        let ud = UserDefaults.standard
        let udDateKkgnLst: Int! = ud.integer(forKey: "KAKUGEN_LAST_DATE")
        let udKakugenId: Int! = ud.integer(forKey: "KAKUGEN_ID")
        let udKakugenLogString: String! = ud.string(forKey: "KAKUGEN_LOG_STRING")
        
        //NSCalendarインスタンス
        let cal = Calendar(identifier: Calendar.Identifier.gregorian)
        let now = Date()
        let year = (cal as NSCalendar).component(NSCalendar.Unit.year , from: now) * 10000
        let Month = (cal as NSCalendar).component(NSCalendar.Unit.month , from: now) * 100
        let day = (cal as NSCalendar).component(NSCalendar.Unit.day , from: now)
        var kakugenList :[M_Kakugen]
        var randInt: UInt32 = 0
        var updFlg = false
        
        // 格言履歴表示の場合
        if (udKakugenLogString > "") {
            
            //NSUserDefaultに格言表示日付をセット
            let ud = UserDefaults.standard
            
            //セッションをクリア
            ud.setValue("", forKey: "KAKUGEN_LOG_STRING")
            ud.synchronize()
            
            // セッションの格言履歴を返却して終了
            return Utility.insertReturn(udKakugenLogString,interval: 16)
        }
            
        //前回表示時と同じ年月日の場合
        if udDateKkgnLst == year + Month + day {
            
            //格言をセッションから取得
            kakugenList = M_Kakugen.mr_find(byAttribute: "kakugenID", withValue:udKakugenId , andOrderBy: "kakugenID", ascending: true) as! [M_Kakugen];
            updFlg = false
            
            
        } else {

            //格言をランダムで取得
            kakugenList = M_Kakugen.mr_findAll() as! [M_Kakugen];
            randInt = arc4random_uniform(UInt32(kakugenList.count));
            updFlg = true
            
        }
        
        // 取得済格言テーブルで存在チェックを行い、存在しない場合のみセットする.
        let listT_RefKakugen :[T_RefKakugen] = T_RefKakugen.mr_find(byAttribute: "charaID", withValue: Const.CHARACTER1_ID, andOrderBy: "kakugenID", ascending: true) as! [T_RefKakugen];
        
        // 件数分繰り返す
        for refKakugen in listT_RefKakugen {
            
            // 実行中または未実行のデータをセットする.
            if refKakugen.kakugenID == kakugenList[Int(randInt)].kakugenID {
                
                // データ更新不要
                updFlg = false
                
                // 繰り返しを終了
                continue

            }
        }

        // 未取得の格言は取得済に更新する.
        if updFlg {

            //取得済み格言の更新
            let insertItem = T_RefKakugen.mr_createEntity()! as T_RefKakugen
            insertItem.charaID = Const.CHARACTER1_ID as NSNumber!
            insertItem.kakugenID = kakugenList[Int(randInt)].kakugenID
            insertItem.managedObjectContext!.mr_saveToPersistentStoreAndWait()
            
        }
        
        //取得した格言コードをセッションに格納
        ud.set(Int(kakugenList[Int(randInt)].kakugenID), forKey: "KAKUGEN_ID")
        ud.synchronize()

        // 格言の返却
        return Utility.insertReturn(kakugenList[Int(randInt)].kakugenText,interval: 16)
    }
    
    /** 全オブジェクトの制約設定 **/
    func objConstraints() {
        print(Date().description, NSStringFromClass(self.classForCoder), #function, #line)
        
        imgViewKakugen.translatesAutoresizingMaskIntoConstraints = false
        lblKakugen.translatesAutoresizingMaskIntoConstraints = false
        
        // 壁紙の制約
        self.view.addConstraints([
            
            // x座標
            NSLayoutConstraint(
                item: self.imgViewKakugen,
                attribute:  NSLayoutAttribute.right,
                relatedBy: .equal,
                toItem: self.view,
                attribute:  NSLayoutAttribute.right,
                multiplier: 1.0,
                constant: 0
            ),
            
            // y座標
            NSLayoutConstraint(
                item: self.imgViewKakugen,
                attribute: NSLayoutAttribute.bottom,
                relatedBy: .equal,
                toItem: self.view,
                attribute:  NSLayoutAttribute.bottom,
                multiplier: 1.0,
                constant: 0
            ),
            
            // 横幅
            NSLayoutConstraint(
                item: self.imgViewKakugen,
                attribute: .width,
                relatedBy: .equal,
                toItem: self.view,
                attribute: .width,
                multiplier: 1.0,
                constant: 0
            ),
            
            // 縦幅
            NSLayoutConstraint(
                item: self.imgViewKakugen,
                attribute: .height,
                relatedBy: .equal,
                toItem: self.view,
                attribute: .height,
                multiplier: 1.0,
                constant: 0
            )]
        )
        
        // 格言ラベルの制約
        self.view.addConstraints([
            
            // x座標
            NSLayoutConstraint(
                item: self.lblKakugen,
                attribute:  NSLayoutAttribute.left,
                relatedBy: .equal,
                toItem: self.view,
                attribute:  NSLayoutAttribute.right,
                multiplier: 1.0 / 20.0,
                constant: 0
            ),
            
            // y座標
            NSLayoutConstraint(
                item: self.lblKakugen,
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
