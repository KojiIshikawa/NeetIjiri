//
//  LoginBonusViewController.swift
//  NeeNeeApp
//
//  Created by v2_system on 2016/02/12.
//  Copyright © 2016年 KojiIshikawa. All rights reserved.
//

import Foundation



class LoginBonusViewController: UIViewController {
    private var bgmMuteBtn: UIButton!
    private var bgmVolumeSBar: UISlider!
    private var bgmLabel: UILabel!
    private var seMuteBtn: UIButton!
    private var seVolumeSBar: UISlider!
    private var seLabel: UILabel!
    
    
    private var loginImgView: UIImageView!
    //TODO:ファイル名仮
    private let loginViewImage = UIImage(named: "k_Login.png")
    
    // view ロード完了時
    override func viewDidLoad() {
        print(NSDate().description, __FUNCTION__, __LINE__)
        super.viewDidLoad()
        //ポップ生成
        loginImgView = UIImageView(frame: self.view.frame)
        loginImgView.image = loginViewImage
        self.view.addSubview(loginImgView)
        
//        // ポップ上に表示するオブジェクトを生成する.
//        // BGMのラベルを生成
//        bgmLabel = UILabel(frame: CGRectMake(20,60,100,120))
//        bgmLabel.text = "BGM"
        
    }
    
    //メモリ消費が多くなった時に動くイベント
    override func didReceiveMemoryWarning() {
        print(NSDate().description, __FUNCTION__, __LINE__)
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}