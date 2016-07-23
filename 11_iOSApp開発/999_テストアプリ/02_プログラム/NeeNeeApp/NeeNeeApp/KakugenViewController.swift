//
//  KakugenViewController.swift
//  NeeNeeApp
//
//  Created by Boil Project on 2016/02/12.
//  Copyright © 2016年 Boil Project. All rights reserved.
//

import Foundation

class KakugenViewController: UIViewController {
    
    //背景
    private var imgViewKakugen: UIImageView!

    //画面オブジェクト
    private var lblKakugen: UILabel! //格言ラベル
    private var btnOK: UIButton! //OKボタン
    
    // view アンロード開始時
    override func viewWillDisappear(animated: Bool) {
        
        // SEを再生する.
        Utility.seSoundPlay(Const.SE_NO_PATH)
    }
    
    // view ロード完了時
    override func viewDidLoad() {
        print(NSDate().description, NSStringFromClass(self.classForCoder), #function, #line)
        super.viewDidLoad()

        //背景設定
        imgViewKakugen = UIImageView(frame: self.view.frame)
        imgViewKakugen.image = Utility.getUncachedImage(named: "02_09_01.png")
        self.view.addSubview(imgViewKakugen)
        
        // 格言を表示
        lblKakugen = UILabel(frame: CGRectMake(22,60,self.view.bounds.width-50,120))
        lblKakugen.text = getKakugen()
        lblKakugen.numberOfLines = 0
        self.view.addSubview(lblKakugen)
        
        //OKボタン
        btnOK = UIButton(frame: CGRectMake(20,60,self.view.bounds.width-30,120))
        btnOK.titleLabel!.text = "OK"
        self.view.addSubview(btnOK)
        
        // 制約を設定する.
        objConstraints()
        
    }
    
    //メモリ消費が多くなった時に動くイベント
    override func didReceiveMemoryWarning() {
        print(NSDate().description, NSStringFromClass(self.classForCoder), #function, #line)
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    //****************************************
    // MARK: - DB Access
    //****************************************
    
    //格言の取得
    func getKakugen() -> String {
        print(NSDate().description, NSStringFromClass(self.classForCoder), #function, #line)
        
        //セッション情報.
        let ud = NSUserDefaults.standardUserDefaults()
        let udDateKkgnLst: Int! = ud.integerForKey("KAKUGEN_LAST_DATE")
        let udKakugenId: Int! = ud.integerForKey("KAKUGEN_ID")
        let udKakugenLogString: String! = ud.stringForKey("KAKUGEN_LOG_STRING")
        
        //NSCalendarインスタンス
        let cal = NSCalendar(identifier: NSCalendarIdentifierGregorian)!
        let now = NSDate()
        let year = cal.component(NSCalendarUnit.Year , fromDate: now) * 10000
        let Month = cal.component(NSCalendarUnit.Month , fromDate: now) * 100
        let day = cal.component(NSCalendarUnit.Day , fromDate: now)
        var kakugenList :[M_Kakugen]
        var randInt: UInt32 = 0
        var updFlg = false
        
        // 格言履歴表示の場合
        if (udKakugenLogString > "") {
            
            //NSUserDefaultに格言表示日付をセット
            let ud = NSUserDefaults.standardUserDefaults()
            
            //セッションをクリア
            ud.setValue("", forKey: "KAKUGEN_LOG_STRING")
            ud.synchronize()
            
            // セッションの格言履歴を返却して終了
            return Utility.insertReturn(udKakugenLogString,interval: 16)
        }
            
        //前回表示時と同じ年月日の場合
        if udDateKkgnLst == year + Month + day {
            
            //格言をセッションから取得
            kakugenList = M_Kakugen.MR_findByAttribute("kakugenID", withValue:udKakugenId , andOrderBy: "kakugenID", ascending: true) as! [M_Kakugen];
            updFlg = false
            
            
        } else {

            //格言をランダムで取得
            kakugenList = M_Kakugen.MR_findAll() as! [M_Kakugen];
            randInt = arc4random_uniform(UInt32(kakugenList.count));
            updFlg = true
            
        }
        
        // 取得済格言テーブルで存在チェックを行い、存在しない場合のみセットする.
        let listT_RefKakugen :[T_RefKakugen] = T_RefKakugen.MR_findByAttribute("charaID", withValue: Const.CHARACTER1_ID, andOrderBy: "kakugenID", ascending: true) as! [T_RefKakugen];
        
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
            let insertItem = T_RefKakugen.MR_createEntity()! as T_RefKakugen
            insertItem.charaID = Const.CHARACTER1_ID
            insertItem.kakugenID = kakugenList[Int(randInt)].kakugenID
            insertItem.managedObjectContext!.MR_saveToPersistentStoreAndWait()
            
        }
        
        //取得した格言コードをセッションに格納
        ud.setInteger(Int(kakugenList[Int(randInt)].kakugenID), forKey: "KAKUGEN_ID")
        ud.synchronize()

        // 格言の返却
        return Utility.insertReturn(kakugenList[Int(randInt)].kakugenText,interval: 16)
    }
    
    /** 全オブジェクトの制約設定 **/
    func objConstraints() {
        print(NSDate().description, NSStringFromClass(self.classForCoder), #function, #line)
        
        imgViewKakugen.translatesAutoresizingMaskIntoConstraints = false
        lblKakugen.translatesAutoresizingMaskIntoConstraints = false
        
        // 壁紙の制約
        self.view.addConstraints([
            
            // x座標
            NSLayoutConstraint(
                item: self.imgViewKakugen,
                attribute:  NSLayoutAttribute.Right,
                relatedBy: .Equal,
                toItem: self.view,
                attribute:  NSLayoutAttribute.Right,
                multiplier: 1.0,
                constant: 0
            ),
            
            // y座標
            NSLayoutConstraint(
                item: self.imgViewKakugen,
                attribute: NSLayoutAttribute.Bottom,
                relatedBy: .Equal,
                toItem: self.view,
                attribute:  NSLayoutAttribute.Bottom,
                multiplier: 1.0,
                constant: 0
            ),
            
            // 横幅
            NSLayoutConstraint(
                item: self.imgViewKakugen,
                attribute: .Width,
                relatedBy: .Equal,
                toItem: self.view,
                attribute: .Width,
                multiplier: 1.0,
                constant: 0
            ),
            
            // 縦幅
            NSLayoutConstraint(
                item: self.imgViewKakugen,
                attribute: .Height,
                relatedBy: .Equal,
                toItem: self.view,
                attribute: .Height,
                multiplier: 1.0,
                constant: 0
            )]
        )
        
        // 格言ラベルの制約
        self.view.addConstraints([
            
            // x座標
            NSLayoutConstraint(
                item: self.lblKakugen,
                attribute:  NSLayoutAttribute.Left,
                relatedBy: .Equal,
                toItem: self.view,
                attribute:  NSLayoutAttribute.Right,
                multiplier: 1.0 / 20.0,
                constant: 0
            ),
            
            // y座標
            NSLayoutConstraint(
                item: self.lblKakugen,
                attribute: NSLayoutAttribute.Top,
                relatedBy: .Equal,
                toItem: self.view,
                attribute: NSLayoutAttribute.Bottom,
                multiplier: 1.0 / 6.0,
                constant: 0
            )]
        )
    }
}
