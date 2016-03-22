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
    private var lblOkan: UILabel! //オカンラベル
    private var btnOK: UIButton! //OKボタン

    
    
    // view ロード完了時
    override func viewDidLoad() {
        print(NSDate().description, __FUNCTION__, __LINE__)
        super.viewDidLoad()
        
        //背景
        imgResultView = UIImageView(frame: self.view.frame)
        imgResultView.image = Utility.getUncachedImage(named: "02_08_01.png")
        self.view.addSubview(imgResultView)
        
        
        
//        // ログインメッセージを表示
//        lblOkan = UILabel(frame: CGRectMake(45,100,self.view.bounds.width-30,160))
//        let mes: String = "〇〇くんへ\n\nかあさん腕をふるって\n〇〇くんの大好きな\n\(getOkan())を\n作りました。\n無理しないで頑張ってね！"
//        let charaData : [T_CharaBase] = Utility.getCharaBase(Const.CHARACTER1_ID)
//        lblOkan.text = mes.stringByReplacingOccurrencesOfString("〇〇",withString: charaData[0].charaName)
//        lblOkan.numberOfLines = 0
//        self.view.addSubview(lblOkan)
//        
//        
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
        
    }

    //結果を画面に表示する
    func showResult() {
        
    }

}


