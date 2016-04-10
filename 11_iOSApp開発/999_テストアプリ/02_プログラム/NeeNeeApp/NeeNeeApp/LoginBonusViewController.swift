//
//  LoginBonusViewController.swift
//  NeeNeeApp
//
//  Created by v2_system on 2016/02/12.
//  Copyright © 2016年 KojiIshikawa. All rights reserved.
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

        //背景
        imgViewLogin = UIImageView(frame: self.view.frame)
        imgViewLogin.image = Utility.getUncachedImage(named: "02_07_01.png")
        self.view.addSubview(imgViewLogin)
        
        // ログインメッセージを表示
        lblOkan = UILabel(frame: CGRectMake(45,100,self.view.bounds.width-30,160))
        let mes: String = "〇〇くんへ\n\nかあさん腕をふるって\n〇〇くんの大好きな\n\(getOkan())を\n作りました。\n無理しないで頑張ってね！"
        let charaData : [T_CharaBase] = Utility.getCharaBase(Const.CHARACTER1_ID)
        if charaData.count == 0 {
            print("キャラクターデータなし")
        }
        lblOkan.text = mes.stringByReplacingOccurrencesOfString("〇〇",withString: charaData[0].charaName)
        lblOkan.numberOfLines = 0
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
                attribute: .Width,
                relatedBy: .Equal,
                toItem: self.view,
                attribute: .Width,
                multiplier: 1.0,
                constant: 0
            ),
            
            // 縦幅
            NSLayoutConstraint(
                item: self.imgViewLogin,
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