//
//  SettingViewController.swift
//  NeeNeeApp
//
//  Created by Boil Project on 2016/02/11.
//  Copyright © 2016年 Boil Project. All rights reserved.
//

import Foundation
import AVFoundation
import UIKit

//設定画面です。
class SettingViewController: UIViewController ,AVAudioPlayerDelegate{

    // 設定メニューのオブジェクト
    private var settingImgView: UIImageView!
    private var bgmMuteBtn: UIButton!
    private var bgmVolumeSBar: UISlider!
    private var bgmImage: UIImageView!
    private var seMuteBtn: UIButton!
    private var seVolumeSBar: UISlider!
    private var seImage: UIImageView!
    
    private var tumbViewImageView: UIImageView!
    
    // view ロード完了時
    override func viewDidLoad() {
        print(NSDate().description, NSStringFromClass(self.classForCoder), __FUNCTION__, __LINE__)
        super.viewDidLoad()
        
        // ラベル等の画像
        let settingViewImage: UIImage = Utility.getUncachedImage(named: "02_03_01.png")!
        let bgmViewImage:     UIImage = Utility.getUncachedImage(named: "08_01_01.png")!
        let seViewImage:      UIImage = Utility.getUncachedImage(named: "08_02_01.png")!
        let muteViewImage:    UIImage = Utility.getUncachedImage(named: "01_10_01.png")!
        
        // スライドバーの画像
        // 画像のリサイズをする.
        let tumbViewImage: UIImage = Utility.resizeImage(
             "07_01_01.png"
            ,resizewWidth: CGFloat(view.frame.width / 10)
            ,resizeHeight: CGFloat(view.frame.height / 20))

        let minBarViewImage: UIImage = Utility.resizeImage(
             "07_02_01.png"
            ,resizewWidth: CGFloat(view.frame.width / 10)
            ,resizeHeight: CGFloat(view.frame.height / 20))

        let maxBarViewImage: UIImage = Utility.resizeImage(
             "07_02_02.png"
            ,resizewWidth: CGFloat(view.frame.width / 10)
            ,resizeHeight: CGFloat(view.frame.height / 20))
        
        //背景生成
        settingImgView = UIImageView(frame: self.view.frame)
        settingImgView.image = settingViewImage
        self.view.addSubview(settingImgView)
        
        // BGMのラベルを生成
        bgmImage = UIImageView()
        bgmImage.image = bgmViewImage
        
        // BGMのスライドバーを生成
        bgmVolumeSBar = UISlider()
        bgmVolumeSBar.setThumbImage(tumbViewImage, forState: .Normal)
        bgmVolumeSBar.setMinimumTrackImage(minBarViewImage, forState: .Normal)
        bgmVolumeSBar.setMaximumTrackImage(maxBarViewImage, forState: .Normal)
        bgmVolumeSBar.addTarget(self, action: "slideBgmVolume:", forControlEvents: .TouchUpInside)
        
        // BGMのミュートボタンを生成
        bgmMuteBtn = UIButton()
        bgmMuteBtn.setImage(muteViewImage, forState: .Normal)
        bgmMuteBtn.addTarget(self, action: "tapBgmMuteBtn:", forControlEvents: .TouchUpInside)
        
        // SEのラベルを生成
        seImage = UIImageView()
        seImage.image = seViewImage
        
        // SEのスライドバーを生成
        seVolumeSBar = UISlider()
        seVolumeSBar.setThumbImage(tumbViewImage, forState: .Normal)
        seVolumeSBar.setMinimumTrackImage(minBarViewImage, forState: .Normal)
        seVolumeSBar.setMaximumTrackImage(maxBarViewImage, forState: .Normal)
        seVolumeSBar.addTarget(self, action: "slideSeVolume:", forControlEvents: .TouchUpInside)
        
        // SEのミュートボタンを生成
        seMuteBtn = UIButton()
        seMuteBtn.setImage(muteViewImage, forState: .Normal)
        seMuteBtn.addTarget(self, action: "tapSeMuteBtn:", forControlEvents: .TouchUpInside)
        
        // Viewに追加する.
        self.view.addSubview(bgmImage)
        self.view.addSubview(bgmVolumeSBar)
        self.view.addSubview(bgmMuteBtn)
        self.view.addSubview(seImage)
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
        print(NSDate().description, NSStringFromClass(self.classForCoder), __FUNCTION__, __LINE__)
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /** 全オブジェクトの制約設定 **/
    func objConstraints() {
        print(NSDate().description, NSStringFromClass(self.classForCoder), __FUNCTION__, __LINE__)
        
        settingImgView.translatesAutoresizingMaskIntoConstraints = false
        bgmImage.translatesAutoresizingMaskIntoConstraints = false
        bgmVolumeSBar.translatesAutoresizingMaskIntoConstraints = false
        bgmMuteBtn.translatesAutoresizingMaskIntoConstraints = false
        seImage.translatesAutoresizingMaskIntoConstraints = false
        seVolumeSBar.translatesAutoresizingMaskIntoConstraints = false
        seMuteBtn.translatesAutoresizingMaskIntoConstraints = false
        
        // 壁紙の制約
        self.view.addConstraints([
            
            // x座標
            NSLayoutConstraint(
                item: self.settingImgView,
                attribute:  NSLayoutAttribute.Right,
                relatedBy: .Equal,
                toItem: self.view,
                attribute:  NSLayoutAttribute.Right,
                multiplier: 1.0,
                constant: 0
            ),
            
            // y座標
            NSLayoutConstraint(
                item: self.settingImgView,
                attribute: NSLayoutAttribute.Bottom,
                relatedBy: .Equal,
                toItem: self.view,
                attribute:  NSLayoutAttribute.Bottom,
                multiplier: 1.0,
                constant: 0
            ),
            
            // 横幅
            NSLayoutConstraint(
                item: self.settingImgView,
                attribute: .Width,
                relatedBy: .Equal,
                toItem: self.view,
                attribute: .Width,
                multiplier: 1.0,
                constant: 0
            ),
            
            // 縦幅
            NSLayoutConstraint(
                item: self.settingImgView,
                attribute: .Height,
                relatedBy: .Equal,
                toItem: self.view,
                attribute: .Height,
                multiplier: 1.0,
                constant: 0
            )]
        )
        
        // BGMラベルの制約
        self.view.addConstraints([
            
            // x座標
            NSLayoutConstraint(
                item: self.bgmImage,
                attribute:  NSLayoutAttribute.Left,
                relatedBy: .Equal,
                toItem: self.view,
                attribute:  NSLayoutAttribute.Right,
                multiplier: 0.1 / 1.0,
                constant: 0
            ),
            
            // y座標
            NSLayoutConstraint(
                item: self.bgmImage,
                attribute: NSLayoutAttribute.Top,
                relatedBy: .Equal,
                toItem: self.view,
                attribute:  NSLayoutAttribute.Bottom,
                multiplier: 0.26 / 1.0,
                constant: 0
            ),
            
            // 横幅
            NSLayoutConstraint(
                item: self.bgmImage,
                attribute: .Width,
                relatedBy: .Equal,
                toItem: self.view,
                attribute: .Width,
                multiplier: 1.0 / 6.0,
                constant: 0
            ),
            
            // 縦幅
            NSLayoutConstraint(
                item: self.bgmImage,
                attribute: .Height,
                relatedBy: .Equal,
                toItem: self.view,
                attribute: .Height,
                multiplier: 1.0 / 26.0,
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
                toItem: self.bgmImage,
                attribute:  NSLayoutAttribute.Right,
                multiplier: 1.0,
                constant: 20
            ),
            
            // y座標
            NSLayoutConstraint(
                item: self.bgmVolumeSBar,
                attribute: NSLayoutAttribute.Top,
                relatedBy: .Equal,
                toItem: self.bgmImage,
                attribute:  NSLayoutAttribute.Top,
                multiplier: 1.0,
                constant: 0
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
                multiplier: 1.1 / 1.0,
                constant: 0
            ),
            
            // y座標
            NSLayoutConstraint(
                item: self.bgmMuteBtn,
                attribute: NSLayoutAttribute.Top,
                relatedBy: .Equal,
                toItem: self.bgmImage,
                attribute:  NSLayoutAttribute.Top,
                multiplier: 1.0,
                constant: 0
            ),
            
            // 横幅
            NSLayoutConstraint(
                item: self.bgmMuteBtn,
                attribute: .Width,
                relatedBy: .Equal,
                toItem: self.view,
                attribute: .Width,
                multiplier: 1.0 / 6.0,
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
                item: self.bgmImage,
                attribute:  NSLayoutAttribute.Left,
                relatedBy: .Equal,
                toItem: self.seImage,
                attribute:  NSLayoutAttribute.Left,
                multiplier: 1.0,
                constant: 0
            ),
            
            // y座標
            NSLayoutConstraint(
                item: self.seImage,
                attribute: NSLayoutAttribute.Top,
                relatedBy: .Equal,
                toItem: self.bgmImage,
                attribute:  NSLayoutAttribute.Bottom,
                multiplier: 1.2 / 1.0,
                constant: 0
            ),
            
            // 横幅
            NSLayoutConstraint(
                item: self.seImage,
                attribute: .Width,
                relatedBy: .Equal,
                toItem: self.bgmImage,
                attribute: .Width,
                multiplier: 1.0,
                constant: 0
            ),
            
            // 縦幅
            NSLayoutConstraint(
                item: self.seImage,
                attribute: .Height,
                relatedBy: .Equal,
                toItem: self.bgmImage,
                attribute: .Height,
                multiplier: 1.0,
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
                toItem: self.seImage,
                attribute:  NSLayoutAttribute.Right,
                multiplier: 1.0,
                constant: 20
            ),
            
            // y座標
            NSLayoutConstraint(
                item: self.seVolumeSBar,
                attribute: NSLayoutAttribute.Top,
                relatedBy: .Equal,
                toItem: self.seImage,
                attribute:  NSLayoutAttribute.Top,
                multiplier: 1.0,
                constant: 0
            ),
            
            // 横幅
            NSLayoutConstraint(
                item: self.seVolumeSBar,
                attribute: .Width,
                relatedBy: .Equal,
                toItem: self.bgmVolumeSBar,
                attribute: .Width,
                multiplier: 1.0,
                constant: 0
            ),
            
            // 縦幅
            NSLayoutConstraint(
                item: self.seVolumeSBar,
                attribute: .Height,
                relatedBy: .Equal,
                toItem: self.bgmVolumeSBar,
                attribute: .Height,
                multiplier: 1.0,
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
                multiplier: 1.1 / 1.0,
                constant: 0
            ),
            
            // y座標
            NSLayoutConstraint(
                item: self.seMuteBtn,
                attribute: NSLayoutAttribute.Top,
                relatedBy: .Equal,
                toItem: self.seImage,
                attribute:  NSLayoutAttribute.Top,
                multiplier: 1.0,
                constant: 0
            ),
            
            // 横幅
            NSLayoutConstraint(
                item: self.seMuteBtn,
                attribute: .Width,
                relatedBy: .Equal,
                toItem: self.bgmMuteBtn,
                attribute: .Width,
                multiplier: 1.0,
                constant: 0
            ),
            
            // 縦幅
            NSLayoutConstraint(
                item: self.seMuteBtn,
                attribute: .Height,
                relatedBy: .Equal,
                toItem: self.bgmMuteBtn,
                attribute: .Height,
                multiplier: 1.0,
                constant: 0
            )]
        )
    }

    
    
    /** BGMボリューム変更時の処理 **/
    func slideBgmVolume(sender: AnyObject) {
        print(NSDate().description, NSStringFromClass(self.classForCoder), __FUNCTION__, __LINE__)
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
        print(NSDate().description, NSStringFromClass(self.classForCoder), __FUNCTION__, __LINE__)

        // SEを再生する.
        Utility.seSoundPlay(Const.SE_YES_PATH)

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
        print(NSDate().description, NSStringFromClass(self.classForCoder), __FUNCTION__, __LINE__)
        
        //NSUserDefaultに値を保存
        let ud = NSUserDefaults.standardUserDefaults()
        ud.setFloat(seVolumeSBar.value, forKey: "VOL_SE")
        ud.synchronize()

        Utility.seVolumeChange(seVolumeSBar.value)

    }

    /** SEミュートボタン押下時の処理 **/
    func tapSeMuteBtn(sender: AnyObject) {
        print(NSDate().description, NSStringFromClass(self.classForCoder), __FUNCTION__, __LINE__)
        Utility.seSoundPlay(Const.SE_YES_PATH)
        
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
