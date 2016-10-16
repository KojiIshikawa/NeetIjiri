//
//  LoginBonusViewController.swift
//  NeeNeeApp
//
//  Created by Boil Project on 2016/02/12.
//  Copyright © 2016年 Boil Project. All rights reserved.
//

import Foundation



class LoginBonusViewController: UIViewController {
    
    // 背景
    fileprivate var imgViewLogin: UIImageView!

    //画面オブジェクト
    fileprivate var lblOkan: UILabel! //オカンラベル
    fileprivate var btnOK: UIButton! //OKボタン
    
    // view アンロード開始時
    override func viewWillDisappear(_ animated: Bool) {
        
        // SEを再生する.
        Utility.seSoundPlay(Const.SE_NO_PATH)
    }
    
    // view ロード完了時
    override func viewDidLoad() {
        print(Date().description, NSStringFromClass(self.classForCoder), #function, #line)
        super.viewDidLoad()

        //メッセージ
        var mes1: String = ""
        var mes2: String = ""
        var mes3: String = ""
        
        //背景
        imgViewLogin = UIImageView(frame: self.view.frame)
        imgViewLogin.image = Utility.getUncachedImage(named: "02_07_01.png")
        
        //メッセージラベル
        lblOkan = UILabel()
        lblOkan.numberOfLines = 0
        self.lblOkan.font = UIFont.systemFont(ofSize: Utility.getMojiSize(Const.SIZEKBN_LARGE))
        
        //キャラクター基本情報マスタを取得する.
        let charaData : [T_CharaBase] = Utility.getCharaBase(Const.CHARACTER1_ID)
        var tempItemId:Int = 1
        
        if charaData.count == 0 {
            mes1 = "キャラクターマスタが\n取得できませんでした。"
        } else {

            //アイテムドロップマスタを取得する.
            //所持アイテムをセットして、妥当なアイテムを一つドロップさせる.
            let getItemList : [T_GetItem] = Utility.getTGetItem(Const.CHARACTER1_ID)
            
            //取得済アイテムが存在する場合はランダムで取得する.
            if (getItemList.count > 0) {
                tempItemId = Int(getItemList[Int(arc4random_uniform(UInt32(getItemList.count)))].itemID)
            }
            
            //アイテムをドロップさせる.
            let mDropItem:[M_DropItem] = Utility.getDropItem(tempItemId,rankKbn: "B",loginUseFlg: true)

            //エラーがなければログインメッセージを表示
            mes1 = "〇〇くんへ\n\nかあさんうでをふるって\n〇〇くんのだいすきな\n\(getOkan())\nを、つくりました。"
            mes1 = mes1.replacingOccurrences(of: "〇〇",with: charaData[0].charaName)
            mes3 = "\n\nむりしないでがんばってね！"
            
            //ドロップアイテムが取得できた場合は文言を追加する.
            if (mDropItem.count > 0) {
                mes2 = "\n\nそれと、「" + Utility.getMItem(Int(mDropItem[0].dropItemID))[0].itemName + "」\nを、おいておくので\nたしにしてください。"
            }
        }
        
        //ラベルにセットする.
        lblOkan.text = mes1 + mes2 + mes3
        
        // オブジェクトを追加する.
        self.view.addSubview(imgViewLogin)
        self.view.addSubview(lblOkan)
        
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
    //オカンメッセージの取得
    func getOkan() -> String {
        
        //ランダムで取得
        print(Date().description, NSStringFromClass(self.classForCoder), #function, #line)
        
        let okanList :[M_Okan] = M_Okan.mr_findAll() as! [M_Okan];
        let randInt = arc4random_uniform(UInt32(okanList.count));
        print(okanList.count)
        
        return okanList[Int(randInt)].okanText
        
    }
    
    /** 全オブジェクトの制約設定 **/
    func objConstraints() {
        print(Date().description, NSStringFromClass(self.classForCoder), #function, #line)
        
        imgViewLogin.translatesAutoresizingMaskIntoConstraints = false
        lblOkan.translatesAutoresizingMaskIntoConstraints = false
        
        // 壁紙の制約
        self.view.addConstraints([
            
            // x座標
            NSLayoutConstraint(
                item: self.imgViewLogin,
                attribute:  NSLayoutAttribute.right,
                relatedBy: .equal,
                toItem: self.view,
                attribute:  NSLayoutAttribute.right,
                multiplier: 1.0,
                constant: 0
            ),
            
            // y座標
            NSLayoutConstraint(
                item: self.imgViewLogin,
                attribute: NSLayoutAttribute.bottom,
                relatedBy: .equal,
                toItem: self.view,
                attribute:  NSLayoutAttribute.bottom,
                multiplier: 1.0,
                constant: 0
            ),
            
            // 横幅
            NSLayoutConstraint(
                item: self.imgViewLogin,
                attribute: NSLayoutAttribute.width,
                relatedBy: .equal,
                toItem: self.view,
                attribute: NSLayoutAttribute.width,
                multiplier: 1.0,
                constant: 0
            ),
            
            // 縦幅
            NSLayoutConstraint(
                item: self.imgViewLogin,
                attribute: NSLayoutAttribute.height,
                relatedBy: .equal,
                toItem: self.view,
                attribute: NSLayoutAttribute.height,
                multiplier: 1.0,
                constant: 0
            )]
        )
        
        // オカンメッセージラベルの制約
        self.view.addConstraints([
            
            // x座標
            NSLayoutConstraint(
                item: self.lblOkan,
                attribute:  NSLayoutAttribute.left,
                relatedBy: .equal,
                toItem: self.view,
                attribute:  NSLayoutAttribute.right,
                multiplier: 0.1 / 1.0,
                constant: 0
            ),
            
            // y座標
            NSLayoutConstraint(
                item: self.lblOkan,
                attribute: NSLayoutAttribute.top,
                relatedBy: .equal,
                toItem: self.view,
                attribute: NSLayoutAttribute.bottom,
                multiplier: 0.2 / 1.0,
                constant: 0
            )]
    )
    }
}
