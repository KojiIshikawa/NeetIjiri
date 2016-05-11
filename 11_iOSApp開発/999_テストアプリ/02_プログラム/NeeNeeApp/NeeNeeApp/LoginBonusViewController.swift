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
    private var imgViewLogin: UIImageView!

    //画面オブジェクト
    private var lblOkan: UILabel! //オカンラベル
    private var btnOK: UIButton! //OKボタン
    
    // view ロード完了時
    override func viewDidLoad() {
        print(NSDate().description, NSStringFromClass(self.classForCoder), __FUNCTION__, __LINE__)
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
            mes1 = "〇〇くんへ\n\nかあさん腕をふるって\n〇〇くんの大好きな\n\(getOkan())を\n作りました。"
            mes1 = mes1.stringByReplacingOccurrencesOfString("〇〇",withString: charaData[0].charaName)
            mes3 = "\n\n無理しないで頑張ってね！"
            
            //ドロップアイテムが取得できた場合は文言を追加する.
            if (mDropItem.count > 0) {
                mes2 = "\nそれと、「" + Utility.getMItem(Int(mDropItem[0].dropItemID))[0].itemName + "」を\nおいておくので\n足しにしてください。"
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
        print(NSDate().description, NSStringFromClass(self.classForCoder), __FUNCTION__, __LINE__)
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    //****************************************
    // MARK: - DB Access
    //****************************************
    //オカンメッセージの取得
    func getOkan() -> String {
        
        //ランダムで取得
        print(NSDate().description, NSStringFromClass(self.classForCoder), __FUNCTION__, __LINE__)
        
        let okanList :[M_Okan] = M_Okan.MR_findAll() as! [M_Okan];
        let randInt = arc4random_uniform(UInt32(okanList.count));
        print(okanList.count)
        
        return okanList[Int(randInt)].okanText
        
    }
    
    /** 全オブジェクトの制約設定 **/
    func objConstraints() {
        print(NSDate().description, NSStringFromClass(self.classForCoder), __FUNCTION__, __LINE__)
        
        imgViewLogin.translatesAutoresizingMaskIntoConstraints = false
        lblOkan.translatesAutoresizingMaskIntoConstraints = false
        
        // 壁紙の制約
        self.view.addConstraints([
            
            // x座標
            NSLayoutConstraint(
                item: self.imgViewLogin,
                attribute:  NSLayoutAttribute.Right,
                relatedBy: .Equal,
                toItem: self.view,
                attribute:  NSLayoutAttribute.Right,
                multiplier: 1.0,
                constant: 0
            ),
            
            // y座標
            NSLayoutConstraint(
                item: self.imgViewLogin,
                attribute: NSLayoutAttribute.Bottom,
                relatedBy: .Equal,
                toItem: self.view,
                attribute:  NSLayoutAttribute.Bottom,
                multiplier: 1.0,
                constant: 0
            ),
            
            // 横幅
            NSLayoutConstraint(
                item: self.imgViewLogin,
                attribute: NSLayoutAttribute.Width,
                relatedBy: .Equal,
                toItem: self.view,
                attribute: NSLayoutAttribute.Width,
                multiplier: 1.0,
                constant: 0
            ),
            
            // 縦幅
            NSLayoutConstraint(
                item: self.imgViewLogin,
                attribute: NSLayoutAttribute.Height,
                relatedBy: .Equal,
                toItem: self.view,
                attribute: NSLayoutAttribute.Height,
                multiplier: 1.0,
                constant: 0
            )]
        )
        
        // オカンメッセージラベルの制約
        self.view.addConstraints([
            
            // x座標
            NSLayoutConstraint(
                item: self.lblOkan,
                attribute:  NSLayoutAttribute.Left,
                relatedBy: .Equal,
                toItem: self.view,
                attribute:  NSLayoutAttribute.Right,
                multiplier: 0.1 / 1.0,
                constant: 0
            ),
            
            // y座標
            NSLayoutConstraint(
                item: self.lblOkan,
                attribute: NSLayoutAttribute.Top,
                relatedBy: .Equal,
                toItem: self.view,
                attribute: NSLayoutAttribute.Bottom,
                multiplier: 0.2 / 1.0,
                constant: 0
            )]
    )
    }
}