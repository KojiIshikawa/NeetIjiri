//
//  SettingViewController.swift
//  NeeNeeApp
//
//  Created by v2_system on 2016/02/11.
//  Copyright © 2016年 KojiIshikawa. All rights reserved.
//

import Foundation
import AVFoundation


//設定画面です。
class SettingViewController: UIViewController ,AVAudioPlayerDelegate{

    //背景
    private var settingImgView: UIImageView!
    private let settingViewImage = UIImage(named: "02_04_01.png")

    // 設定メニューのオブジェクト
    private var bgmMuteBtn: UIButton!
    private var bgmVolumeSBar: UISlider!
    private var bgmLabel: UILabel!
    private var seMuteBtn: UIButton!
    private var seVolumeSBar: UISlider!
    private var seLabel: UILabel!
    
    
    // view ロード完了時
    override func viewDidLoad() {
        print(NSDate().description, __FUNCTION__, __LINE__)
        super.viewDidLoad()
        
        //背景生成
        settingImgView = UIImageView(frame: self.view.frame)
        settingImgView.image = settingViewImage
        self.view.addSubview(settingImgView)
        
        
        
        // BGMのラベルを生成
        bgmLabel = UILabel()
        bgmLabel.text = "BGM"

        
        // BGMのスライドバーを生成
        bgmVolumeSBar = UISlider()
        bgmVolumeSBar.addTarget(self, action: "slideBgmVolume:", forControlEvents: .TouchUpInside)
        
        
        // BGMのミュートボタンを生成
        bgmMuteBtn = UIButton()
        bgmMuteBtn.setTitle("ミュート",  forState: .Normal)
        bgmMuteBtn.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
        bgmMuteBtn.addTarget(self, action: "tapBgmMuteBtn:", forControlEvents: .TouchUpInside)
        
        
        // SEのラベルを生成
        seLabel = UILabel()
        seLabel.text = "SE"

        
        // SEのスライドバーを生成
        seVolumeSBar = UISlider()
        seVolumeSBar.addTarget(self, action: "slideSeVolume:", forControlEvents: .TouchUpInside)
        
        
        // SEのミュートボタンを生成
        seMuteBtn = UIButton()
        seMuteBtn.setTitle("ミュート",  forState: .Normal)
        seMuteBtn.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
        seMuteBtn.addTarget(self, action: "tapSeMuteBtn:", forControlEvents: .TouchUpInside)
        
        // Viewに追加する.
        self.view.addSubview(bgmLabel)
        self.view.addSubview(bgmVolumeSBar)
        self.view.addSubview(bgmMuteBtn)
        self.view.addSubview(seLabel)
        self.view.addSubview(seVolumeSBar)
        self.view.addSubview(seMuteBtn)
        
        // オブジェクトの制約の設定
        self.objConstraints()
        
        //UserDefaultから値を取得
        let ud = NSUserDefaults.standardUserDefaults()
        let udBGM : Float! = ud.floatForKey("VOL_BGM")
        if udBGM != nil {
            bgmVolumeSBar.value = udBGM
        } else {
            bgmVolumeSBar.value = 0.5 //音量　初期値
        }

        let udSE : Float! = ud.floatForKey("VOL_SE")
        if udSE != nil {
            seVolumeSBar.value = udSE
        } else {
            seVolumeSBar.value = 0.5 //音量　初期値
        }
    }
    
    //メモリ消費が多くなった時に動くイベント
    override func didReceiveMemoryWarning() {
        print(NSDate().description, __FUNCTION__, __LINE__)
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
  
    
    /** 全オブジェクトの制約設定 **/
    func objConstraints() {
        print(NSDate().description, __FUNCTION__, __LINE__)
        
        bgmLabel.translatesAutoresizingMaskIntoConstraints = false
        bgmVolumeSBar.translatesAutoresizingMaskIntoConstraints = false
        bgmMuteBtn.translatesAutoresizingMaskIntoConstraints = false
        seLabel.translatesAutoresizingMaskIntoConstraints = false
        seVolumeSBar.translatesAutoresizingMaskIntoConstraints = false
        seMuteBtn.translatesAutoresizingMaskIntoConstraints = false
        
        // BGMラベルの制約
        self.view.addConstraints([
            
            // x座標
            NSLayoutConstraint(
                item: self.bgmLabel,
                attribute:  NSLayoutAttribute.Left,
                relatedBy: .Equal,
                toItem: self.view,
                attribute:  NSLayoutAttribute.Left,
                multiplier: 1.0,
                constant: 20
            ),
            
            // y座標
            NSLayoutConstraint(
                item: self.bgmLabel,
                attribute: NSLayoutAttribute.Top,
                relatedBy: .Equal,
                toItem: self.view,
                attribute:  NSLayoutAttribute.Top,
                multiplier: 1.0,
                constant: 100
            ),
            
            // 横幅
            NSLayoutConstraint(
                item: self.bgmLabel,
                attribute: .Width,
                relatedBy: .Equal,
                toItem: self.view,
                attribute: .Width,
                multiplier: 1.0 / 6.0,
                constant: 0
            ),
            
            // 縦幅
            NSLayoutConstraint(
                item: self.bgmLabel,
                attribute: .Height,
                relatedBy: .Equal,
                toItem: self.view,
                attribute: .Height,
                multiplier: 1.0 / 24.0,
                constant: 0
            )]
        )
        
        // BGMボリュームバーの制約
        self.view.addConstraints([
            
            // x座標
            NSLayoutConstraint(
                item: self.bgmVolumeSBar,
                attribute:  NSLayoutAttribute.Left,
                relatedBy: .Equal,
                toItem: self.bgmLabel,
                attribute:  NSLayoutAttribute.Right,
                multiplier: 1.0,
                constant: 20
            ),
            
            // y座標
            NSLayoutConstraint(
                item: self.bgmVolumeSBar,
                attribute: NSLayoutAttribute.Top,
                relatedBy: .Equal,
                toItem: self.view,
                attribute:  NSLayoutAttribute.Top,
                multiplier: 1.0,
                constant: 100
            ),
            
            // 横幅
            NSLayoutConstraint(
                item: self.bgmVolumeSBar,
                attribute: .Width,
                relatedBy: .Equal,
                toItem: self.view,
                attribute: .Width,
                multiplier: 1.0 / 3.0,
                constant: 0
            ),
            
            // 縦幅
            NSLayoutConstraint(
                item: self.bgmVolumeSBar,
                attribute: .Height,
                relatedBy: .Equal,
                toItem: self.view,
                attribute: .Height,
                multiplier: 1.0 / 24.0,
                constant: 0
            )]
        )
        
        // BGMミュートボタンの制約
        self.view.addConstraints([
            
            // x座標
            NSLayoutConstraint(
                item: self.bgmMuteBtn,
                attribute:  NSLayoutAttribute.Left,
                relatedBy: .Equal,
                toItem: self.bgmVolumeSBar,
                attribute:  NSLayoutAttribute.Right,
                multiplier: 1.0,
                constant: 20
            ),
            
            // y座標
            NSLayoutConstraint(
                item: self.bgmMuteBtn,
                attribute: NSLayoutAttribute.Top,
                relatedBy: .Equal,
                toItem: self.view,
                attribute:  NSLayoutAttribute.Top,
                multiplier: 1.0,
                constant: 100
            ),
            
            // 横幅
            NSLayoutConstraint(
                item: self.bgmMuteBtn,
                attribute: .Width,
                relatedBy: .Equal,
                toItem: self.view,
                attribute: .Width,
                multiplier: 1.0 / 4.0,
                constant: 0
            ),
            
            // 縦幅
            NSLayoutConstraint(
                item: self.bgmMuteBtn,
                attribute: .Height,
                relatedBy: .Equal,
                toItem: self.view,
                attribute: .Height,
                multiplier: 1.0 / 24.0,
                constant: 0
            )]
        )
        
        // SEラベルの制約
        self.view.addConstraints([
            
            // x座標
            NSLayoutConstraint(
                item: self.seLabel,
                attribute:  NSLayoutAttribute.Left,
                relatedBy: .Equal,
                toItem: self.view,
                attribute:  NSLayoutAttribute.Left,
                multiplier: 1.0,
                constant: 20
            ),
            
            // y座標
            NSLayoutConstraint(
                item: self.seLabel,
                attribute: NSLayoutAttribute.Top,
                relatedBy: .Equal,
                toItem: self.bgmLabel,
                attribute:  NSLayoutAttribute.Bottom,
                multiplier: 1.0,
                constant: 20
            ),
            
            // 横幅
            NSLayoutConstraint(
                item: self.seLabel,
                attribute: .Width,
                relatedBy: .Equal,
                toItem: self.view,
                attribute: .Width,
                multiplier: 1.0 / 6.0,
                constant: 0
            ),
            
            // 縦幅
            NSLayoutConstraint(
                item: self.seLabel,
                attribute: .Height,
                relatedBy: .Equal,
                toItem: self.view,
                attribute: .Height,
                multiplier: 1.0 / 24.0,
                constant: 0
            )]
        )
        
        // SEボリュームバーの制約
        self.view.addConstraints([
            
            // x座標
            NSLayoutConstraint(
                item: self.seVolumeSBar,
                attribute:  NSLayoutAttribute.Left,
                relatedBy: .Equal,
                toItem: self.seLabel,
                attribute:  NSLayoutAttribute.Right,
                multiplier: 1.0,
                constant: 20
            ),
            
            // y座標
            NSLayoutConstraint(
                item: self.seVolumeSBar,
                attribute: NSLayoutAttribute.Top,
                relatedBy: .Equal,
                toItem: self.bgmVolumeSBar,
                attribute:  NSLayoutAttribute.Bottom,
                multiplier: 1.0,
                constant: 20
            ),
            
            // 横幅
            NSLayoutConstraint(
                item: self.seVolumeSBar,
                attribute: .Width,
                relatedBy: .Equal,
                toItem: self.view,
                attribute: .Width,
                multiplier: 1.0 / 3.0,
                constant: 0
            ),
            
            // 縦幅
            NSLayoutConstraint(
                item: self.seVolumeSBar,
                attribute: .Height,
                relatedBy: .Equal,
                toItem: self.view,
                attribute: .Height,
                multiplier: 1.0 / 24.0,
                constant: 0
            )]
        )
        
        // SEミュートボタンの制約
        self.view.addConstraints([
            
            // x座標
            NSLayoutConstraint(
                item: self.seMuteBtn,
                attribute:  NSLayoutAttribute.Left,
                relatedBy: .Equal,
                toItem: self.seVolumeSBar,
                attribute:  NSLayoutAttribute.Right,
                multiplier: 1.0,
                constant: 20
            ),
            
            // y座標
            NSLayoutConstraint(
                item: self.seMuteBtn,
                attribute: NSLayoutAttribute.Top,
                relatedBy: .Equal,
                toItem: self.bgmMuteBtn,
                attribute:  NSLayoutAttribute.Bottom,
                multiplier: 1.0,
                constant: 20
            ),
            
            // 横幅
            NSLayoutConstraint(
                item: self.seMuteBtn,
                attribute: .Width,
                relatedBy: .Equal,
                toItem: self.view,
                attribute: .Width,
                multiplier: 1.0 / 4.0,
                constant: 0
            ),
            
            // 縦幅
            NSLayoutConstraint(
                item: self.seMuteBtn,
                attribute: .Height,
                relatedBy: .Equal,
                toItem: self.view,
                attribute: .Height,
                multiplier: 1.0 / 24.0,
                constant: 0
            )]
        )
    }

    
    
    /** BGMボリューム変更時の処理 **/
    func slideBgmVolume(sender: AnyObject) {
        
        // スライド値をBGM音量にセットする
//        myAudioPlayer.volume = bgmVolumeSBar.value
        
        //NSUserDefaultに値を保存
        let ud = NSUserDefaults.standardUserDefaults()
        ud.setFloat(bgmVolumeSBar.value, forKey: "VOL_BGM")
        ud.synchronize()
        
        Utility.bgmVolumeChange(bgmVolumeSBar.value)
        
    }

    /** BGMミュートボタン押下時の処理 **/
    func tapBgmMuteBtn(sender: AnyObject) {
        print(NSDate().description, __FUNCTION__, __LINE__)

        // SEを再生する.
        Utility.seSoundPlay(Const.mySeYesPath!)

        // ミュート切り替え
        if bgmVolumeSBar.value == 0.0 {
            bgmVolumeSBar.value = 0.5
        } else {
            bgmVolumeSBar.value = 0.0
        }

        //NSUserDefaultに値を保存
        let ud = NSUserDefaults.standardUserDefaults()
        ud.setFloat(bgmVolumeSBar.value, forKey: "VOL_BGM")
        ud.synchronize()
        
        Utility.bgmVolumeChange(bgmVolumeSBar.value)
        
    }
    
    
    /** SEボリューム変更時の処理 **/
    func slideSeVolume(sender: AnyObject) {
        print(NSDate().description, __FUNCTION__, __LINE__)
        
        //NSUserDefaultに値を保存
        let ud = NSUserDefaults.standardUserDefaults()
        ud.setFloat(seVolumeSBar.value, forKey: "VOL_SE")
        ud.synchronize()

        Utility.seVolumeChange(seVolumeSBar.value)

    }

    /** SEミュートボタン押下時の処理 **/
    func tapSeMuteBtn(sender: AnyObject) {
        Utility.seSoundPlay(Const.mySeYesPath!)
        
        if seVolumeSBar.value == 0.0 {
            seVolumeSBar.value = 0.5
        } else {
            seVolumeSBar.value = 0.0
        
        }
    
        //NSUserDefaultに値を保存
        let ud = NSUserDefaults.standardUserDefaults()
        ud.setFloat(seVolumeSBar.value, forKey: "VOL_SE")
        ud.synchronize()
        
        // SEを再生する.
        Utility.seVolumeChange(seVolumeSBar.value)

    }
    
}
