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
    fileprivate var settingImgView: UIImageView!
    fileprivate var bgmMuteBtn: UIButton!
    fileprivate var bgmVolumeSBar: UISlider!
    fileprivate var bgmImage: UIImageView!
    fileprivate var seMuteBtn: UIButton!
    fileprivate var seVolumeSBar: UISlider!
    fileprivate var seImage: UIImageView!
    fileprivate var tumbViewImageView: UIImageView!
    
    // view アンロード開始時
    override func viewWillDisappear(_ animated: Bool) {
        
        // SEを再生する.
        Utility.seSoundPlay(Const.SE_NO_PATH)
    }
    
    // view ロード完了時
    override func viewDidLoad() {
        print(Date().description, NSStringFromClass(self.classForCoder), #function, #line)
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
        bgmVolumeSBar.setThumbImage(tumbViewImage, for: UIControlState())
        bgmVolumeSBar.setMinimumTrackImage(minBarViewImage, for: UIControlState())
        bgmVolumeSBar.setMaximumTrackImage(maxBarViewImage, for: UIControlState())
        bgmVolumeSBar.addTarget(self, action: #selector(SettingViewController.slideBgmVolume(_:)), for: .touchUpInside)
        
        // BGMのミュートボタンを生成
        bgmMuteBtn = UIButton()
        bgmMuteBtn.setImage(muteViewImage, for: UIControlState())
        bgmMuteBtn.addTarget(self, action: #selector(SettingViewController.tapBgmMuteBtn(_:)), for: .touchUpInside)
        
        // SEのラベルを生成
        seImage = UIImageView()
        seImage.image = seViewImage
        
        // SEのスライドバーを生成
        seVolumeSBar = UISlider()
        seVolumeSBar.setThumbImage(tumbViewImage, for: UIControlState())
        seVolumeSBar.setMinimumTrackImage(minBarViewImage, for: UIControlState())
        seVolumeSBar.setMaximumTrackImage(maxBarViewImage, for: UIControlState())
        seVolumeSBar.addTarget(self, action: #selector(SettingViewController.slideSeVolume(_:)), for: .touchUpInside)
        
        // SEのミュートボタンを生成
        seMuteBtn = UIButton()
        seMuteBtn.setImage(muteViewImage, for: UIControlState())
        seMuteBtn.addTarget(self, action: #selector(SettingViewController.tapSeMuteBtn(_:)), for: .touchUpInside)
        
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
        let ud = UserDefaults.standard
        let udBGM : Float! = ud.float(forKey: "VOL_BGM")
        if udBGM != nil {
            bgmVolumeSBar.value = udBGM
        } else {
            bgmVolumeSBar.value = 0.5 //音量　初期値
        }

        let udSE : Float! = ud.float(forKey: "VOL_SE")
        if udSE != nil {
            seVolumeSBar.value = udSE
        } else {
            seVolumeSBar.value = 0.5 //音量　初期値
        }
    }
    
    //メモリ消費が多くなった時に動くイベント
    override func didReceiveMemoryWarning() {
        print(Date().description, NSStringFromClass(self.classForCoder), #function, #line)
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /** 全オブジェクトの制約設定 **/
    func objConstraints() {
        print(Date().description, NSStringFromClass(self.classForCoder), #function, #line)
        
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
                attribute:  NSLayoutAttribute.right,
                relatedBy: .equal,
                toItem: self.view,
                attribute:  NSLayoutAttribute.right,
                multiplier: 1.0,
                constant: 0
            ),
            
            // y座標
            NSLayoutConstraint(
                item: self.settingImgView,
                attribute: NSLayoutAttribute.bottom,
                relatedBy: .equal,
                toItem: self.view,
                attribute:  NSLayoutAttribute.bottom,
                multiplier: 1.0,
                constant: 0
            ),
            
            // 横幅
            NSLayoutConstraint(
                item: self.settingImgView,
                attribute: .width,
                relatedBy: .equal,
                toItem: self.view,
                attribute: .width,
                multiplier: 1.0,
                constant: 0
            ),
            
            // 縦幅
            NSLayoutConstraint(
                item: self.settingImgView,
                attribute: .height,
                relatedBy: .equal,
                toItem: self.view,
                attribute: .height,
                multiplier: 1.0,
                constant: 0
            )]
        )
        
        // BGMラベルの制約
        self.view.addConstraints([
            
            // x座標
            NSLayoutConstraint(
                item: self.bgmImage,
                attribute:  NSLayoutAttribute.left,
                relatedBy: .equal,
                toItem: self.view,
                attribute:  NSLayoutAttribute.right,
                multiplier: 0.1 / 1.0,
                constant: 0
            ),
            
            // y座標
            NSLayoutConstraint(
                item: self.bgmImage,
                attribute: NSLayoutAttribute.top,
                relatedBy: .equal,
                toItem: self.view,
                attribute:  NSLayoutAttribute.bottom,
                multiplier: 0.26 / 1.0,
                constant: 0
            ),
            
            // 横幅
            NSLayoutConstraint(
                item: self.bgmImage,
                attribute: .width,
                relatedBy: .equal,
                toItem: self.view,
                attribute: .width,
                multiplier: 1.0 / 6.0,
                constant: 0
            ),
            
            // 縦幅
            NSLayoutConstraint(
                item: self.bgmImage,
                attribute: .height,
                relatedBy: .equal,
                toItem: self.view,
                attribute: .height,
                multiplier: 1.0 / 26.0,
                constant: 0
            )]
        )
        
        // BGMボリュームバーの制約
        self.view.addConstraints([
            
            // x座標
            NSLayoutConstraint(
                item: self.bgmVolumeSBar,
                attribute:  NSLayoutAttribute.left,
                relatedBy: .equal,
                toItem: self.bgmImage,
                attribute:  NSLayoutAttribute.right,
                multiplier: 1.0,
                constant: 20
            ),
            
            // y座標
            NSLayoutConstraint(
                item: self.bgmVolumeSBar,
                attribute: NSLayoutAttribute.top,
                relatedBy: .equal,
                toItem: self.bgmImage,
                attribute:  NSLayoutAttribute.top,
                multiplier: 1.0,
                constant: 0
            ),
            
            // 横幅
            NSLayoutConstraint(
                item: self.bgmVolumeSBar,
                attribute: .width,
                relatedBy: .equal,
                toItem: self.view,
                attribute: .width,
                multiplier: 1.0 / 3.0,
                constant: 0
            ),
            
            // 縦幅
            NSLayoutConstraint(
                item: self.bgmVolumeSBar,
                attribute: .height,
                relatedBy: .equal,
                toItem: self.view,
                attribute: .height,
                multiplier: 1.0 / 24.0,
                constant: 0
            )]
        )
        
        // BGMミュートボタンの制約
        self.view.addConstraints([
            
            // x座標
            NSLayoutConstraint(
                item: self.bgmMuteBtn,
                attribute:  NSLayoutAttribute.left,
                relatedBy: .equal,
                toItem: self.bgmVolumeSBar,
                attribute:  NSLayoutAttribute.right,
                multiplier: 1.1 / 1.0,
                constant: 0
            ),
            
            // y座標
            NSLayoutConstraint(
                item: self.bgmMuteBtn,
                attribute: NSLayoutAttribute.top,
                relatedBy: .equal,
                toItem: self.bgmImage,
                attribute:  NSLayoutAttribute.top,
                multiplier: 1.0,
                constant: 0
            ),
            
            // 横幅
            NSLayoutConstraint(
                item: self.bgmMuteBtn,
                attribute: .width,
                relatedBy: .equal,
                toItem: self.view,
                attribute: .width,
                multiplier: 1.0 / 6.0,
                constant: 0
            ),
            
            // 縦幅
            NSLayoutConstraint(
                item: self.bgmMuteBtn,
                attribute: .height,
                relatedBy: .equal,
                toItem: self.view,
                attribute: .height,
                multiplier: 1.0 / 24.0,
                constant: 0
            )]
        )
        
        // SEラベルの制約
        self.view.addConstraints([
            
            // x座標
            NSLayoutConstraint(
                item: self.bgmImage,
                attribute:  NSLayoutAttribute.left,
                relatedBy: .equal,
                toItem: self.seImage,
                attribute:  NSLayoutAttribute.left,
                multiplier: 1.0,
                constant: 0
            ),
            
            // y座標
            NSLayoutConstraint(
                item: self.seImage,
                attribute: NSLayoutAttribute.top,
                relatedBy: .equal,
                toItem: self.bgmImage,
                attribute:  NSLayoutAttribute.bottom,
                multiplier: 1.2 / 1.0,
                constant: 0
            ),
            
            // 横幅
            NSLayoutConstraint(
                item: self.seImage,
                attribute: .width,
                relatedBy: .equal,
                toItem: self.bgmImage,
                attribute: .width,
                multiplier: 1.0,
                constant: 0
            ),
            
            // 縦幅
            NSLayoutConstraint(
                item: self.seImage,
                attribute: .height,
                relatedBy: .equal,
                toItem: self.bgmImage,
                attribute: .height,
                multiplier: 1.0,
                constant: 0
            )]
        )
        
        // SEボリュームバーの制約
        self.view.addConstraints([
            
            // x座標
            NSLayoutConstraint(
                item: self.seVolumeSBar,
                attribute:  NSLayoutAttribute.left,
                relatedBy: .equal,
                toItem: self.seImage,
                attribute:  NSLayoutAttribute.right,
                multiplier: 1.0,
                constant: 20
            ),
            
            // y座標
            NSLayoutConstraint(
                item: self.seVolumeSBar,
                attribute: NSLayoutAttribute.top,
                relatedBy: .equal,
                toItem: self.seImage,
                attribute:  NSLayoutAttribute.top,
                multiplier: 1.0,
                constant: 0
            ),
            
            // 横幅
            NSLayoutConstraint(
                item: self.seVolumeSBar,
                attribute: .width,
                relatedBy: .equal,
                toItem: self.bgmVolumeSBar,
                attribute: .width,
                multiplier: 1.0,
                constant: 0
            ),
            
            // 縦幅
            NSLayoutConstraint(
                item: self.seVolumeSBar,
                attribute: .height,
                relatedBy: .equal,
                toItem: self.bgmVolumeSBar,
                attribute: .height,
                multiplier: 1.0,
                constant: 0
            )]
        )
        
        // SEミュートボタンの制約
        self.view.addConstraints([
            
            // x座標
            NSLayoutConstraint(
                item: self.seMuteBtn,
                attribute:  NSLayoutAttribute.left,
                relatedBy: .equal,
                toItem: self.seVolumeSBar,
                attribute:  NSLayoutAttribute.right,
                multiplier: 1.1 / 1.0,
                constant: 0
            ),
            
            // y座標
            NSLayoutConstraint(
                item: self.seMuteBtn,
                attribute: NSLayoutAttribute.top,
                relatedBy: .equal,
                toItem: self.seImage,
                attribute:  NSLayoutAttribute.top,
                multiplier: 1.0,
                constant: 0
            ),
            
            // 横幅
            NSLayoutConstraint(
                item: self.seMuteBtn,
                attribute: .width,
                relatedBy: .equal,
                toItem: self.bgmMuteBtn,
                attribute: .width,
                multiplier: 1.0,
                constant: 0
            ),
            
            // 縦幅
            NSLayoutConstraint(
                item: self.seMuteBtn,
                attribute: .height,
                relatedBy: .equal,
                toItem: self.bgmMuteBtn,
                attribute: .height,
                multiplier: 1.0,
                constant: 0
            )]
        )
    }

    
    
    /** BGMボリューム変更時の処理 **/
    func slideBgmVolume(_ sender: AnyObject) {
        print(Date().description, NSStringFromClass(self.classForCoder), #function, #line)
        // スライド値をBGM音量にセットする
//        myAudioPlayer.volume = bgmVolumeSBar.value
        
        //NSUserDefaultに値を保存
        let ud = UserDefaults.standard
        ud.set(bgmVolumeSBar.value, forKey: "VOL_BGM")
        ud.synchronize()
        
        Utility.bgmVolumeChange(bgmVolumeSBar.value)
        
    }

    /** BGMミュートボタン押下時の処理 **/
    func tapBgmMuteBtn(_ sender: AnyObject) {
        print(Date().description, NSStringFromClass(self.classForCoder), #function, #line)

        // SEを再生する.
        Utility.seSoundPlay(Const.SE_YES_PATH)

        // ミュート切り替え
        if bgmVolumeSBar.value == 0.0 {
            bgmVolumeSBar.value = 0.5
        } else {
            bgmVolumeSBar.value = 0.0
        }

        //NSUserDefaultに値を保存
        let ud = UserDefaults.standard
        ud.set(bgmVolumeSBar.value, forKey: "VOL_BGM")
        ud.synchronize()
        
        Utility.bgmVolumeChange(bgmVolumeSBar.value)
        
    }
    
    
    /** SEボリューム変更時の処理 **/
    func slideSeVolume(_ sender: AnyObject) {
        print(Date().description, NSStringFromClass(self.classForCoder), #function, #line)
        
        //NSUserDefaultに値を保存
        let ud = UserDefaults.standard
        ud.set(seVolumeSBar.value, forKey: "VOL_SE")
        ud.synchronize()

        Utility.seVolumeChange(seVolumeSBar.value)

    }

    /** SEミュートボタン押下時の処理 **/
    func tapSeMuteBtn(_ sender: AnyObject) {
        print(Date().description, NSStringFromClass(self.classForCoder), #function, #line)
        Utility.seSoundPlay(Const.SE_YES_PATH)
        
        if seVolumeSBar.value == 0.0 {
            seVolumeSBar.value = 0.5
        } else {
            seVolumeSBar.value = 0.0
        
        }
    
        //NSUserDefaultに値を保存
        let ud = UserDefaults.standard
        ud.set(seVolumeSBar.value, forKey: "VOL_SE")
        ud.synchronize()
        
        // SEを再生する.
        Utility.seVolumeChange(seVolumeSBar.value)

    }
    
}
