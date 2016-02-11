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
    
    

    // view ロード完了時
    override func viewDidLoad() {
        print(NSDate().description, __FUNCTION__, __LINE__)
        super.viewDidLoad()
        
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


