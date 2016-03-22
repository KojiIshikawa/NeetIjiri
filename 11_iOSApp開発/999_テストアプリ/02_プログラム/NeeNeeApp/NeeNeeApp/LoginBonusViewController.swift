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
        print(NSDate().description, __FUNCTION__, __LINE__)
        super.viewDidLoad()

        //背景
        imgViewLogin = UIImageView(frame: self.view.frame)
        imgViewLogin.image = Utility.getUncachedImage(named: "02_07_01.png")
        self.view.addSubview(imgViewLogin)

        
        
        // ログインメッセージを表示
        lblOkan = UILabel(frame: CGRectMake(45,100,self.view.bounds.width-30,160))
        let mes: String = "〇〇くんへ\n\nかあさん腕をふるって\n〇〇くんの大好きな\n\(getOkan())を\n作りました。\n無理しないで頑張ってね！"
        let charaData : [T_CharaBase] = Utility.getCharaBase(Const.CHARACTER1_ID)
        lblOkan.text = mes.stringByReplacingOccurrencesOfString("〇〇",withString: charaData[0].charaName)
        lblOkan.numberOfLines = 0
        self.view.addSubview(lblOkan)
        
        
        //OKボタン
        btnOK = UIButton(frame: CGRectMake(20,60,self.view.bounds.width-30,120))
        btnOK.titleLabel!.text = "OK"
        self.view.addSubview(btnOK)

    }

    
    //メモリ消費が多くなった時に動くイベント
    override func didReceiveMemoryWarning() {
        print(NSDate().description, __FUNCTION__, __LINE__)
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    //****************************************
    // MARK: - DB Access
    //****************************************
    //オカンメッセージの取得
    func getOkan() -> String {
        
        //ランダムで取得
        print(NSDate().description, __FUNCTION__, __LINE__)
        
        let okanList :[M_Okan] = M_Okan.MR_findAll() as! [M_Okan];
        let randInt = arc4random_uniform(UInt32(okanList.count));
        print(okanList.count)
        
        return okanList[Int(randInt)].okanText
        
    }
    
}