//
//  KakugenViewController.swift
//  NeeNeeApp
//
//  Created by v2_system on 2016/02/12.
//  Copyright © 2016年 KojiIshikawa. All rights reserved.
//

import Foundation

class KakugenViewController: UIViewController {
    
    //背景
    private var imgViewKakugen: UIImageView!

    //画面オブジェクト
    private var lblKakugen: UILabel! //格言ラベル
    private var btnOK: UIButton! //OKボタン

    
    // view ロード完了時
    override func viewDidLoad() {
        print(NSDate().description, __FUNCTION__, __LINE__)
        super.viewDidLoad()

        //背景設定
        imgViewKakugen = UIImageView(frame: self.view.frame)
        imgViewKakugen.image = Utility.getUncachedImage(named: "k_Kakugen.png")
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
    
    //格言の取得
    func getKakugen() -> String {

        //格言をランダムで取得
        let kakugenList :[M_Kakugen] = M_Kakugen.MR_findAll() as! [M_Kakugen];
        let randInt = arc4random_uniform(UInt32(kakugenList.count));
        print(kakugenList.count)
        return kakugenList[Int(randInt)].kakugenText
        
        
        
        //取得済み格言の更新
        
    
        //格言の改行設定
    }
    
}
